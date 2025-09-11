{ pkgs, ... }:
{
  enterShell = ''
    export ENGINE_REST_BASE_URL=http://localhost:8800/engine-rest
  '';
}
