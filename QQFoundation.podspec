# podspec
Pod::Spec.new do |s|

s.name         = "QQFoundation"
s.version      = "1.0"
s.summary      = "自己使用方便"

s.homepage     = "https://github.com/MuYanQin/QQFoundation"

s.license      = "MIT"

s.author       = { "shangwu" => "1159854187@qq.com" }

s.platform     = :ios
s.platform     = :ios, "7.0"

s.requires_arc = true


s.dependency 'KLCPopup'
s.dependency 'AFNetworking'
s.dependency 'MJRefresh'
s.dependency 'SDWebImage'
s.dependency 'YYCache'
s.dependency 'FLAnimatedImage'

s.source       = { :git => "https://github.com/MuYanQin/QQFoundation.git", :tag => "1.0"}


s.source_files  = 'QQFoundation/QQFoundation'
s.public_header_files = 'QQFoundation/QQFoundation/QQKit.h'

s.subspec 'Base' do |ss|

    ss.subspec 'BaseController' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Base/BaseController/**/*.{h,m,c,mm}'
    end

    ss.subspec 'BaseDefine' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Base/BaseDefine/**/*.{h,m,c,mm}'
    end

    ss.subspec 'BaseNavigatioinController' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Base/BaseNavigatioinController/**/*.{h,m,c,mm}'
    end

    ss.subspec 'BaseTabBarController' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Base/BaseTabBarController/**/*.{h,m,c,mm}'
    end
end

s.subspec 'Category' do |ss|
ss.source_files = 'QQFoundation/QQFoundation/Category/**/*.{h,m,c,mm}'
end

s.subspec 'Successor' do |ss|
ss.source_files = 'QQFoundation/QQFoundation/Successor/**/*.{h,m,c,mm}'
end


s.subspec 'Tool' do |ss|

    ss.subspec 'MCPushMediator' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Tool/MCPushMediator/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCContentView' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Tool/MCContentView/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCDownloadManager' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Tool/MCDownloadManager/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQAlertController' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Tool/QQAlertController/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQSQLManager' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Tool/QQSQLManager/**/*.{h,m,c,mm}'
    end

    ss.subspec 'PayUtil' do |sss|
        sss.source_files = 'QQFoundation/QQFoundation/Tool/PayUtil/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQScanQRCode' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Tool/QQScanQRCode/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQNetWork' do |sss|
        sss.source_files = 'QQFoundation/QQFoundation/Tool/QQNetWork/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQSingleImagePicker' do |sss|
        sss.source_files = 'QQFoundation/QQFoundation/Tool/QQSingleImagePicker/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQTableView' do |sss|
        sss.source_files = 'QQFoundation/QQFoundation/Tool/QQTableView/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQTableViewManager' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Tool/QQTableViewManager/**/*.{h,m,c,mm}'
    end


    ss.subspec 'QQTool' do |sss|
        sss.source_files = 'QQFoundation/QQFoundation/Tool/QQTool/**/*.{h,m,c,mm}'
    end


end




end
