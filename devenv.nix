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
          rewrite * /VirtualHostBase/http/localhost:8000/Plone/++api++/VirtualHostRoot{uri}
          reverse_proxy localhost:8080
        }
        handle_path "/api*" {
          rewrite * /VirtualHostBase/http/localhost:8000/Plone/VirtualHostRoot/_vh_api{uri}
          reverse_proxy localhost:8080
        }
        reverse_proxy http://localhost:5173
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
