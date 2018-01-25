Pod::Spec.new do |s|
  s.name         = "AccedoOnetvOS"
  s.version      = "1.0.0"
  s.summary      = "AccedoOne for tvOS."
  s.description  = "AccedoOne for tvOS framework"
  s.homepage     = "https://appgrid.docs.apiary.io/#"
  s.license      = "Copyright © 2017 Accedo Broadband Inc. All rights reserved."
  s.authors      = "Accedo Broadband Inc."
  s.requires_arc = true
  s.source       = { :path => "." }
  s.platform     = :tvOS
  s.vendored_frameworks = 'Release/AccedoOneiOS/1.0.0/AccedoOnetvOS.framework'
  s.ios.deployment_target  = "9.0"
  s.source = { 
	:http => 'https://github.com/Accedo-Products/accedo-one-sdk-ios-tvos/raw/master/Release/AccedoOnetvOS/1.0.0/AccedoOnetvOS.zip'
  }
end