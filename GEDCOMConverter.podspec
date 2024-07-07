#
# Be sure to run `pod lib lint GEDCOMConverter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GEDCOMConverter'
  s.version          = '0.1.7'
  s.summary          = 'With GEDCOMConverter, parsing a GEDCOM file to native Swift objects is too easy!'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
With GEDCOMConverter, parsing a GEDCOM file to native Swift objects is too easy!

Just create a `GEDCOM` object, passing in the name of your GEDCOM file:
```
let gedcom = try GEDCOM(fileName:"sample")
```

The `GEDCOM` object will automatically generate a `head`, and `individuals`, `families` and `sour` arrays of data.
                       DESC

  s.homepage         = 'https://github.com/craiggrummitt/GEDCOMConverter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Craig Grummitt' => 'craiggrummitt@gmail.com' }
  s.source           = { :git => 'https://github.com/craiggrummitt/GEDCOMConverter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/craiggrummitt'

  s.ios.deployment_target = '9.3'

  s.source_files = 'Sources/GEDCOMConverter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GEDCOMConverter' => ['GEDCOMConverter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
