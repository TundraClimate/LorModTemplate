#!/bin/bash

cd $(dirname $0)

source "$PWD/.env"

wine "$MSBUILD" ".\\src\\$ID.csproj"

mv "$PWD/src/bin/Debug/$ID.dll" "$PWD/src/$ID.dll"
