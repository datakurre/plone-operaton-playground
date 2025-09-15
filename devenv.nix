{ pkgs, config, ... }:
{
  package.operaton.port = 8800;
  package.operaton.deployment = ./bpmn;
  processes = {
    backend.exec = "make -C backend start";
  };

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
    package = pkgs.python311;
    uv = {
      enable = true;
      package = pkgs.uv;
    };
  };

  enterShell = ''
    export UV_PROJECT_ENVIRONMENT=$(pwd)/.venv
    export UV_PYTHON_DOWNLOADS=never
    export UV_PYTHON_PREFERENCE=system
    export ENGINE_REST_BASE_URL=http://localhost:8800/engine-rest
  '';

  cachix.pull = [ "datakurre" ];

  dotenv.enable = true;
}
