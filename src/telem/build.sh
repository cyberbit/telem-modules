#!/bin/bash

workdir=$PWD

mkdir -p dist/modules

# glob the star
shopt -s globstar

for module in $(ls -d src/telem/modules/*/ 2> /dev/null | sed 's/src\/telem\/modules\///;s/\/$//'); do
    echo $module
    outpath=${2:-$workdir/dist/modules/$module.lua}
    
    echo "building $module..."
    luacc $module.init -o $outpath -i src/telem/modules $(for i in src/telem/modules/$module/**/*.lua; do [[ $i != "$module/init.lua" ]] && echo $i; done | sed "y/\//./;s/\.lua$//")

    echo 'packing...'

    # curl -so- https://raw.githubusercontent.com/cyberbit/telem-modules/refs/heads/main/bin/luzc.lua | lua - $outpath ${outpath%.lua}.luz
    lua bin/luzc.lua $outpath ${outpath%.lua}.luz
done