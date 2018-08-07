//
//  MCPlayerMusic.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/7.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPlayerMusic.h"
#import <AVFoundation/AVFoundation.h>

@interface MCPlayerMusic ()

@property (nonatomic , strong) AVAudioPlayer * AudioPlayer;

@end
@implementation MCPlayerMusic
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static MCPlayerMusic * PlayerMusic = nil;
    dispatch_once(&onceToken, ^{
        PlayerMusic = [[self alloc]init];
    });
    return PlayerMusic;
}
- (instancetype)init
{
    if (self = [super init]) {
        NSError *error ;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"wechatMusic" ofType:@"mp3"];
        self.AudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
        self.AudioPlayer.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环

    }
    return self;
}
- (void)startPlayer
{
    [self.AudioPlayer prepareToPlay];
    [self.AudioPlayer play]; //播放
}
- (void)stopPlayer
{
    [self.AudioPlayer stop]; //播放
}
- (void)dealloc
{
    self.AudioPlayer = nil;
}
@end
