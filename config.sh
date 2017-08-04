#!/bin/bash


Cyan='\033[0;36m'
Default='\033[0;m'

projectName=""
httpsRepo=""
sshRepo=""
homePage=""
confirmed="n"

getProjectName() {
    read -p "Enter Project Name: " projectName

    if test -z "$projectName"; then
        getProjectName
    fi
}

getHTTPSRepo() {
    read -p "Enter HTTPS Repo URL: " httpsRepo

    if test -z "$httpsRepo"; then
        getHTTPSRepo
    fi
}

getSSHRepo() {
    read -p "Enter SSH Repo URL: " sshRepo

    if test -z "$sshRepo"; then
        getSSHRepo
    fi
}

getHomePage() {
    read -p "Enter Home Page URL: " homePage

    if test -z "$homePage"; then
        getHomePage
    fi
}

getInfomation() {
    getProjectName
    getHTTPSRepo
    getSSHRepo
    getHomePage

    echo -e "\n${Default}================================================"
    echo -e "  Project Name  :  ${Cyan}${projectName}${Default}"
    echo -e "  HTTPS Repo    :  ${Cyan}${httpsRepo}${Default}"
    echo -e "  SSH Repo      :  ${Cyan}${sshRepo}${Default}"
    echo -e "  Home Page URL :  ${Cyan}${homePage}${Default}"
    echo -e "================================================\n"
}

echo -e "\n"
while [ "$confirmed" != "y" -a "$confirmed" != "Y" ]
do
    if [ "$confirmed" == "n" -o "$confirmed" == "N" ]; then
        getInfomation
    fi
    read -p "confirm? (y/n):" confirmed
done

#正式发布的内容放在这个文件夹中
mkdir -p "../${projectName}/${projectName}/Classes"
#实验阶段的内容放在这个文件夹下面 - 主要方便开发阶段Pod本地引用的处理
mkdir -p "../${projectName}/${projectName}/Stage"

licenseFilePath="../${projectName}/FILE_LICENSE"
gitignoreFilePath="../${projectName}/.gitignore"
specFilePath="../${projectName}/${projectName}.podspec"
readmeFilePath="../${projectName}/readme.md"
uploadFilePath="../${projectName}/upload.sh"
podfilePath="../${projectName}/Podfile"

# echo "copy to $licenseFilePath"
# cp -f ./templates/FILE_LICENSE "$licenseFilePath"
# echo "copy to $gitignoreFilePath"
# cp -f ./templates/gitignore    "$gitignoreFilePath"
# echo "copy to $specFilePath"
# cp -f ./templates/pod.podspec  "$specFilePath"
# echo "copy to $readmeFilePath"
# cp -f ./templates/readme.md    "$readmeFilePath"
# echo "copy to $uploadFilePath"
# cp -f ./templates/upload.sh    "$uploadFilePath"
# echo "copy to $podfilePath"
# cp -f ./templates/Podfile      "$podfilePath"

echo "copy templates to $projectName"
cp -rf ./templates/. "../$projectName"

echo "editing..."
sed -i "" "s%__ProjectName__%${projectName}%g" "$gitignoreFilePath"
sed -i "" "s%__ProjectName__%${projectName}%g" "$readmeFilePath"
sed -i "" "s%__ProjectName__%${projectName}%g" "$uploadFilePath"
sed -i "" "s%__ProjectName__%${projectName}%g" "$podfilePath"

sed -i "" "s%__ProjectName__%${projectName}%g" "$specFilePath"
sed -i "" "s%__HomePage__%${homePage}%g"      "$specFilePath"
sed -i "" "s%__HTTPSRepo__%${httpsRepo}%g"    "$specFilePath"
echo "edit finished"

echo "cleaning..."
cd ../$projectName
git init
git remote add origin $sshRepo  &> /dev/null
git rm -rf --cached ./Pods/     &> /dev/null
git rm --cached Podfile.lock    &> /dev/null
git rm --cached .DS_Store       &> /dev/null
git rm -rf --cached $projectName.xcworkspace/           &> /dev/null
git rm -rf --cached $projectName.xcodeproj/xcuserdata/`whoami`.xcuserdatad/xcschemes/$projectName.xcscheme &> /dev/null
git rm -rf --cached $projectName.xcodeproj/project.xcworkspace/xcuserdata/ &> /dev/null
echo "clean finished"
say "finished"
echo "finished"
