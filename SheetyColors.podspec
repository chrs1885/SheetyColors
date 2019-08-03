Pod::Spec.new do |s|
  s.name             = 'SheetyColors'
  s.version          = '0.3.1'
  s.summary          = 'An action sheet styled color picker for iOS.'

  s.description      = <<-DESC
The SheetyColors color picker is based on UIKit's UIAlertController. Therefore, it nicely integrates with the look & feel of all other native system dialogs.
                       DESC

  s.homepage         = 'https://github.com/chrs1885/SheetyColors'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chrs1885' => 'christoph.wendt@me.com' }
  s.documentation_url = 'https://github.com/chrs1885/SheetyColors/blob/master/Documentation/Reference/README.md'
  s.source           = { :git => 'https://github.com/chrs1885/SheetyColors.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/chr_wendt'

  s.ios.deployment_target = '11.0'
  s.dependency 'Capable/Colors', '~> 1.0.0'

  s.source_files     = 'SheetyColors/Classes/**/*.{swift}'
  s.resources        = 'SheetyColors/Classes/**/*.{xcassets,xib}'
end
