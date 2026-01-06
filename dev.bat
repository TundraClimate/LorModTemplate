@echo off

:: いつもの
set "BASEDIR=%~dp0"

:: 設定情報の読み込みだよ
call "%BASEDIR%\env.bat"

:: ビルドする
call "%BASEDIR%\build.bat"

:: Assembliesを作成
mkdir "%BASEDIR%\Invitation\Assemblies"

:: Assembliesに移動
move /Y "%BASEDIR%\src\%ID%.dll" "%BASEDIR%\Invitation\Assemblies\%ID%.dll"

pause
