## 第一步：设置你的Pod私库地址


pod repo add 私库名称 私库地址


## 第二步：修改templates/Podfile，添加：


source '私库地址'  



## 第三步：修改templates/upload.sh，修改:  


pod repo push 私库名称 __ProjectName__.podspec --verbose --allow-warnings  


## 第四步：同级目录下创建工程，比如ProjectA，同时远程(比如Github/OSC码云/或者公司内网Gitlab等)添加对应的Repo  


cd ProjectA  


git init  


git remote add origin 远程repo地址  


## 第五步：cd ConfigPrivatePod && ./config.sh，按照提示输入相关参数即可。


### 第六步：发版到私库


cd 你的工程目录（比如：cd ProjectA)


git add .


git commit -m "版本号"	（版本号请与pod.podspec文件中的s.version保持一致）


git tag 版本号	 （版本号请与pod.podspec文件中的s.version保持一致）


git push origin master --tags


./upload.sh