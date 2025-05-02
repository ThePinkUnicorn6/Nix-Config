{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "kinect-udev-rules";
  version = "0.7.5";

  src = fetchFromGitHub {
    owner = "OpenKinect";
    repo = "libfreenect";
    rev = "v${version}";
    sha256 = "sha256-PpJGFWrlQ5sK7TJxQNoPujw1MxWRjphvblwOqnF+mSg=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -D ./platform/linux/udev/51-kinect.rules $out/lib/udev/rules.d/51-kinect.rules

    runHook postInstall
  '';

  meta = {
    description = "Udev rules for the Xbox Kinect device on Windows, Linux, and macOS";
    homepage = "http://openkinect.org";
    license = with lib.licenses; [
      gpl2
      asl20
    ];
    maintainers = with lib.maintainers; [ ThePinkUnicorn ];
    platforms = with lib.platforms; linux ++ darwin;
  };
}
