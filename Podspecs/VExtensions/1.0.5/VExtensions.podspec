Pod::Spec.new do |s|
  s.name         = "VExtensions"
  s.version      = "1.0.5"
  s.summary      = "扩展类，常用的宏定义和基本扩展 \n 1.0.5版本更新了对文件md5的校验，在NSData扩展类里"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VExtensions/*.{h,m}"
  s.requires_arc = true
end
