{ pkgs, config, ... }:
{
  dotenv.enable = true;

  package.operaton.port = 8800;
  package.operaton.deployment = ./bpmn;

  services.caddy = {
    enable = true;
    config = ''
      {
        admin off
      }
      :8000 {
        handle_path "/operaton*" {
          rewrite * /operaton{uri}
          reverse_proxy localhost:8800
        }
        @notOperaton not path /operaton*
        ${if (config.env ? CODESPACE_NAME && config.env.CODESPACE_NAME != "") then ''
        rewrite @notOperaton /VirtualHostBase/https/${config.env.CODESPACE_NAME}-8000.${config.env.GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}:443/Plone/VirtualHostRoot{uri}
        '' else ''
        rewrite @notOperaton /VirtualHostBase/http/localhost:8000/Plone/VirtualHostRoot{uri}
        ''}
        reverse_proxy localhost:8080
      }
    '';
  };

  processes = {
    backend.exec = "make -C backend start";
  };

  process.managers.process-compose.settings.environment = [];

  # See full reference at https://devenv.sh/reference/options/
}
