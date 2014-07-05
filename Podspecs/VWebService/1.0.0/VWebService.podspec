Pod::Spec.new do |s|
  s.name         = "VWebService"
  s.version      = "1.0.0"
  s.summary      = "网络请求模块，方便项目调用，使用的是AFNetworking2.0"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "6.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VWebService/*.{h,m,plist,md}"
  s.requires_arc = true
  s.dependency "VExtensions"
  s.dependency "AFNetworking", "~> 2.0"
  s.dependency "JSONModel"
end
