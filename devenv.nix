{ pkgs, ... }:
{
  packages = [
    pkgs.git
    pkgs.elixir-ls
  ];

  env = {
    ELIXIR_ERL_OPTIONS="+fnu";
  };

  enterShell = ''
    cd advent_of_code
  '';

  languages = {
    nix.enable = true;

    elixir = {
      enable = true;
      package = pkgs.beam.packages.erlang.elixir;
    };
  };
}
