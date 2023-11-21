{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {} }:

let
  fenix = import (fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz") {};
in
pkgs.mkShell {
  name = "rust-dev";

  nativeBuildInputs = [
    # rust toolchain
    fenix.stable.defaultToolchain
    pkgs.pkg-config
    pkgs.clang # sometimes may need C compiler
  ];

  buildInputs = with pkgs; [
    which

    openssl.dev
    libiconv
  ] ++ lib.optionals stdenv.isDarwin [darwin.apple_sdk.frameworks.Security darwin.apple_sdk.frameworks.SystemConfiguration];

  shellHook = ''
    export LIBCLANG_PATH="${pkgs.libclang.lib}/lib";
    echo "🦀🎉🦀🎉🦀🎉🦀🎉🦀🎉🦀🎉🦀🎉🦀🎉🦀🎉🦀";
  '';
}
