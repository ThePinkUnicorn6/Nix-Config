{ lib, fetchFromGitHub, trivialBuild, ... }:

trivialBuild {
  pname = "ultra-scroll";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "ultra-scroll";
    rev = "2c517bf9b61bf432f706ff8a585ba453c7476be2";
    sha256 = "sha256-U2QTbxkch/oGdXXnzf2EPX3Ga3VYmQlnjC/JKBq5DEI=";
  };

  meta = with lib; {
    description = "Minor mode for smooth scrolling and in-place scrolling.";
    homepage = "https://github.com/jdtsmith/ultra-scroll";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
