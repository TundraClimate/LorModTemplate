@echo off
setlocal EnableDelayedExpansion

:: テンプレ
set "BASEDIR=%~dp0"
call "%BASEDIR%\env.bat"
call "%BASEDIR%\usr.bat"

echo Check %%LOR_DIR%% validity

:: %%LOR_DIR%%が正規かの確認
if not exist "%LOR_DIR%" (
    echo Error: Found the invalid LOR_DIR
    echo To fix: Replace the LOR_DIR= path that invalid 'LibraryOfRuina_Data' foldor into the accurate path
    echo Find accurate path: Steam application ^> 'Library of Ruina' ^> Configure ^> Management ^> Show Local files
    echo.
    echo ...and Try again here

    pause
    exit /b
) else (
    echo Find the valid LOR_DIR: Passed

    if not exist "%LOR_DATA_DIR%" (
        echo Error: Found the invalid LOR_DATA_DIR
        echo To fix: Replace the LOR_DATA_DIR= path that invalid 'LibraryOfRuina_Data/Managed' folder into the accurate path
        echo Find accurate path: Steam application ^> 'Library of Ruina' ^> Configure ^> Management ^> Show Local files
        echo.
        echo ...and Try again here

        pause
        exit /b
    )

    echo Find the valid LOR_DATA_DIR: Passed

    if not exist "%LOR_MOD_DIR%" (
        echo Error: Found the invalid LOR_DATA_DIR
        echo To fix: Replace the LOR_MOD_DIR= path that invalid 'LibraryOfRuina_Data/Mods' folder into the accurate path
        echo Find accurate path: Steam application ^> 'Library of Ruina' ^> Configure ^> Management ^> Show Local files
        echo.
        echo ...and Try again here

        pause
        exit /b
    )

    echo Find the valid LOR_MOD_DIR: Passed
)

echo.
echo Check %%MSBUILD%% validity

if not exist "%MSBUILD%" (
    echo Error: Found the invalid MSBUILD
    echo Possible causes: Not installed .NET framework, Found VisualStudio MSBUILD only,
    echo To fix: Install .NET framework v4.8 by installer.

    pause
    exit /b
) else (
    echo Find the valid MSBUILD: Passed
)

echo.
echo Create symlink to \Mods\

:: ローカルのMods/にリンクを貼る
for %%A in ("%LOR_DIR%") do (
    :: ドライブ名にアクセス出来るか
    if not "%%~dA" == "" if not "%%~pA" == "%%~dpA" (
        :: ドライブ名を指定してフォーマット形式を取得
        for /f "skip=1" %%F in ('wmic logicaldisk where "DeviceID='%%~dA'" get FileSystem') do (
            if "%%F" == "NTFS" (
                set FS=%%F
            )
        )

        if "!FS!" == "NTFS" (
            if not exist "%LOR_MOD_DIR%\%ID%\" (
                mklink /D "%LOR_MOD_DIR%\%ID%\" "%BASEDIR%\Invitation\"

                echo Invitation link successfully created for \Mods\
            ) else (
                echo Invitation link already created for \Mods\
            )
        ) else (
            echo Skip symlink: Drive %%~dA is not supported the symlink
        )
    ) else (
        echo Skip symlink: LOR_DIR is not absolute path, the drive access denied
        echo To fix: Put the absolute path to the LOR_DIR
    )
)

echo.
echo Start copy the local assemblies

if not exist "%BASEDIR%\src\libs\" (
    echo A \libs\ not found
    mkdir "%BASEDIR%\src\libs\"

    if exist "%BASEDIR%\src\libs\" (
        echo A \libs\ successfully created
    ) else (
        echo Error: Failed create a \libs\

        pause
        exit /b
    )
)

:: ライブラリ参照のコピペ
call :copyasm "%LOR_DATA_DIR%\System.dll" "%BASEDIR%\src\libs\System.dll"
call :copyasm "%LOR_DATA_DIR%\System.Core.dll" "%BASEDIR%\src\libs\System.Core.dll"
call :copyasm "%LOR_DATA_DIR%\mscorlib.dll" "%BASEDIR%\src\libs\mscorlib.dll"
call :copyasm "%LOR_DATA_DIR%\Assembly-CSharp.dll" "%BASEDIR%\src\libs\Assembly-CSharp.dll"

echo.
echo Replace the all template syntax

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
    if exist "%BASEDIR%\src\%ID%.csproj" (
        echo All template syntax already replaced
    ) else (
        echo Error: The template file not found
        echo Error: This template has broken file
        echo.
        echo Try again at first step

        pause
        exit /b
    )
)

echo.
echo --ALL TASK COMPLETE--
pause

exit /b

:replace
powershell -Command "(Get-Content '%~1') -replace '%~2','%~3' | Set-Content '%~1'"
exit /b

:copyasm
if not exist "%~2" (
    copy /Y "%~1" "%~2"
    echo A file copied to %~p2: %~nx1
) else (
    echo A file was already copied: %~nx1
)
exit /b
