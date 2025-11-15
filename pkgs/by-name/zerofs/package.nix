{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "zerofs";
  version = "0.16.9";

  src = fetchFromGitHub {
    owner = "Barre";
    repo = "ZeroFS";
    tag = "v${version}";
    hash = "sha256-mFZYhrBoQvwcMB+ZQ/PW7QiGYU7Z49J5JyVijd7ywIs=";
  };

  sourceRoot = "${src.name}/zerofs";

  cargoHash = "sha256-DOFjAWO+JpUEtFKS7phnIgkrKI3QNJIlYepoUcAU8eA=";

  meta = {
    description = "The Filesystem That Makes S3 your Primary Storage. ZeroFS is 9P/NFS/NBD on top of S3.";
    homepage = "https://github.com/Barre/ZeroFS";
    license = lib.licenses.agpl3Plus;
    mainProgram = "zerofs";
    maintainers = with lib.maintainers; [ misuzu ];
    platforms = lib.platforms.unix;
  };
}
