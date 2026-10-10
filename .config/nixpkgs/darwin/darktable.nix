# Official darktable macOS release. The Homebrew cask is disabled because the app is not notarized,
# and the nixpkgs package does not include an app bundle.
{ stdenvNoCC, fetchurl, undmg }:

stdenvNoCC.mkDerivation rec {
  pname = "darktable";
  version = "5.6.2";

  src = fetchurl {
    url = "https://github.com/darktable-org/darktable/releases/download/release-${version}/darktable-${version}-arm64.dmg";
    hash = "sha256-b/iOWKKlnLB7ChUC/qcgXmjNeDOAozo8572mjsKd7ww=";
  };

  nativeBuildInputs = [ undmg ];
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -R darktable.app $out/Applications/
    runHook postInstall
  '';

  # Do not modify the binaries, which keep their upstream ad-hoc signatures. The signature of
  # Contents/MacOS/subr.sh is lost because the Nix store does not keep extended attributes. This is
  # not a problem because Gatekeeper does not check the bundle seal of non-quarantined apps.
  dontFixup = true;
}
