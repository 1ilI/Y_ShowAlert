#
#  Be sure to run `pod spec lint Y_ShowAlert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  #名称
  s.name         = "Y_ShowAlert"
  #版本
  s.version      = "0.0.1"
  #简介
  s.summary      = "对 UIAlertController 的扩展，快速创建与展示 AlertController"
  #详介
  s.description  = <<-DESC
                   快速创建与展示 AlertController，包括含有 TextField 的 Alert
                   使用 Observer 监听了添加的 TextField ，方便做输入内容 最大、最小长度的限制，以及确认按钮的 enabled 状态等
                   DESC

  #首页
  s.homepage     = "https://github.com/1ilI/Y_ShowAlert"
  #截图
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  #开源协议
  s.license      = { :type => "MIT", :file => "LICENSE" }
  #作者信息
  s.author             = { "1ilI" => "1ilI" }
  #iOS的开发版本
  s.ios.deployment_target = "9.0"
  #源码地址
  s.source       = { :git => "https://github.com/1ilI/Y_ShowAlert.git", :tag => "#{s.version}" }
  #源文件所在文件夹，会匹配到该文件夹下所有的 .h、.m文件
  s.source_files  = "Y_ShowAlert", "Y_ShowAlert/**/*.{h,m}"
  #依赖的framework
  s.framework  = "UIKit"

end

