@echo off

:: テンプレ
set "BASEDIR=%~dp0"
call "%BASEDIR%\env.bat"
call "%BASEDIR%\usr.bat"

:: ローカルのMods/にリンクを貼る
mklink /D "%LOR_MOD_DIR%\%ID%\" "%BASEDIR%\Invitation\"

echo Invitation mklink success

:: ライブラリ参照のコピペ
mkdir "%BASEDIR%\src\libs\"
copy /Y "%LOR_DATA_DIR%\System.dll" "%BASEDIR%\src\libs\System.dll"
copy /Y "%LOR_DATA_DIR%\System.Core.dll" "%BASEDIR%\src\libs\System.Core.dll"
copy /Y "%LOR_DATA_DIR%\mscorlib.dll" "%BASEDIR%\src\libs\mscorlib.dll"
copy /Y "%LOR_DATA_DIR%\Assembly-CSharp.dll" "%BASEDIR%\src\libs\Assembly-CSharp.dll"

echo Copy asm to libs/ success

move /Y "%BASEDIR%\src\.csproj" "%BASEDIR%\src\%ID%.csproj"

call :replace "%BASEDIR%\src\Init.cs" "__MODNAME__" "%ID%"
call :replace "%BASEDIR%\src\PatchClass.cs" "__MODNAME__" "%ID%"
call :replace "%BASEDIR%\src\%ID%.csproj" "__MODNAME__" "%ID%"
call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__MODNAME__" "%ID%"
call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__TITLE__" "%WORKSHOP_TITLE%"
call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__DESC__" "%WORKSHOP_DESC%"
call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__THUMBNAIL__" "%WORKSHOP_THUMBNAIL%"

echo Replace all template syntax success

echo --ALL TASK COMPLETE--
pause

exit /b

:replace
powershell -Command "(Get-Content '%~1') -replace '%~2','%~3' | Set-Content '%~1'"
exit /b
