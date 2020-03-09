Pod::Spec.new do |s|
  s.name         = "AccedoOne"
  s.version      = "1.0.10"
  s.summary      = "AccedoOne for iOS."
  s.description  = "AccedoOne for iOS framework"
  s.homepage     = "https://appgrid.docs.apiary.io/#"
  s.license      = "Copyright © 2017 Accedo Broadband Inc. All rights reserved."
  s.authors      = "Accedo Broadband Inc."
  s.requires_arc = true
  s.module_name = 'AccedoOne'
  s.platform     = :ios
  #s.vendored_frameworks = 'Release/1.0.10/AccedoOneiOS.framework'
  s.ios.deployment_target  = "9.0"
  s.source       = { :path => '.' }
  s.source_files        = "Common/**/*.{h,m,swift}"
  s.dependency 'AFNetworking',    '3.1.0'
  s.dependency 'PINCache',        '2.2.2'
end
