Pod::Spec.new do |s|
  s.name         = "VUIImageView+ActivityView"
  s.version      = "1.0.0"
  s.summary      = "基于SDWebImage扩展的UIImageView加载图片时loading动画，包含系统的UIActivityIndicatorView和自定义的VActivityView，使用和SDWebImage一样，只需要在后面加一个animated:(BOOL)animated即可，例如 - (void)sd_setImageWithURL:(NSURL *)url animated:(BOOL)animated"
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
