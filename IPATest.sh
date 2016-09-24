#!/bin/bash
#只需要在终端中输入 $ sh IPSTest.sh  即可打包成ipa
 

#***********配置项目
#工程名称(Project的名字)
ZWProjectName="IPATest"	
#scheme名字 -可以点击Product->Scheme->Manager	Schemes...查看
ZWScheme="IPATest"
#git分支
ZWBranchName="master"
#证书
ZWCodeSignIdentity="iPhone Developer: zaiwei_1990@163.com (SZ3732TS8N)"
#描述文件
ZWProvisioningProFile="092b12da-e21f-4e7c-a4c1-dbd293c14f43"
#Release还是Debug
ZWConfiguration="Release"
#*****--------------------


#拉代码
git pull origin $ZWBranchName
#切分支
git checkout $ZWBranchName


ZWDate=`date +%Y%m%d_%H%M` 								#日期
ZWWorkspace=`pwd`										#工程路径
echo "workspace=$ZWWorkspace-----------------------"
ZWBuildDir="$ZWWorkspace/build"			 				#build路径
ZWBuildTempDir="$ZWBuildDir/temp/$ZWBranchName/$ZWDate"	#构建过程中的文件
HCIpaDir="$ZWBuildDir/ipa"								#生成ipa文件路径
echo "HCBiuldDir=$ZWBuildDir"



#创建构建和输出的路径
mkdir -p $ZWBuildTempDir
mkdir -p $HCIpaDir



#构建
xcodebuild \
-workspace "$ZWWorkspace/$ZWProjectName.xcodeproj/project.xcworkspace" \
-scheme "$ZWScheme" \
-configuration "$ZWConfiguration" \
CODE_SIGN_IDENTITY="$ZWCodeSignIdentity"  \
PROVISIONING_PROFILE="$ZWProvisioningProFile" \
clean \
build \
-derivedDataPath "$ZWBuildTempDir"

#生成ipa
xcrun -sdk iphoneos \
-v PackageApplication "$ZWBuildTempDir/Build/Products/$ZWConfiguration-iphoneos/$ZWProjectName.app" \
-o "$HCIpaDir/$ZWProjectName&$ZWBranchName&$ZWDate.ipa"


#清除构建的文件
rm -rf $ZWBuildDir/temp


open $HCIpaDir
