Pod::Spec.new do |s|
  s.name         = "VUIImageView+ActivityView"
  s.version      = "1.0.0"
  s.summary      = "图片的loading动画"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Bruce'
  s.platform     = :ios, "7.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VUIImageView+ActivityView/*.{h,m}"
  s.resources = "Source/VUIImageView+ActivityView/Images/*.png"
  s.requires_arc = true
  s.dependency "SDWebImage"
end
