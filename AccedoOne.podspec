Pod::Spec.new do |s|

  s.name         = "AccedoOne"
  s.version      = "1.0"
  s.summary      = "AccedoOne for iOS and tvOS."
  s.description  = "AccedoOne for iOS and tvOS."
  s.homepage     = "https://appgrid.docs.apiary.io/#"
  s.license      = "Copyright © 2017 Accedo Broadband Inc. All rights reserved."
  s.authors      = "Accedo Broadband Inc."
  s.requires_arc = true
  #s.source       = { :path => "." }
  
  s.subspec 'iOS' do |s_ios|
  	  s_ios.platform     = :ios
  	  s_ios.vendored_frameworks = 'Binary/AccedoOneiOS.framework'
	  s_ios.ios.deployment_target  = "9.0"
	  s_ios.source = { 
    	:http => 'https://github.com/Accedo-Products/accedo-one-sdk-ios-tvos/raw/master/Binary/AccedoOneiOS.zip'
  	  }	
  end

  s.subspec 'tvOS' do |s_tvos|
  	  s_tvos.platform     = :tvos
	  s_tvos.tvos.deployment_target = "9.0"
  	  s_tvos.vendored_frameworks = 'Binary/AccedoOnetvOS.framework'
	  s_tvos.source = { 
    	:http => 'https://github.com/Accedo-Products/accedo-one-sdk-ios-tvos/raw/master/Binary/AccedoOnetvOS.zip'
  	  }
  end
end
