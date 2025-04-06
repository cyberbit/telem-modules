#!/bin/bash

echo 'building Luz...'
luacc luz -o bin/luz.comp.lua -i src/luz compress decompress lex LibDeflate lz77 maketree minify token_decode_tree token_encode_map

# echo 'squishing...'
luamin -f bin/luz.comp.lua > bin/luzc.lua

rm bin/luz.comp.lua