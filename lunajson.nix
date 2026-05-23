{
  buildLuarocksPackage,
  fetchFromGitHub,
  fetchurl,
  luaOlder,
}:
buildLuarocksPackage {
  pname = "lunajson";
  version = "1.2.3-1";
  knownRockspec =
    (fetchurl {
      url = "mirror://luarocks/lunajson-1.2.3-1.rockspec";
      sha256 = "1zqjyd90skjhmbmrisxrlsx1wzckrxg66ha3yf2dp71p6hnblfbp";
    }).outPath;
  src = fetchFromGitHub {
    owner = "grafi-tt";
    repo = "lunajson";
    tag = "1.2.3";
    hash = "sha256-LZipetkhtScHhI78OFLVkEjpQyvdkbMM0Y2TGFQ7dvg=";
  };

  disabled = luaOlder "5.1";

  meta = {
    homepage = "https://github.com/grafi-tt/lunajson";
    license.fullName = "MIT/X11";
    description = "A strict and fast JSON parser/decoder/encoder written in pure Lua";
    longDescription = ''
      Lunajson features SAX-style JSON parser and simple JSON decoder/encoder. It is tested on Lua 5.1, Lua 5.2, Lua 5.3, and LuaJIT 2.0.
      		It is written only in pure Lua and has no dependencies. Even so, decoding speed matches lpeg-based JSON implementations because it is carefully optimized.
      		The parser and decoder reject input that is not conformant to the JSON specification (ECMA-404), and the encoder always yields conformant output.
      		The parser and decoder also handle UTF/Unicode surrogate pairs correctly.
      	'';
  };
}
