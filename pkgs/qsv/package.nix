{
  stdenv,
  fetchFromGitHub,
  file,
  lib,
  pkg-config,
  rustPlatform,
  sqlite,
  zstd,
  cmake,
  python3,
  wayland,
  withPolars ? true,
  withPython ? stdenv.buildPlatform == stdenv.hostPlatform,
  withUi ? true,
  buildFeatures ?
    # enable all features except self_update by default
    # https://github.com/dathere/qsv/blob/7.1.0/Cargo.toml#L370
    [
      "apply"
      "feature_capable"
      "fetch"
      "foreach"
      "geocode"
      "luau"
      "to"
    ]
    ++ lib.optional withPolars "polars"
    ++ lib.optional withPython "python"
    ++ lib.optional withUi "ui",
  mainProgram ? "qsv",
}:

let
  pname = "qsv";
  version = "8.0.0";
in
rustPlatform.buildRustPackage {
  inherit pname version buildFeatures;

  src = fetchFromGitHub {
    owner = "dathere";
    repo = "qsv";
    rev = version;
    hash = "sha256-H3FsXroIL/cxV32V7V4g/1rmNM0o0tYKe7vZ5yet5Jk=";
  };

  cargoHash = "sha256-4oHeWgmd4OOEOK4/Vwdph5SSEW4RNtltm89XedikEG4=";

  buildInputs = [
    file
    sqlite
    zstd
  ]
  ++ lib.optional (lib.elem "ui" buildFeatures && stdenv.hostPlatform.isLinux) wayland;

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
    cmake
  ]
  ++ lib.optional (lib.elem "python" buildFeatures) python3;

  doCheck = false;

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "CSVs sliced, diced & analyzed";
    homepage = "https://github.com/dathere/qsv";
    changelog = "https://github.com/dathere/qsv/blob/${version}/CHANGELOG.md";
    license = with lib.licenses; [
      mit
      # or
      unlicense
    ];
    mainProgram = mainProgram;
    maintainers = with lib.maintainers; [
      misuzu
    ];
  };
}
