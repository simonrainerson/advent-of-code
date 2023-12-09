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

  scripts.check.exec = ''
    cd "$DEVENV_ROOT/advent_of_code"
    echo "👀 Checking formatting..."
    mix format --check-formatted
    format_result=$?
    echo "⚗ Running tests..."
    mix test
    test_result=$?
    exit $((format_result + test_resutl))
  '';

  languages = {
    nix.enable = true;

    elixir = {
      enable = true;
      package = pkgs.beam.packages.erlang.elixir;
    };
  };
}
