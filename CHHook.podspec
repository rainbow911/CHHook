#
# Be sure to run `pod lib lint CHHook.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
    s.name             = 'CHHook'
    s.version          = '0.0.4'
    s.summary          = 'CHHook is Debug Tool'

s.description      = <<-DESC
0.0.4：去掉日志打印，方便和CHLog配合使用
0.0.3：设置请求成功后打印后台返回的Header信息
0.0.2：增加多种解析，避免获取不到请求参数
0.0.1：初始版本
CHHook is Debug Tool, let you quick enter project
DESC

s.homepage         = 'ttps://github.com/rainbow911'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Guowen Wang' => 'rainbow911@gmail.com' }
s.source           = { :git => 'https://github.com/rainbow911/CHHook.git', :tag => s.version.to_s}

s.ios.deployment_target = '9.0'
s.source_files = 'CHHook/Hook/*'


end
