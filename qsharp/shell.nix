# TODO: Turn this into a flake with multiple devShells as outputs
#
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {} }:

let
  fenix = import (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz") {};
in
pkgs.mkShell {
  name = "qsharp-dev";

  nativeBuildInputs = [
    # rust toolchain
    # prefer fenix but wasm32-unknown-unknown won't build
    # use fenix after figuring out how to configure
    # fenix.stable.defaultToolchain
    pkgs.rustup
    pkgs.pkg-config
    pkgs.clang

    # qsharp build dependencies
    pkgs.python311
    pkgs.nodejs_20
    pkgs.wasm-pack
  ];

  buildInputs = with pkgs; [
    # build dependencies
    openssl.dev
    libiconv
    libffi
  ] ++ lib.optionals stdenv.isDarwin [darwin.apple_sdk.frameworks.Security];

  shellHook = ''
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
  '';
}