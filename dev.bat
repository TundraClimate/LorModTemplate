@echo off

:: テンプレ
set "BASEDIR=%~dp0"
call "%BASEDIR%\env.bat"
call "%BASEDIR%\usr.bat"

:: ビルドする
call "%BASEDIR%\build.bat"

:: Assembliesを作成
mkdir "%BASEDIR%\Invitation\Assemblies"

:: Assembliesに移動
move /Y "%BASEDIR%\src\%ID%.dll" "%BASEDIR%\Invitation\Assemblies\%ID%.dll"

pause
