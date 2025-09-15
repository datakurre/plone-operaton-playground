{
  tasks = {
    "bash:backend:install" = {
      exec = ''
        UV_PROJECT_ENVIRONMENT=$(pwd)/backend/.venv
        UV_PYTHON_DOWNLOADS=never
        UV_PYTHON_PREFERENCE=system
        if [[ ! -e backend/instance ]]; then
          make -C backend install
          make -C backend create-site
        fi
      '';
      before = [
        "devenv:enterShell"
      ];
    };
  };
}
