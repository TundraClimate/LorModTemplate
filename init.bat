@echo off

:: テンプレ
set "BASEDIR=%~dp0"
call "%BASEDIR%\env.bat"
call "%BASEDIR%\usr.bat"

:: ローカルのMods/にリンクを貼る
if not exist "%LOR_MOD_DIR%\%ID%\" (
    mklink /D "%LOR_MOD_DIR%\%ID%\" "%BASEDIR%\Invitation\"

    echo Invitation link successfully created
) else (
    echo Invitation link already created
)


:: ライブラリ参照のコピペ
if not exist "%BASEDIR%\src\libs\" (
    mkdir "%BASEDIR%\src\libs\"
    copy /Y "%LOR_DATA_DIR%\System.dll" "%BASEDIR%\src\libs\System.dll"
    copy /Y "%LOR_DATA_DIR%\System.Core.dll" "%BASEDIR%\src\libs\System.Core.dll"
    copy /Y "%LOR_DATA_DIR%\mscorlib.dll" "%BASEDIR%\src\libs\mscorlib.dll"
    copy /Y "%LOR_DATA_DIR%\Assembly-CSharp.dll" "%BASEDIR%\src\libs\Assembly-CSharp.dll"

    echo Local assemblies successfully copied
) else (
    echo Local assemblies already copied
)

:: 既存テンプレートの文字置き換え
if exist "%BASEDIR%\src\.csproj" (
    move /Y "%BASEDIR%\src\.csproj" "%BASEDIR%\src\%ID%.csproj"

    call :replace "%BASEDIR%\src\Init.cs" "__MODNAME__" "%ID%"
    call :replace "%BASEDIR%\src\%ID%.csproj" "__MODNAME__" "%ID%"
    call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__MODNAME__" "%ID%"
    call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__TITLE__" "%WORKSHOP_TITLE%"
    call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__DESC__" "%WORKSHOP_DESC%"
    call :replace "%BASEDIR%\Invitation\StageModInfo.xml" "__THUMBNAIL__" "%WORKSHOP_THUMBNAIL%"

    echo All template syntax successfully replaced
) else (
    echo All template syntax already replaced
)

echo --ALL TASK COMPLETE--
pause

exit /b

:replace
powershell -Command "(Get-Content '%~1') -replace '%~2','%~3' | Set-Content '%~1'"
exit /b
