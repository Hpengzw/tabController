
Pod::Spec.new do |spec|

 
  spec.name         = "tabController"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of tabController."

  spec.description  = "a picture browser with simple animation"

  spec.homepage     = "https://github.com/ytandhz/tabController"

 
  spec.license      = "MIT"


   spec.author             = { "huangpeng" => "1468924117@qq.com" }

  # spec.platform     = :ios
  # spec.platform     = :ios, "9.0"

  spec.source       = { :git => "https://github.com/ytandhz/tabController.git", :branch => "master" }


  spec.source_files  = "ZWTabControllerDemo", "ZWTabControllerDemo/**/*.{h,m}"
  #spec.public_header_files = "ZWTabControllerDemo/*.h"


  spec.resources = "ZWTabControllerDemo/**/*.{xib}"
  s.resource_bundles = {
     'ZWTabControllerDemo' => [
	   'ZWTabControllerDemo'/**/*.{xib,storyboard}',
	   '*.{xcassets}'
	]
  }


  # spec.frameworks = "UIKit"

end
