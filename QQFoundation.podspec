# podspec
Pod::Spec.new do |s|

s.name         = "QQFoundation"
s.version      = "1.0"
s.summary      = "自己使用方便"

s.homepage     = "https://github.com/MuYanQin/QQFoundation"

s.license      = "MIT"

s.author       = { "MuYanQin" => "1159854187@qq.com" }

s.platform     = :ios, "7.0"

s.requires_arc = true

#s.dependency 'KLCPopup'
s.dependency 'AFNetworking'
s.dependency 'MJRefresh'
s.dependency 'SDWebImage'
#s.dependency 'YYCache'
s.dependency 'FLAnimatedImage'

s.source       = { :git => "https://github.com/MuYanQin/QQFoundation.git", :tag => "1.0"}

s.source_files  = 'QQFoundation/QQFoundation'
s.public_header_files = 'QQFoundation/QQFoundation/QQKit.h'

s.subspec 'Base' do |ss|

   ss.subspec 'BaseController' do |sss|
   sss.source_files = 'QQFoundation/QQFoundation/Base/BaseController/**/*.{h,m,c,mm}'
   end

#   ss.subspec 'BaseDefine' do |sss|
#   sss.source_files = 'QQFoundation/QQFoundation/Base/BaseDefine/**/*.{h,m,c,mm}'
#   end

   ss.subspec 'BaseNavigatioinController' do |sss|
   sss.source_files = 'QQFoundation/QQFoundation/Base/BaseNavigatioinController/**/*.{h,m,c,mm}'
   end

   ss.subspec 'BaseTabBarController' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/Base/BaseTabBarController/**/*.{h,m,c,mm}'
    end

#    ss.subspec 'BaseUserInfo' do |sss|
#    sss.source_files = 'QQFoundation/QQFoundation/Base/BaseUserInfo/**/*.{h,m,c,mm}'
#    end
end

s.subspec 'View' do |ss|
    ss.subspec 'MCPopView' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCPopView/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQSingleImagePicker' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/QQSingleImagePicker/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQScanQRCode' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/QQScanQRCode/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQTableView' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/QQTableView/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQTableViewManager' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/QQTableViewManager/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQAlertController' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/QQAlertController/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCHovering' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCHovering/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCVerificationCodeView' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCVerificationCodeView/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCPicker' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCPicker/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCPageView' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCPageView/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCSearch' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCSearch/**/*.{h,m,c,mm}'
    end
end

s.subspec 'Core' do |ss|


    ss.subspec 'AttributedString' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/AttributedString/**/*.{h,m,c,mm}'
    end

    ss.subspec 'Kit' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/Kit/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCChained' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCChained/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCFactory' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCFactory/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCPushMediator' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCPushMediator/**/*.{h,m,c,mm}'
    end

    ss.subspec 'MCDownloadManager' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/MCDownloadManager/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQSQLManager' do |sss|
    sss.source_files = 'QQFoundation/QQFoundation/View/QQSQLManager/**/*.{h,m,c,mm}'
    end

    ss.subspec 'QQNetWork' do |sss|
        sss.subspec 'MCMonitorView' do |ssss|
        ssss.source_files = 'QQFoundation/QQFoundation/View/MCMonitorView/**/*.{h,m,c,mm}'
        end

        sss.subspec 'MBProgressHUD' do |ssss|
        ssss.source_files = 'QQFoundation/QQFoundation/View/MBProgressHUD/**/*.{h,m,c,mm}'
        end

        sss.source_files = 'QQFoundation/QQFoundation/View/QQNetWork/**/*.{h,m,c,mm}'

    end

end

end
