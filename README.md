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

## 安装

使用CocoaPods集成到项目中，在`Podfile`文件中添加：

```ruby
target '<Your Target Name>' do
    pod 'CHHook'
end
```

然后运行下面的命令：

```bash
$ pod install
```

## 版本说明：

* 如果是单独使用请使用版本`0.0.3`，Podfile中设置`pod 'CHHook', '0.0.3'`；
* 如果是配合 CHLog 使用，请使用版本`0.0.4`，此版本为特殊版本，去掉了 NSLog。