{ pkgs, config, ... }:
{
  package.operaton.port = 8800;
  package.operaton.deployment = ./bpmn;

  processes = {
    backend.exec = "make -C backend start";
  };

  services.vault = {
    enable = true;
    disableMlock = true;
    ui = true;
  };

  processes.vault-configure-kv.exec = let configureScript = pkgs.writeShellScriptBin "configure-vault-kv" ''
    set -euo pipefail

    # Wait for the vault server to start up
    response=""
    while [ -z "$response" ]; do
      response=$(${pkgs.curl}/bin/curl -s --max-time 5 "${config.env.VAULT_API_ADDR}/v1/sys/init" | ${pkgs.jq}/bin/jq '.initialized' || true)
      if [ -z "$response" ]; then
        echo "Waiting for vault server to respond..."
        sleep 1
      fi
    done
    while [ ! -f "${config.env.DEVENV_STATE}/env_file" ]; do
        sleep 1s
    done

    # Export VAULT_TOKEN
    source ${config.env.DEVENV_STATE}/env_file

    # Ensure /kv/secret
    if ! ${pkgs.vault-bin}/bin/vault secrets list | grep -q '^secret/'; then
      ${pkgs.vault-bin}/bin/vault secrets enable -path=secret kv-v2
    fi
  ''; in "${configureScript}/bin/configure-vault-kv";

  services.caddy = {
    enable = true;
    config = ''
      {
        admin off
      }
      :8000 {
        ${if (config.env ? CODESPACE_NAME && config.env.CODESPACE_NAME != "") then ''
        rewrite /VirtualHostBase/https/${config.env.CODESPACE_NAME}-8000.${config.env.GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}:443/Plone/VirtualHostRoot{uri}
        '' else ''
        rewrite /VirtualHostBase/http/localhost:8000/Plone/VirtualHostRoot{uri}
        ''}
        reverse_proxy localhost:8080
      }
    '';
  };

  process.managers.process-compose.settings.environment = [
    "SERVER_USE_FORWARD_HEADERS=true"
    "SERVER_FORWARD_HEADERS_STRATEGY=native"
  ];

  tasks = {
    "bash:shell:install" = {
      exec = ''
        UV_PROJECT_ENVIRONMENT=$(pwd)/.venv
        UV_PYTHON_DOWNLOADS=never
        UV_PYTHON_PREFERENCE=system
        uv sync
      '';
      before = [
        "devenv:enterShell"
      ];
    };
  };

  languages.python = {
    enable = true;
    package = pkgs.python312;
    uv = {
      enable = true;
      package = pkgs.uv;
    };
  };

  packages = [
    pkgs.gnugrep
    pkgs.procps
    pkgs.vault
    pkgs.vim
  ];

  enterShell = ''
    export UV_PROJECT_ENVIRONMENT=$(pwd)/.venv
    export UV_PYTHON_DOWNLOADS=never
    export UV_PYTHON_PREFERENCE=system
    export ENGINE_REST_BASE_URL=http://localhost:8800/engine-rest
    [ -f "${config.env.DEVENV_STATE}/env_file" ] && source ${config.env.DEVENV_STATE}/env_file
  '';

  cachix.pull = [ "datakurre" ];

  dotenv.enable = true;
}
