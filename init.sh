#!/bin/bash

cd $(dirname $0)

source "$PWD/.env"

ln -s "$PWD/Invitation" "$LOR_MOD_DIR/$ID"

mkdir "$PWD/src/"

echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<NormalInvitation xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">
  <Version>1.1</Version>
  <Workshop>
    <ID>$ID</ID>
    <Title>$WORKSHOP_TITLE</Title>
    <Description>$WORKSHOP_DESC</Description>
    <Tag />
    <PreviewImage>$WORKSHOP_THUMBNAIL</PreviewImage>
  </Workshop>
  <InvitationFile>
    <Stage Exist=\"true\">
      <Path>\\Data\\StageInfo.xml</Path>
    </Stage>
    <EnemyUnit Exist=\"true\">
      <Path>\\Data\\EnemyUnitInfo.xml</Path>
    </EnemyUnit>
    <EquipPage_Enemy Exist=\"true\">
      <Path>\\Data\\EquipPage_Enemy.xml</Path>
    </EquipPage_Enemy>
    <EquipPage_Librarian Exist=\"true\">
      <Path>\\Data\\EquipPage_Librarian.xml</Path>
    </EquipPage_Librarian>
    <DropBook Exist=\"true\">
      <Path>\\Data\\Dropbook.xml</Path>
    </DropBook>
    <CardDropTable Exist=\"true\">
      <Path>\\Data\\CardDropTable.xml</Path>
    </CardDropTable>
    <CardInfo Exist=\"true\">
      <Path>\\Data\\CardInfo.xml</Path>
    </CardInfo>
    <Deck Exist=\"true\">
      <Path>\\Data\\Deck_Enemy.xml</Path>
    </Deck>
    <Dialog Exist=\"true\">
      <Path>\\Data\\Combat_Dialog.xml</Path>
    </Dialog>
    <BookDesc Exist=\"true\">
      <Path>\\Data\\BookStory.xml</Path>
    </BookDesc>
    <Passive Exist=\"true\">
      <Path>\\Data\\PassiveList.xml</Path>
    </Passive>
  </InvitationFile>
</NormalInvitation>" >"$PWD/Invitation/StageModInfo.xml"

echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<Project ToolsVersion=\"15.0\" xmlns=\"http://schemas.microsoft.com/developer/msbuild/2003\">
  <Import Project=\"\$(MSBuildExtensionsPath)\\\$(MSBuildToolsVersion)\\Microsoft.Common.props\" Condition=\"Exists('\$(MSBuildExtensionsPath)\\\$(MSBuildToolsVersion)\\Microsoft.Common.props')\" />
  <PropertyGroup>
    <Configuration Condition=\" '\$(Configuration)' == '' \">Debug</Configuration>
    <Platform Condition=\" '\$(Platform)' == '' \">AnyCPU</Platform>
    <ProjectGuid>0dd91af2-17f9-4ab8-bf05-09dbb27992f0</ProjectGuid>
    <OutputType>Library</OutputType>
    <AppDesignerFolder>Properties</AppDesignerFolder>

    <RootNamespace>$ID</RootNamespace>
    <AssemblyName>$ID</AssemblyName>

    <TargetFrameworkVersion>v4.8</TargetFrameworkVersion>
    <PlatformTarget>x86</PlatformTarget>
    <FileAlignment>512</FileAlignment>
    <Deterministic>true</Deterministic>
  </PropertyGroup>
  <PropertyGroup Condition=\" '\$(Configuration)|\$(Platform)' == 'Debug|AnyCPU' \">
    <DebugSymbols>true</DebugSymbols>
    <DebugType>full</DebugType>
    <Optimize>false</Optimize>
    <OutputPath>bin\\Debug\\</OutputPath>
    <DefineConstants>DEBUG;TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <PropertyGroup Condition=\" '\$(Configuration)|\$(Platform)' == 'Release|AnyCPU' \">
    <DebugType>pdbonly</DebugType>
    <Optimize>true</Optimize>
    <OutputPath>bin\\Release\\</OutputPath>
    <DefineConstants>TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include=\"System\">
      <HintPath>.\\libs\\System.dll</HintPath>
    </Reference>

    <Reference Include=\"System.Core\">
      <HintPath>.\\libs\\System.Core.dll</HintPath>
    </Reference>
    
    <Reference Include=\"mscorlib\">
      <HintPath>.\\libs\\mscorlib.dll</HintPath>
    </Reference>

    <Reference Include=\"Assembly-CSharp\">
      <HintPath>.\\libs\\Assembly-CSharp.dll</HintPath>
    </Reference>

    <!--
    <Reference Include=\"0Harmony\">
      <HintPath>.\\libs\\0Harmony.dll</HintPath>
    </Reference>
    -->
  </ItemGroup>
  <ItemGroup>
    <Compile Include=\"Init.cs\" />
    <Compile Include=\"PatchClass.cs\" />
  </ItemGroup>
  <Import Project=\"\$(MSBuildToolsPath)\\Microsoft.CSharp.targets\" />
</Project>" >"$PWD/src/$ID.csproj"

mkdir -p "$PWD/src/libs/"
cp "$LOR_DATA_DIR/System.dll" "$PWD/src/libs/System.dll"
cp "$LOR_DATA_DIR/System.Core.dll" "$PWD/src/libs/System.Core.dll"
cp "$LOR_DATA_DIR/mscorlib.dll" "$PWD/src/libs/mscorlib.dll"
cp "$LOR_DATA_DIR/Assembly-CSharp.dll" "$PWD/src/libs/Assembly-CSharp.dll"

echo "using System;

namespace $ID
{
    public class $ID : ModInitializer
    {
        public static string packageId
        {
            get
            {
                return \"$ID\";
            }
        }

        public override void OnInitializeMod()
        {
            /* ApplyHarmonyPatch(); */
        }

        /* 
        public static void ApplyHarmonyPatch()
        {
            HarmonyLib.Harmony harmony = new HarmonyLib.Harmony($ID.packageId);
            foreach (Type type in typeof(PatchClass).GetNestedTypes(HarmonyLib.AccessTools.all))
            {
                harmony.CreateClassProcessor(type).Patch();
            }
        }
        */
    }
}" >"$PWD/src/Init.cs"

echo "/*
using HarmonyLib;

namespace $ID
{
    public class PatchClass
    {
    }
}
*/
" >"$PWD/src/PatchClass.cs"

echo "TASK COMPLETED"
