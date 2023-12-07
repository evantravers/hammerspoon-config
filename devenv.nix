{ pkgs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.lua-language-server ];

  enterShell = ''
  '';

  languages.lua.enable = true;
}
