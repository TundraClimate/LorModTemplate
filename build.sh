#!/bin/bash

cd $(dirname $0)
source "$PWD/.env"
source "$PWD/usr.sh"

wine "$MSBUILD" ".\\src\\$ID.csproj" /t:Build /p:Configuration=Debug /p:Platform="Any CPU" /p:OutputPath=bin\\Debug /nologo

mv "$PWD/src/bin/Debug/$ID.dll" "$PWD/src/$ID.dll"
