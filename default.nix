{ pkgs ? import <nixpkgs> {} , unstable ? import (builtins.fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz) {}}:
with pkgs;
stdenv.mkDerivation rec {
  name = "wetcd";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    unstable.python27Packages.docker_compose
  ];
}
