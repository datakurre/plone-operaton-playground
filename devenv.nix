{ pkgs, config, ... }:
{
  package.operaton.port = 8081;
  package.operaton.deployment = ./bpmn;
  processes = {
    backend.exec = "make -C backend start";
  };

  process.managers.process-compose.settings.environment = [];

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
    export ENGINE_REST_BASE_URL=http://localhost:8081/engine-rest
  '';

  cachix.pull = [ "datakurre" ];
  dotenv.disableHint = true;
}
