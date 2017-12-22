Pod::Spec.new do |s|

  s.name         = "AccedoOne"
  s.version      = "3.local"
  s.summary      = "AccedoOne for iOS and tvOS."
  s.description  = "AccedoOne for iOS and tvOS."
  s.homepage     = "https://appgrid.docs.apiary.io/#"
  s.license      = "Copyright © 2015 Accedo Broadband Inc. All rights reserved."
  s.authors      = "Accedo Broadband Inc."
  s.requires_arc = true
  s.source       = { :path => "." }
  
  s.subspec 'iOS' do |s_ios|
  	  s_ios.platform     = :ios
  	  s_ios.vendored_frameworks = 'Binary/AccedoOneiOS.framework'
	  s_ios.ios.deployment_target  = "7.0"
  end

  s.subspec 'tvOS' do |s_tvos|
  	  s_tvos.platform     = :tvos
	  s_tvos.tvos.deployment_target = "9.0"
  	  s_tvos.vendored_frameworks = 'Binary/AccedoOnetvOS.framework'
  end
end
