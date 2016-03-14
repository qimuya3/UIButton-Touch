Pod::Spec.new do |s|
  s.name         = "UIButton-Touch"
  s.version      = "1.0.0"
  s.summary      = "防止按钮连续点击。To avoid the continuous Click of UIButton."
  s.description  = <<-DESC
                   防止按钮连续点击。To avoid the continuous Click of UIButton.
                   - Compatibility for iOS6, iOS7, iOS8
                   DESC
  s.homepage     = "https://github.com/qimuya3/UIButton-Touch"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "StriEver, qmy3" => "qimuya3@163.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/qimuya3/UIButton-Touch.git", :tag => s.version.to_s }
  s.source_files  = "*.{h,m}"
end
