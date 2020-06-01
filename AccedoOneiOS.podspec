Pod::Spec.new do |s|
  s.name         = "AccedoOneiOS"
  s.version      = "1.0.13"
  s.summary      = "AccedoOne for iOS."
  s.description  = "AccedoOne for iOS framework"
  s.homepage     = "https://appgrid.docs.apiary.io/#"
  s.license      = "Copyright © 2017 Accedo Broadband Inc. All rights reserved."
  s.authors      = "Accedo Broadband Inc."
  s.requires_arc = true
  s.platform     = :ios
  s.vendored_frameworks = 'Release/1.0.13/AccedoOneiOS.framework'
  s.ios.deployment_target  = "9.0"
  s.source = { 
	:http => 'https://github.com/Accedo-Products/accedo-one-sdk-ios-tvos/blob/master/Release/1.0.13/AccedoOneiOS.zip?raw=true'
  }
end
