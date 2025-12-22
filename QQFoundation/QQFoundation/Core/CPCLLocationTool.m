//
//  CPCLLocationTool.m
//  SPCLSdk
//
//  Created by peanut on 2024/11/20.
//

#import "CPCLLocationTool.h"
#import <UIKit/UIKit.h>

@interface CPCLLocationTool ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,copy) void (^callBack)(NSDictionary<NSString*,NSObject*>*);

@end
@implementation CPCLLocationTool
- (void)getLocationWithHandler:(void (^)(NSDictionary<NSString*,NSObject*>*))handler{
    self.callBack = handler;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager startUpdatingLocation];
    }else if (status == kCLAuthorizationStatusDenied){
        //如果拒绝，给出提示，跳转到应用设置页面
        [CPCLLocationTool reopenAuthorityWithMessage:@"定位访问权限已关闭，是否前往应用设置开启？"];
    }
    
}

/// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSDictionary * dic;
    
    if (locations.count >0) {
        [_locationManager stopUpdatingLocation];
        [manager stopUpdatingLocation];

        CLLocation *location = [locations firstObject];
        self.callBack(@{});
    }else{

    }
}

/// 定位失败回调方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败, 错误: %@",error);
    switch([error code]) {
        case kCLErrorDenied: { // 用户禁止了定位权限
            
        } break;
        default: break;
    }

}

+(void)reopenAuthorityWithMessage:(NSString*)message{
    //如果拒绝，给出提示，跳转到应用设置页面
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction * determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL success) {
            }];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:determineAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];

    });
}
@end
