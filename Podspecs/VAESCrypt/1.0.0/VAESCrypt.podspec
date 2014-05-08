Pod::Spec.new do |s|
  s.name     = 'VAESCrypt'
  s.version  = '1.0'
  s.summary  = 'AESCrypt is a simple to use, opinionated AES encryption / decryption Objective-C class that just works.'
  s.homepage = 'https://github.com/heyuan110/AESCrypt-ObjC'
  s.author   = 'Jim Dovey'
  s.source   = { :git => 'https://github.com/heyuan110/AESCrypt-ObjC.git' }
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end