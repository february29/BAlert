Pod::Spec.new do |spec|
    spec.name         = 'BAlertView'
    spec.version      = '0.0.1'
    spec.summary      = '1.show a toast 2.modle show a customview'
    spec.homepage     = 'https://github.com/february29/BAlert'
    spec.license      = 'MIT'
    spec.authors      = {'february29' => 'pengyou_byh@163.com'}
    spec.platform     = :ios, '7.0'
    spec.source       = {:git => 'https://github.com/february29/BAlert.git', :tag => spec.version}
    spec.source_files = 'BAlert/*.{h,m}'
    spec.requires_arc = true
    spec.swift_version = '4.2'
end
