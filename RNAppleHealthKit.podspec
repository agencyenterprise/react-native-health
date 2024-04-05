#
# Be sure to run `pod lib lint RNAppleHealthKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name             = 'RNAppleHealthKit'
  s.version          = package['version']
  s.summary          = package['description']

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A React Native package to interact with Apple HealthKit
                       DESC

  s.homepage         = 'https://github.com/Ornament-Health/react-native-health'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Agency Enterprise' => '' }
  s.source           = { :git => 'https://github.com/Ornament-Health/react-native-health.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  s.swift_version = '4.2'

  s.source_files = 'RCTAppleHealthKit/**/*'

  s.frameworks = ['HealthKit']
  s.dependency 'React'
end
