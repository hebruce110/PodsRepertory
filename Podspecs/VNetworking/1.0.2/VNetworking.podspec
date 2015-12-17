Pod::Spec.new do |s|
  s.name         = "VNetworking"
  s.version      = "1.0.2"
  s.summary      = "网络请求模块，离散型设计，方便扩展，设置多url"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "6.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VNetworking/*.{h,m}"
  s.resources    = "Source/VNetworking/*.{plist,txt}"
  s.requires_arc = true
  s.dependency 'AFNetworking', '2.5.4'
end
