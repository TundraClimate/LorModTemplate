#!/bin/bash

cd $(dirname $0)
source "$PWD/.env"
source "$PWD/usr.sh"

dotnet build ".\\src\\$ID.csproj" -c Debug -nologo

mv "$PWD/src/bin/Debug/net48/$ID.dll" "$PWD/src/$ID.dll"
