{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zerofs";
  version = "0.15.6";

  src = fetchFromGitHub {
    owner = "Barre";
    repo = "ZeroFS";
    tag = "v${version}";
    hash = "sha256-RVcPnVlNCU1gj1lvzmLVCiGcnXxKDtmdnKmrQJ4IrQ0=";
  };

  sourceRoot = "${src.name}/zerofs";

  cargoHash = "sha256-kn1tZ4kbFcJwBEbFR0g3+lP+8trVMAa0QCBJJ107pYQ=";

  meta = {
    description = "The Filesystem That Makes S3 your Primary Storage. ZeroFS is 9P/NFS/NBD on top of S3.";
    homepage = "https://github.com/Barre/ZeroFS";
    license = lib.licenses.agpl3Plus;
    mainProgram = "zerofs";
    maintainers = with lib.maintainers; [ misuzu ];
    platforms = lib.platforms.unix;
  };
}
