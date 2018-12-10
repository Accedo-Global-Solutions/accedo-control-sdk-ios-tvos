Pod::Spec.new do |s|
  s.name         = "AccedoOneiOS-local"
  s.version      = "1.0.6"
  s.summary      = "AccedoOne for iOS."
  s.description  = "AccedoOne for iOS framework"
  s.homepage     = "https://appgrid.docs.apiary.io/#"
  s.license      = "Copyright © 2017 Accedo Broadband Inc. All rights reserved."
  s.authors      = "Accedo Broadband Inc."
  s.requires_arc = true
  s.platform     = :ios
  s.source       = { :path => "." }
  s.ios.deployment_target  = "9.0"
  s.source_files        = "Common/**/*.{h,m}"
  s.exclude_files       = "Common/**/*_private.{h}"
  s.public_header_files = "Common/**/*.h"

  s.dependency 'AFNetworking',    '3.1.0'
  #s.dependency 'CocoaLumberjack', '3.1.0'
  #s.dependency 'Mantle',          '2.0.6'
  s.dependency 'SOCKit',          '1.1'
  s.dependency 'PINCache',        '2.2.2'
end
