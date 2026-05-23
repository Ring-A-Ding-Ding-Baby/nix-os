{
  buildLuarocksPackage,
  fetchurl,
  fetchzip,
  luaAtLeast,
  luaOlder,
  pkgs,
}:
buildLuarocksPackage {
  pname = "lua-curl";
  version = "0.3.13-1";
  knownRockspec =
    (fetchurl {
      url = "mirror://luarocks/lua-curl-0.3.13-1.rockspec";
      sha256 = "0lz534sm35hxazf1w71hagiyfplhsvzr94i6qyv5chjfabrgbhjn";
    }).outPath;
  src = fetchzip {
    url = "https://github.com/Lua-cURL/Lua-cURLv3/archive/v0.3.13.zip";
    sha256 = "0gn59bwrnb2mvl8i0ycr6m3jmlgx86xlr9mwnc85zfhj7zhi5anp";
  };

  disabled = luaOlder "5.1" || luaAtLeast "5.5";
  buildInputs = with pkgs; [
    curl
    luaPackages.lua-curl
  ];
  nativeBuildInputs = with pkgs; [
    curl
    luaPackages.lua-curl
  ];
  propagatedBuildInputs = with pkgs; [
    #luaPackages.lua-curl
    #curl
  ];
  meta = {
    homepage = "https://github.com/Lua-cURL";
    license.fullName = "MIT/X11";
    description = "Lua binding to libcurl";
    longDescription = "";
  };
}
