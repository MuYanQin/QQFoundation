//
//  NSString+encrypt.h
//  QQFoundation
//
//  Created by leaduMac on 2019/9/8.
//  Copyright © 2019 Yuan er. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(encrypt)
- (NSString *)md5;
- (NSString *)base64;
@end

NS_ASSUME_NONNULL_END
