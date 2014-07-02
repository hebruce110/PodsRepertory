Pod::Spec.new do |s|
  s.name         = "VAppstoreComment"
  s.version      = "1.0.0"
  s.summary      = "对APP进行评价，给好评提示之类的"
  s.homepage     = 'https://github.com/heyuan110/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'https://github.com/heyuan110/PodsRepertory.git' }
  s.source_files = "Source/VAppstoreComment/*.{h,m}"
  s.requires_arc = true
  s.dependency "VExtensions"
end
