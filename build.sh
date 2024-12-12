#!/bin/sh -e
cd src

make clean
make COMP=emscripten ARCH=js build -B -j2
cat ../preamble.js stockfish.js > ../stockfish.js

make clean
make COMP=emscripten ARCH=wasm build -B -j2
uglifyjs --compress --mangle -- stockfish.js | cat ../preamble.js - > ../stockfish.wasm.js
cp stockfish.wasm ../stockfish.wasm

cd ..
