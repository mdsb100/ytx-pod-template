#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = '${POD_NAME}'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ${POD_NAME}.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://gitlab.baidao.com/ios/${POD_NAME}'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '${USER_NAME}' => '${USER_EMAIL}' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  ytx_zipURL='http://gitlab.baidao.com/binaryfiles/${POD_NAME}.zip'

  if ENV['IS_SOURCE'] || ENV["#{s.name}_SOURCE"]
      s.source           = { :git => "http://gitlab.baidao.com/ios/#{s.name}.git", :tag => s.version.to_s }
  else
      s.source           = { :http => ytx_zipURL}
  end

  if ENV['IS_SOURCE'] || ENV["#{s.name}_SOURCE"]
      s.prepare_command = <<-'END'
        test -f download_zip.sh && sh download_zip.sh ${POD_NAME}
      END

      puts '-------------------------------------------------------------------'
      puts "Notice:#{s.name} is source now"
      puts '-------------------------------------------------------------------'
      s.source_files = '${POD_NAME}/Classes/**/*'
  else
      puts '-------------------------------------------------------------------'
      puts "Notice:#{s.name} is binary now"
      puts '-------------------------------------------------------------------'
      s.source_files = '${POD_NAME}/Classes/*.h'
      s.public_header_files = '${POD_NAME}/Classes/*.h'
      s.ios.vendored_libraries = "${POD_NAME}/lib/lib#{s.name}.a"
  end
  s.preserve_paths = "#{s.name}/lib/lib#{s.name}.a","#{s.name}/Classes/**/*", "download_zip.sh"

  if ENV['NO_DEPENDENCY']
      puts '-------------------------------------------------------------------'
      puts "Notice:#{s.name} no dependency now"
      puts '-------------------------------------------------------------------'
  else
      puts '-------------------------------------------------------------------'
      puts "Notice:#{s.name} has dependency now"
      puts '-------------------------------------------------------------------'
  end
  
  # s.resource_bundles = {
  #   '${POD_NAME}' => ['${POD_NAME}/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
