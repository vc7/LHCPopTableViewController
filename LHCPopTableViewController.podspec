Pod::Spec.new do |spec|
  spec.name = 'LHCPopTableViewController'
  spec.version = '0.1'
  spec.authors = {'Li-Hsuan Chen' => 'vincent@vincenttt.com'}
  spec.homepage = 'https://github.com/vc7/LHCPopTableViewController'
  spec.summary = 'A custom tabbar controller'
  spec.source = {:git => 'https://github.com/vc7/LHCPopTableViewController.git', :tag => 'v0.1' }
  spec.license = { :type => 'MIT', :file => 'LICENSE' }

  spec.platform = :ios, '7.0'
  spec.requires_arc = true
  spec.source_files = 'LHCPopTableViewController.{h,m}'
end