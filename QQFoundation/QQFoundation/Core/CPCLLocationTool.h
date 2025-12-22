//
//  CPCLLocationTool.h
//  SPCLSdk
//
//  Created by peanut on 2024/11/20.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPCLLocationTool : NSObject
- (void)getLocationWithHandler:(void (^)(NSDictionary<NSString*,NSObject*>*))handler;

@end

NS_ASSUME_NONNULL_END
