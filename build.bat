@echo off

:: テンプレ
set "BASEDIR=%~dp0"
call "%BASEDIR%\env.bat"
call "%BASEDIR%\usr.bat"

::ビルドしてみる
dotnet build "%BASEDIR%\src\%ID%.csproj" -c Debug -nologo

:: 成果物をsrcに移動
move /Y "%BASEDIR%\src\bin\Debug\net48\%ID%.dll" "%BASEDIR%\src\%ID%.dll"
