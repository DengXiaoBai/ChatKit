#
# Be sure to run `pod lib lint ChatKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ChatKit'
  s.version          = '0.1.59'
  s.summary          = 'A short description of ChatKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Sachsen ChatKit
                       DESC

  s.homepage         = 'https://github.com/Stringstech/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Sachsen'
  s.source           = { :git => 'https://github.com/Stringstech/SachsenKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ChatKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ChatKit' => ['ChatKit/Assets/**/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency  'pop', '~> 1.0'
  s.dependency  'DTCoreText', '~> 1.6'
  s.dependency  'GRMustache', '~> 7.3'
  s.dependency  'Masonry', '~> 0.6'
  s.dependency  'YYImage'
  s.dependency  'TTTAttributedLabel'
  s.dependency  'UITextView+Placeholder'

end
