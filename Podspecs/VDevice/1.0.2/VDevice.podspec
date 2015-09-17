Pod::Spec.new do |s|
  s.name         = "VDevice"
  s.version      = "1.0.2"
  s.summary      = "获取设备相关参数信息"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "7.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VDevice/*.{h,m}","Source/VDevice/Utilities/*.{h,m}"
  s.framework  = "CoreTelephony"
  s.requires_arc = true
end
