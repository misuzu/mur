{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zerofs";
  version = "0.17.1";

  src = fetchFromGitHub {
    owner = "Barre";
    repo = "ZeroFS";
    tag = "v${version}";
    hash = "sha256-4Tc0GQjThXLGt0S6C8UYr0Mw5AwzPvO/BmuXS+a8OAE=";
  };

  sourceRoot = "${src.name}/zerofs";

  cargoHash = "sha256-PQAjJYYzEIRylz0Ks5/EuZYCf8TFX3+R+1x0pQ7ypbo=";

  meta = {
    description = "The Filesystem That Makes S3 your Primary Storage. ZeroFS is 9P/NFS/NBD on top of S3.";
    homepage = "https://github.com/Barre/ZeroFS";
    license = lib.licenses.agpl3Plus;
    mainProgram = "zerofs";
    maintainers = with lib.maintainers; [ misuzu ];
    platforms = lib.platforms.unix;
  };
}
