//
//  CPCLRecorderTool.m
//  SPCLSdk
//
//  Created by peanut on 2024/11/20.
//

#import "CPCLRecorderTool.h"
#import <UIKit/UIKit.h>

@interface CPCLRecorderTool ()<AVAudioRecorderDelegate>
@property(nonatomic,copy) void (^callBack)(NSDictionary<NSString*,NSObject*>*);
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;

@end
@implementation CPCLRecorderTool
- (void)getRecorderWithHandler:(void (^)(NSDictionary<NSString*,NSObject*>*))handler{
    self.callBack = handler;

}
// 实现录音完成的代理方法
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        // 录音成功，获取文件路径
          NSURL *audioFileURL = recorder.url;
          

          // 将录音文件转为 NSData
          NSData *audioData = [NSData dataWithContentsOfURL:audioFileURL];
          
          if (audioData) {
              // 将 NSData 转换为 Base64 编码字符串
              NSString *base64EncodedString = [audioData base64EncodedStringWithOptions:0];
              
          } else {
          }
    } else {
        NSLog(@"录音失败");
    }
}
- (void)startRecording {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 请求权限
    [session requestRecordPermission:^(BOOL granted) {
        if (granted) {
            NSLog(@"麦克风权限已授权");
            NSError *error = nil;
            // 设置音频会话为录音模式
            AVAudioSession *session = [AVAudioSession sharedInstance];
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
            [session setActive:YES error:&error];
            
            if (error) {
                NSLog(@"音频会话配置失败: %@", error.localizedDescription);
            }
            NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"myRecording.m4a"];
            NSURL *url = [NSURL fileURLWithPath:path];
            
            // 配置录音设置
            NSDictionary *settings = @{
                AVFormatIDKey: @(kAudioFormatMPEG4AAC),  // AAC 格式
                AVSampleRateKey: @16000.0,  // 采样率
                AVNumberOfChannelsKey: @1,  // 单声道
                AVEncoderAudioQualityKey: @(AVAudioQualityHigh)  // 高质量
            };
                        
            // 创建录音器
            self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
            self.audioRecorder.delegate = self;

            if (error) {
                NSLog(@"创建录音器失败: %@", error.localizedDescription);
                return;
            }
            
            // 开始录音
            [self.audioRecorder record];
            NSLog(@"开始录音...");
            
        } else {
            //如果拒绝，给出提示，跳转到应用设置页面
            [CPCLRecorderTool reopenAuthorityWithMessage:@"麦克风访问权限已关闭，是否前往应用设置开启？"];
        }
    }];
    
}
- (void)stopRecording {
    if (self.audioRecorder.isRecording) {
        [self.audioRecorder stop];
        NSLog(@"录音已停止");
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
