{ pkgs, config, ... }:
{
  dotenv.enable = true;

  services.caddy = {
    enable = true;
    config = ''
      {
        admin off
      }
      :8000 {
        handle_path "/++api++*" {
          rewrite * /VirtualHostBase/https/${config.env.CODESPACE_NAME}-8000.${config.env.GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}:443/Plone/++api++/VirtualHostRoot{uri}
          reverse_proxy localhost:8080
        }
        handle_path "/api*" {
          rewrite * /VirtualHostBase/https/${config.env.CODESPACE_NAME}-8000.${config.env.GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}:443/Plone/VirtualHostRoot/_vh_api{uri}
          reverse_proxy localhost:8080
        }
      }
    '';
  };

  processes = {
    backend.exec = "make -C backend start";
  };

  process.managers.process-compose.settings.environment = [
  ];

  # See full reference at https://devenv.sh/reference/options/
}
