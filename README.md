# CHHook

## 说明

* 实现无入侵式的调试项目，有以下两个功能：
    * 打印当前视图控制器的名称
    * 打印App进行的网络请求（参考了[Hook_NSURLSession](https://github.com/yangqian111/PPSAnalytics/tree/master/Hook_NSURLSession)，进行了优化，实现打印请求参数！）
* 技术点：
    * load 方法，自动执行
    * runtime methodSwizzle
* 使用场景：
    * 当我们手上有一个新的项目的使用，我们在运行的项目的时候，可以随时打印当前项目进入到了哪个视图控制器，而不需要点击 Xcode 上的按钮来进行查看。相比起来更方便更快捷。
    * 另外就是项目如果有网络请求，也是可以随时打印当前视图控制器进行的网络请求的参数。

## 使用说明：

1. Podfile中添加：`pod 'CHHook'`
2. 执行：`pod install`

## Pod Update
* 执行命令验证库：`pod lib lint --allow-warnings`
* 添加Tag并推送：`git tag -a 0.0.1 -m 'Version_0.0.1'; git push origin --tags`
    * 删除Tag本地/远端：`git tag -d 0.0.1; git push origin :refs/tags/0.0.1`
* 推送到 Cocoapod 版本库：`pod trunk push CHHook.podspec`