# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'STUDYHUB2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for STUDYHUB2
   pod 'SnapKit', '~> 5.6.0'
  target 'STUDYHUB2Tests' do
    inherit! :search_paths
    # Pods for testing
  end
pod 'FSCalendar'
  target 'STUDYHUB2UITests' do
    # Pods for testing
  end
pod 'Moya'
  target 'STUDYHUB2UITests' do
end
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
