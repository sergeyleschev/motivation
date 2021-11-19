# Uncomment the next line to define a global platform for your project
use_frameworks!
platform :ios, '14.0'


target 'Motivation' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!
  # Pods for Motivation
  pod 'SwiftyJSON'
  pod 'ObjectMapper'
  pod 'KeychainSwift'
  pod 'SwiftTryCatch'
  pod 'lottie-ios'
  pod 'NVActivityIndicatorView'
end

target 'Motivation-AppClip' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!

  # Pods for Motivation-AppClip

end

target 'Motivation-Watch' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!

  # Pods for Motivation-Watch

end

target 'Motivation-Watch Extension' do
  # Comment the next line if you don't want to use dynamic frameworks
  
  # Pods for Motivation-Watch Extension

end

target 'Motivation-WidgetExtension' do
  # Comment the next line if you don't want to use dynamic frameworks
  #use_frameworks!

  # Pods for Motivation-WidgetExtension
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
