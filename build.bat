@echo off

:: テンプレ
set "BASEDIR=%~dp0"
call "%BASEDIR%\env.bat"
call "%BASEDIR%\usr.bat"

::ビルドしてみる
"%MSBUILD%" "%BASEDIR%\src\%ID%.csproj" /t:Build /p:Configuration=Debug /p:Platform="Any CPU" /p:OutputPath=bin\Debug /nologo

:: 成果物をsrcに移動
move /Y "%BASEDIR%\src\bin\Debug\%ID%.dll" "%BASEDIR%\src\%ID%.dll"
