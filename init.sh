#!/bin/bash

cd $(dirname $0)
source "$PWD/.env"

echo "INITIALIZED ENV"

if [ ! -d "$LOR_MOD_DIR/$ID" ]; then
	ln -s "$PWD/Invitation" "$LOR_MOD_DIR/$ID"

	echo "SYMLINK CREATED"
else
	echo "SYMLINK ALREADY CREATED"
fi

if [ ! -d "$PWD/src/libs/" ]; then
	mkdir -p "$PWD/src/libs/"
	cp "$LOR_DATA_DIR/System.dll" "$PWD/src/libs/System.dll"
	cp "$LOR_DATA_DIR/System.Core.dll" "$PWD/src/libs/System.Core.dll"
	cp "$LOR_DATA_DIR/mscorlib.dll" "$PWD/src/libs/mscorlib.dll"
	cp "$LOR_DATA_DIR/Assembly-CSharp.dll" "$PWD/src/libs/Assembly-CSharp.dll"

	echo "LOCAL ASSEMBLIES SUCCESSFULLY COPIED"
else
	echo "LOCAL ASSEMBLIES ALREADY COPIED"
fi

if [ -e "$PWD/src/.csproj" ]; then
	mv "$PWD/src/.csproj" "$PWD/src/$ID.csproj"

	sed -i "s/__MODNAME__/$ID/g" "$PWD/src/Init.cs"
	sed -i "s/__MODNAME__/$ID/g" "$PWD/src/PatchClass.cs"
	sed -i "s/__MODNAME__/$ID/g" "$PWD/src/$ID.csproj"
	sed -i "s/__MODNAME__/$ID/g" "$PWD/Invitation/StageModInfo.xml"
	sed -i "s/__TITLE__/$WORKSHOP_TITLE/g" "$PWD/Invitation/StageModInfo.xml"
	sed -i "s/__DESC__/$WORKSHOP_DESC/g" "$PWD/Invitation/StageModInfo.xml"
	sed -i "s/__THUMBNAIL__/$WORKSHOP_THUMBNAIL/g" "$PWD/Invitation/StageModInfo.xml"

	echo "REPLACED ALL TEMPLATE SYNTAX"
else
	echo "ALL TEMPLATE ALREADY REPLACED"
fi

chmod +x "$PWD/dev.sh"
chmod +x "$PWD/build.sh"
chmod +x "$PWD/usr.sh"

echo "ADDED RUN PERMISSION"

echo "TASK COMPLETED"
