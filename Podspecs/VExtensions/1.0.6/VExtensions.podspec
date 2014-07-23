Pod::Spec.new do |s|
  s.name         = "VExtensions"
  s.version      = "1.0.6"
  s.summary      = "扩展类，常用的宏定义和基本扩展 \n 1.0.6对UIView位置信息扩展"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VExtensions/*.{h,m}"
  s.requires_arc = true
end
