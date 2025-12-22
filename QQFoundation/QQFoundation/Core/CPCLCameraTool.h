//
//  CPSLCameraTool.h
//  SPCLSdk
//
//  Created by peanut on 2024/11/20.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPCLCameraTool : NSObject 
- (void)getCameraImageWithHandler:(void (^)(NSDictionary<NSString*,NSObject*>*))handler;

+(void)getCameraAuthWithHandler:(void (^)(AVAuthorizationStatus))handler;
@end

NS_ASSUME_NONNULL_END
