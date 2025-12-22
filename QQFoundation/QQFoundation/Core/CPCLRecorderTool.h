//
//  CPCLRecorderTool.h
//  SPCLSdk
//
//  Created by peanut on 2024/11/20.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface CPCLRecorderTool : NSObject
- (void)getRecorderWithHandler:(void (^)(NSDictionary<NSString*,NSObject*>*))handler;

- (void)startRecording;
- (void)stopRecording;
@end

NS_ASSUME_NONNULL_END
