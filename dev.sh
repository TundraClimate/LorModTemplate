#!/bin/bash

cd $(dirname $0)
source "$PWD/.env"
source "$PWD/usr.sh"

"$PWD/build.sh"

mv "$PWD/src/$ID.dll" "$PWD/Invitation/Assemblies/$ID.dll"
