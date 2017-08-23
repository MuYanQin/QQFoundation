//
//  NSDictionary+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSDictionary+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSDictionary (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [AvoidCrash exchangeClassMethod:self method1Sel:@selector(dictionaryWithObjects:forKeys:count:) method2Sel:@selector(avoidCrashDictionaryWithObjects:forKeys:count:)];
        
//        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryI"), @selector(objectForKeyedSubscript:));
//        Method toMethod = class_getInstanceMethod(objc_getClass("__NSDictionaryI"), @selector(QQ_ObjectForKey:));
//        method_exchangeImplementations(fromMethod, toMethod);
    });
}

- (instancetype)QQ_ObjectForKey:(NSString *)key
{
    id instance = nil;

//    NSLog(@"key");
    @try {
     instance =   [self QQ_ObjectForKey:key];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = @"This framework default is to remove nil key-values and instance a dictionary.";
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
//        emObject = [NSString stringWithFormat:@""];
      instance =  [self QQ_ObjectForKey:key];
    }
    @finally {
        return instance;
    }

}
+ (instancetype)avoidCrashDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self avoidCrashDictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"This framework default is to remove nil key-values and instance a dictionary.";
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self avoidCrashDictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

@end
