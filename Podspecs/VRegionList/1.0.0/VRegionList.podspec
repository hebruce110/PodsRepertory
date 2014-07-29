Pod::Spec.new do |s|
  s.name         = "VRegionList"
  s.version      = "1.0.0"
  s.summary      = "省市区行政区域列表，包含拼音，id和排序"
  s.homepage     = "http://www.heyuan110.com"
  s.license      = "MIT"
  s.author       = { "Yuan" => "http://www.heyuan110.com" }
  s.social_media_url   = "http://weibo.com/heyuan110"
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VRegionList/*.{h,m}"
  s.resources    = "Source/VRegionList/*.{plist,txt}"
  s.requires_arc = true
  s.dependency "VExtensions"
end
