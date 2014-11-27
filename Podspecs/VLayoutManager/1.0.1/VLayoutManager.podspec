Pod::Spec.new do |s|
  s.name         = "VLayoutManager"
  s.version      = "1.0.1"
  s.summary      = "VLayoutManager是用来控制页面布局使用,增加部分参数"
  s.homepage     = "http://www.heyuan110.com"
  s.license      = "MIT"
  s.author       = { "Yuan" => "http://www.heyuan110.com" }
  s.social_media_url   = "http://weibo.com/heyuan110"
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files  = "Source/VLayoutManager/*.{h,m}","Source/VLayoutManager/VItem/*.{h,m}"
  # s.resource  = "icon.png"
  #s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  #s.frameworks = "QuartzCore", "SystemConfiguration"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "VExtensions"
end
