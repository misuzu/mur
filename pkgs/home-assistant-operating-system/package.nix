{
  stdenv,
  lib,
  fetchurl,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "home-assistant-operating-system";
  version = finalAttrs.passthru.sources.version;

  src = fetchurl (
    finalAttrs.passthru.sources.${stdenv.hostPlatform.system}
      or (throw "Unsupported system: ${stdenv.hostPlatform.system}")
  );

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    ln -s $src $out
    runHook postInstall
  '';

  passthru = {
    sources = builtins.fromJSON (builtins.readFile ./src.json);
    updateScript = ./update.sh;
  };

  meta = {
    description = "Home Assistant Operating System";
    homepage = "https://github.com/home-assistant/operating-system";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ misuzu ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
