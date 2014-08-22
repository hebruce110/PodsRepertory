Pod::Spec.new do |s|
  s.name         = "VVersion"
  s.version      = "1.0.1"
  s.summary      = "根据AppId检测新版本并提示用户更新"
  s.homepage     = "http://www.heyuan110.com"
  s.license      = "MIT"
  s.author       = { "Yuan" => "http://www.heyuan110.com" }
  s.social_media_url   = "http://weibo.com/heyuan110"
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files  = "Source/VVersion/*.{h,m}"
  s.requires_arc = true
  s.dependency "VExtensions"
end
