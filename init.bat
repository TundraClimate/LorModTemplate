@echo off

:: いつもの
set "BASEDIR=%~dp0"

:: 設定情報の読み込みだよ
call "%BASEDIR%\env.bat"

:: ローカルのMods/にリンクを貼る
mklink /D "%LOR_MOD_DIR%\%ID%\" "%BASEDIR%\Invitation\"

mkdir "%BASEDIR%\src"
mkdir "%BASEDIR%\Invitation\Resource\CharacterSkin"
mkdir "%BASEDIR%\Invitation\Resource\CombatPageArtwork"
mkdir "%BASEDIR%\Invitation\Resource\MotionSound"
mkdir "%BASEDIR%\Invitation\Resource\StoryBgm"
mkdir "%BASEDIR%\Invitation\Resource\StoryBgSprite"
mkdir "%BASEDIR%\Invitation\Resource\StoryStanding"

echo Invitation mklink successfully

:: StageModInfo.xmlを生成
echo. > "%BASEDIR%\Invitation\StageModInfo.xml"
(
echo(^<?xml version="1.0" encoding="utf-8"?^>
echo(^<NormalInvitation xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
echo(  ^<Version^>1.1^</Version^>
echo(  ^<Workshop^>
echo(    ^<ID^>%ID%^</ID^>
echo(    ^<Title^>%WORKSHOP_TITLE%^</Title^>
echo(    ^<Description^>%WORKSHOP_DESC%^</Description^>
echo(    ^<Tag /^>
echo(    ^<PreviewImage^>%WORKSHOP_THUMBNAIL%^</PreviewImage^>
echo(  ^</Workshop^>
echo(  ^<InvitationFile^>
echo(    ^<Stage Exist="true"^>
echo(      ^<Path^>\Data\StageInfo.xml^</Path^>
echo(    ^</Stage^>
echo(    ^<EnemyUnit Exist="true"^>
echo(      ^<Path^>\Data\EnemyUnitInfo.xml^</Path^>
echo(    ^</EnemyUnit^>
echo(    ^<EquipPage_Enemy Exist="true"^>
echo(      ^<Path^>\Data\EquipPage_Enemy.xml^</Path^>
echo(    ^</EquipPage_Enemy^>
echo(    ^<EquipPage_Librarian Exist="true"^>
echo(      ^<Path^>\Data\EquipPage_Librarian.xml^</Path^>
echo(    ^</EquipPage_Librarian^>
echo(    ^<DropBook Exist="true"^>
echo(      ^<Path^>\Data\Dropbook.xml^</Path^>
echo(    ^</DropBook^>
echo(    ^<CardDropTable Exist="true"^>
echo(      ^<Path^>\Data\CardDropTable.xml^</Path^>
echo(    ^</CardDropTable^>
echo(    ^<CardInfo Exist="true"^>
echo(      ^<Path^>\Data\CardInfo.xml^</Path^>
echo(    ^</CardInfo^>
echo(    ^<Deck Exist="true"^>
echo(      ^<Path^>\Data\Deck_Enemy.xml^</Path^>
echo(    ^</Deck^>
echo(    ^<Dialog Exist="true"^>
echo(      ^<Path^>\Data\Combat_Dialog.xml^</Path^>
echo(    ^</Dialog^>
echo(    ^<BookDesc Exist="true"^>
echo(      ^<Path^>\Data\BookStory.xml^</Path^>
echo(    ^</BookDesc^>
echo(    ^<Passive Exist="true"^>
echo(      ^<Path^>\Data\PassiveList.xml^</Path^>
echo(    ^</Passive^>
echo(  ^</InvitationFile^>
echo(^</NormalInvitation^>
) >> "%BASEDIR%\Invitation\StageModInfo.xml"

more +1 "%BASEDIR%\Invitation\StageModInfo.xml" > "%BASEDIR%\Invitation\StageModInfo.tmp"
move /Y "%BASEDIR%\Invitation\StageModInfo.tmp" "%BASEDIR%\Invitation\StageModInfo.xml" 

echo StageModInfo generate successfully

:: .csprojの生成
echo. > "%BASEDIR%\src\%ID%.csproj"
(
echo(^<?xml version="1.0" encoding="utf-8"?^>
echo(^<Project ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003"^>
echo(  ^<Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')" /^>
echo(  ^<PropertyGroup^>
echo(    ^<Configuration Condition=" '$(Configuration)' == '' "^>Debug^</Configuration^>
echo(    ^<Platform Condition=" '$(Platform)' == '' "^>AnyCPU^</Platform^>
echo(    ^<ProjectGuid^>0dd91af2-17f9-4ab8-bf05-09dbb27992f0^</ProjectGuid^>
echo(    ^<OutputType^>Library^</OutputType^>
echo(    ^<AppDesignerFolder^>Properties^</AppDesignerFolder^>
echo(    ^<RootNamespace^>%ID%^</RootNamespace^>
echo(    ^<AssemblyName^>%ID%^</AssemblyName^>
echo(    ^<TargetFrameworkVersion^>v4.8^</TargetFrameworkVersion^>
echo(    ^<PlatformTarget^>x86^</PlatformTarget^>
echo(    ^<FileAlignment^>512^</FileAlignment^>
echo(    ^<Deterministic^>true^</Deterministic^>
echo(  ^</PropertyGroup^>
echo(  ^<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Debug|AnyCPU' "^>
echo(    ^<DebugSymbols^>true^</DebugSymbols^>
echo(    ^<DebugType^>full^</DebugType^>
echo(    ^<Optimize^>false^</Optimize^>
echo(    ^<OutputPath^>bin\Debug\^</OutputPath^>
echo(    ^<DefineConstants^>DEBUG;TRACE^</DefineConstants^>
echo(    ^<ErrorReport^>prompt^</ErrorReport^>
echo(    ^<WarningLevel^>4^</WarningLevel^>
echo(  ^</PropertyGroup^>
echo(  ^<PropertyGroup Condition=" '$(Configuration)|$(Platform)' == 'Release|AnyCPU' "^>
echo(    ^<DebugType^>pdbonly^</DebugType^>
echo(    ^<Optimize^>true^</Optimize^>
echo(    ^<OutputPath^>bin\Release\^</OutputPath^>
echo(    ^<DefineConstants^>TRACE^</DefineConstants^>
echo(    ^<ErrorReport^>prompt^</ErrorReport^>
echo(    ^<WarningLevel^>4^</WarningLevel^>
echo(  ^</PropertyGroup^>
echo(  ^<ItemGroup^>
echo(    ^<Reference Include="System"^>
echo(      ^<HintPath^>.\libs\System.dll^</HintPath^>
echo(    ^</Reference^>
echo(    ^<Reference Include="System.Core"^>
echo(      ^<HintPath^>.\libs\System.Core.dll^</HintPath^>
echo(    ^</Reference^>
echo(    ^<Reference Include="mscorlib"^>
echo(      ^<HintPath^>.\libs\mscorlib.dll^</HintPath^>
echo(    ^</Reference^>
echo(    ^<Reference Include="Assembly-CSharp"^>
echo(      ^<HintPath^>.\libs\Assembly-CSharp.dll^</HintPath^>
echo(    ^</Reference^>
echo(    ^<!--
echo(    ^<Reference Include="0Harmony"^>
echo(      ^<HintPath^>.\libs\0Harmony.dll^</HintPath^>
echo(    ^</Reference^>
echo(    --^>
echo(  ^</ItemGroup^>
echo(  ^<ItemGroup^>
echo(    ^<Compile Include="Init.cs" /^>
echo(    ^<Compile Include="PatchClass.cs" /^>
echo(  ^</ItemGroup^>
echo(  ^<Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets" /^>
echo(^</Project^>
) >> "%BASEDIR%\src\%ID%.csproj"

more +1 "%BASEDIR%\src\%ID%.csproj" > "%BASEDIR%\src\%ID%.tmp"
move /Y "%BASEDIR%\src\%ID%.tmp" "%BASEDIR%\src\%ID%.csproj"

echo %ID%.csproj generate successfully

:: ライブラリ参照のコピペ
mkdir "%BASEDIR%\src\libs\"
copy /Y "%LOR_DATA_DIR%\System.dll" "%BASEDIR%\src\libs\System.dll"
copy /Y "%LOR_DATA_DIR%\System.Core.dll" "%BASEDIR%\src\libs\System.Core.dll"
copy /Y "%LOR_DATA_DIR%\mscorlib.dll" "%BASEDIR%\src\libs\mscorlib.dll"
copy /Y "%LOR_DATA_DIR%\Assembly-CSharp.dll" "%BASEDIR%\src\libs\Assembly-CSharp.dll"

echo Copy asm to libs/ successfully

:: Init.csの書き込み
echo. > "%BASEDIR%\src\Init.cs"
(
echo using System;
echo namespace %ID%
echo {
echo     public class %ID% : ModInitializer
echo     {
echo         public static string packageId
echo         {
echo             get
echo             {
echo                 return "%ID%";
echo             }
echo         }
echo         public override void OnInitializeMod^(^)
echo         {
echo             /* ApplyHarmonyPatch^(^); */
echo         }
echo         /* 
echo         public static void ApplyHarmonyPatch^(^)
echo         {
echo             HarmonyLib.Harmony harmony = new HarmonyLib.Harmony^(%ID%.packageId^);
echo             foreach ^(Type type in typeof^(PatchClass^).GetNestedTypes^(HarmonyLib.AccessTools.all^)^)
echo             {
echo                 harmony.CreateClassProcessor^(type^).Patch^(^);
echo             }
echo         }
echo         */
echo     }
echo }
) >> "%BASEDIR%\src\Init.cs"

more +1 "%BASEDIR%\src\Init.cs" > "%BASEDIR%\src\Init.tmp"
move /Y "%BASEDIR%\src\Init.tmp" "%BASEDIR%\src\Init.cs"

echo Init.cs generate successfully

:: PatchClass.csの書き込み
echo. > "%BASEDIR%\src\PatchClass.cs"
(
echo /*
echo using HarmonyLib;
echo namespace %ID%
echo {
echo     public class PatchClass
echo     {
echo     }
echo }
echo */
) >> "%BASEDIR%\src\PatchClass.cs"

more +1 "%BASEDIR%\src\PatchClass.cs" > "%BASEDIR%\src\PatchClass.tmp"
move /Y "%BASEDIR%\src\PatchClass.tmp" "%BASEDIR%\src\PatchClass.cs"

echo PatchClass.cs generate successfully

echo --ALL TASK COMPLETE--
pause
