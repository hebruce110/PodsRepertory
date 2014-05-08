Pod::Spec.new do |s|
  s.name         = "VLayoutManagerSDK"
  s.version      = "1.0.0"
  s.summary      = "VLayoutManagerSDK is a layout"
  s.description  = <<-DESC
                   VLayoutManagerSDK A longer description of test in Markdown format.

                   * this is a podspec test
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  s.homepage     = "http://heyuan110.com"
  s.license      = "MIT"
  s.author             = { "HeYuan" => "http://www.heyuan110.com" }
  s.social_media_url   = "http://weibo.com/heyuan110"
  s.platform     = :ios, "5.0"
  s.source       = { :git => "~/Desktop/VLayoutManagerSDK", :tag => "1.0" }
  s.source_files  = "**/*.{h,m}"
  # s.resource  = "icon.png"
  s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  s.frameworks = "QuartzCore", "SystemConfiguration"
  # s.libraries = "iconv", "xml2"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
