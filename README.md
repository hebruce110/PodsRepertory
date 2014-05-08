PodsRepertory
=============

存放Cocoapods中常用类库文件,统一用V开头

使用方法: 将Podspecs下的所有文件夹拷贝到`.cocoapods/repos/master/`目录下，后面就能直接`pod search`对应的类库了,e.g:`pod search VLayoutManager`

XCODE项目里Podfile文件引用

~~~
platform :ios,'5.0'
inhibit_all_warnings!
pod 'VLayoutManager'
~~~

由于国内网络问题，最近执行`pod install`还是`pod update`都慢的出奇，添加`--verbose`查看问题发现很多都卡在cocoapods spec master update上,所以在update或install的时忽略这个更新.

`pod install --verbose --no-repo-update`

`pod update --verbose --no-repo-update`


####VLayoutManager

* 用来布局使用,配合item信息，来draw

####VAESCrypt

* Objective C AESCrypt 加密

