Pod::Spec.new do |s|
  s.name         = "VALMoviePlayerController"
  s.version      = "0.3.0"
  s.summary      = "修改了UI的ALMoviePlayerController。 A drop-in replacement for MPMoviePlayerController that exposes the UI elements and allows for maximum customization"
  s.homepage     = "https://github.com/alobi/ALMoviePlayerController"
  s.license      = "MIT"
  s.author       = { "Anthony Lobianco" => "anthony@lobian.co" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files  = "Source/VALMoviePlayerController/*.{h,m}"
  s.resources = "Source/VALMoviePlayerController/Images/*.png"
  s.frameworks = "QuartzCore", "MediaPlayer"
  s.requires_arc = true
  # s.dependency "VExtensions"
end
