#!/bin/bash

# Codename of your device
device_name=manta;

# This is the path to your android's root folder
android_root_folder=/home/khaon/android/rom/temasek;

# the link to the root of your android build output folder
output_folder=/home/khaon/out/temasek;

# This has to be the path to your package rom
pathToTheRom=$output_folder/target/product/$device_name/cm-12.1-*-UNOFFICIAL-*.zip;
romName=`basename $pathToTheRom`;

# Path to your xml ota file
ota_file=~/android/Packages/roms/manta_ota.xml;

VersionName=`grep temasek_version_default $android_root_folder/packages/apps/Settings/res/values/cr_strings.xml | grep -o "V[0-9]\{2\}.[0-9]"`;

md5=`md5sum $pathToTheRom | cut -d ' ' -f 1`;
todayDate=`date +%F%H | sed s@-@@g`;

# Change this if using another versionNumber way

versionNumber=$todayDate;
size=`wc -c $pathToTheRom | cut -d ' ' -f 1`;
websiteURL="http://forum.xda-developers.com/nexus-10/development/rom-optipop-f2fs-ubertc-4-9-3-t3086601";
downloadUrl=http://46.105.101.215/khaon/roms/$romName

(cat << EOF) > $ota_file;
<?xml version="1.0" encoding="UTF-8"?>
<ROM>
  <RomName>Temasek-manta</RomName>
  <VersionName>$VersionName</VersionName>
  <VersionNumber type="integer">$versionNumber</VersionNumber>
  <DirectUrl> <![CDATA[$downloadUrl]]></DirectUrl>
  <HttpUrl nil="true" />
  <Android>5.1.1</Android>
  <CheckMD5>$md5</CheckMD5>
  <FileSize type="integer">$size</FileSize>
  <Developer nil="true"/>
  <WebsiteURL><![CDATA[$websiteURL]]></WebsiteURL>
  <DonateURL nil="true" />
  <Changelog>$VersionName</Changelog>
</ROM>

EOF

