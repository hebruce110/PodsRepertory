Pod::Spec.new do |s|
  s.name         = "VFileManager"
  s.version      = "1.0.0"
  s.summary      = "file manager"
  s.homepage     = 'http://code.fullteem.com/ios/PodsRepertory'
  s.license      = "MIT"
  s.author       = 'Yuan'
  s.platform     = :ios, "5.0"
  s.source       = { :git => 'http://code.fullteem.com/ios/PodsRepertory.git' }
  s.source_files = "Source/VFileManager/*.{h,m}"
  s.requires_arc = true
 # s.dependency "VDevice"
end
