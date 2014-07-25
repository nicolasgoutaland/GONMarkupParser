Pod::Spec.new do |s|
  s.name         = "GONMarkupParser"
  s.version      = "0.5"
  s.summary      = "Helper to generated NSAttributedString from NSString object using markup, HTML tags, etc..."
  s.platform     = :ios
  s.description  = <<-DESC
					ARC only
                   DESC

  s.homepage     = "https://github.com/nicolasgoutaland/GONMarkupParser"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "nicolasgoutaland" => "nicolas.goutaland@gmail.com" }
  s.source       = { :git => "https://github.com/nicolasgoutaland/GONMarkupParser.podspec.podspec.git", :tag => "0.5" }
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.requires_arc = true
  s.dependency  "NSString+Color"
  s.framework    = 'CoreText'
end
