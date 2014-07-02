Pod::Spec.new do |s|
  s.name         = "VExtensions"
  s.version      = "1.0.4"
  s.summary      = "扩展类，常用的宏定义和基本扩展 \n 1.0.4版本更新了间距的宏定义，增加了对JSON字符串的解析和生成"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VExtensions/*.{h,m}"
  s.requires_arc = true
end
