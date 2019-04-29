# CHHook

## 说明

* 实现无入侵式的调试项目，有以下两个功能：
    * 打印当前视图控制器的名称
    * 打印App进行的网络请求

## Pod Update
* 执行命令验证库：`pod lib lint --allow-warnings`
* 添加Tag并推送：`git tag -a 0.0.1 -m 'Version_0.0.1'; git push origin --tags`
    * 删除Tag本地/远端：`git tag -d 0.0.1; git push origin :refs/tags/0.0.1`
* 推送到 Cocoapod 版本库：`pod trunk push CHHook.podspec`