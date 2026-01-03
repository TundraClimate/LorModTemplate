# 最初にやること

Windowsの場合  
`env.bat`を探して開き、`ID`、`WORKSHOP_TITLE`、`WORKSHOP_DESC`、`WORKSHOP_THUMBNAIL`を入力  
Unixは`.env`

Windowsの場合は`init.bat`を実行する(ダブルクリック、もしくは右クリックメニューから実行を選択)

Unixは`init.sh`

# Harmonyを使用する場合

- Init.cs > コメントアウトを削除する(`/*`と`*/`**のみ**を削除する)
- PatchClass.cs > 同上 コメントアウトを削除
- ${ID}.csproj > XMLコメントアウトを削除(`<!--`と`-->`**のみ**を削除する)
- `libs/`に`0Harmony.dll`をダウンロードしてくる
  - URL >> https://github.com/pardeike/Harmony/releases
  - 最新のRelease(一番上)のAssets > Harmony-Fat.2.x.x.x.zipをダウンロード > 解凍し、中身の`net48/`から`0Harmony.dll`を摘出
- `Invitation/Assemblies`に`0Harmony.dll`をコピペ

# 使い方

`dev.bat`(Windows)もしくは`dev.sh`(Unix-like)を実行することで、  
なんやかんやで`Library of Ruina with Mods`でそのまま起動できる状態で保存されます  
LoRを起動したらチェックマークを対象のModに入れてください
