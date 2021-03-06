{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "rep";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "eraserhd";
    repo = pname;
    rev = "v${version}";
    sha256 = "";
  };

  nativeBuildInputs = [];

  postPatch = ''
    substituteInPlace rc/rep.kak --replace '$(rep' '$('"$out/bin/rep"
  '';
  makeFlags = [ "prefix=$(out)" ];

  meta = with stdenv.lib; {
    description = "Single-shot nREPL client";
    homepage = "https://github.com/eraserhd/rep";
    license = licenses.epl10;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}
