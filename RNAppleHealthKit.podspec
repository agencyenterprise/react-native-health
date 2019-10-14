#
# Be sure to run `pod lib lint react-native-freestyle-libre.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RNAppleHealthKit'
  s.version          = '0.6.5'
  s.summary          = 'A React Native package for interacting with Apple HealthKit'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A React Native package for interacting with Apple HealthKit
                       DESC

  s.homepage         = 'https://github.com/terrillo/rn-apple-healthkit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Terrillo Walls' => '' }
  s.source           = { :git => 'https://github.com/terrillo/rn-apple-healthkit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.source_files = 'RCTAppleHealthKit/**/*'

  # s.resource_bundles = {
  #   'react-native-freestyle-libre' => ['react-native-freestyle-libre/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = ['HealthKit']
  s.dependency 'React'
end
