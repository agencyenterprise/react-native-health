#
# Be sure to run `pod lib lint RNAppleHealthKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RNAppleHealthKit'
  s.version          = '1.7.0'
  s.summary          = 'A React Native package to interact with Apple HealthKit'

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<~DESC
    A React Native package to interact with Apple HealthKit
  DESC

  s.homepage         = 'https://github.com/agencyenterprise/react-native-health'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Agency Enterprise' => '' }
  s.source           = {
    git: 'https://github.com/agencyenterprise/react-native-healthkit.git',
    tag: s.version.to_s,
    submodules: true
  }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.5'

  s.source_files = ['v2/RNHealthKitCore/ReactNativeBridge/**/*', 'v2/RNHealthKitCore/HealthKitCore/**/*.swift']
  s.requires_arc = true

  s.frameworks = ['HealthKit']
  s.dependency 'React'
end
