@echo off

:: いつもの
set "BASEDIR=%~dp0"

:: 設定情報の読み込みだよ
call "%BASEDIR%\env.bat"

::ビルドしてみる(そのまま)
"%MSBUILD%" "%BASEDIR%\src\%ID%.csproj"

:: 成果物をsrcに移動
move /Y "%BASEDIR%\src\bin\Debug\%ID%.dll" "%BASEDIR%\src\%ID%.dll"
