{
  lib,
  stdenv,
  fetchFromGitLab,
  qtbase,
  openrgb,
  glib,
  qmake,
  pkg-config,
  wrapQtAppsHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "openrgb-plugin-visual-map";
  version = "0.9";

  src = fetchFromGitLab {
    owner = "OpenRGBDevelopers";
    repo = "OpenRGBVisualMapPlugin";
    rev = "release_${finalAttrs.version}";
    hash = "sha256-xs+n39zT3ypn7itucRccxsxSvF/HtzSZETIFZwbPbMQ=";
  };

  postPatch = ''
    # Use the source of openrgb from nixpkgs instead of the submodule
    rm -r OpenRGB
    ln -s ${openrgb.src} OpenRGB
  '';
  
  buildInputs = [
    qtbase
    glib
  ];
  
  nativeBuildInputs = [
    qmake
    pkg-config
    wrapQtAppsHook
  ];
  installPhase = ''
    mkdir -p $out/lib/
    cp libOpenRGBVisualMapPlugin.so.1.0.0 $out/lib/
  '';
  meta = with lib; {
    homepage = "https://gitlab.com/OpenRGBDevelopers/OpenRGBVisualMapPlugin";
    description = "Visual Map plugin for OpenRGB";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ ThePinkUnicorn ];
    platforms = platforms.linux;
  };
})
