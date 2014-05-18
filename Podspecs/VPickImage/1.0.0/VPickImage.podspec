Pod::Spec.new do |s|
  s.name         = "VPickImage"
  s.version      = "1.0.0"
  s.summary      = "快捷调用从相册或相机选择图片"
  s.homepage     = "http://www.heyuan110.com"
  s.license      = "MIT"
  s.author       = { "Yuan" => "http://www.heyuan110.com" }
  s.social_media_url   = "http://weibo.com/heyuan110"
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/heyuan110/PodsRepertory.git"}
  s.source_files  = "VPickImage/*.{h,m}"
  # s.resource  = "icon.png"
  #s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  #s.frameworks = "QuartzCore", "SystemConfiguration"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
end