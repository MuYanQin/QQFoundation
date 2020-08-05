//
//  MCDownloadManager.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/12.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCDownloadManager.h"
#import "QQFileManage.h"
#import "MCDownloadItem.h"
typedef void(^BGCompletedHandler)();
@interface MCDownloadManager ()<NSURLSessionDelegate>
@property (nonatomic , strong) NSURLSessionConfiguration * Configuration;
@property (nonatomic , strong) NSURLSession * Session;
@property (nonatomic , strong) NSURLSessionDownloadTask * loadTask;
@property (nonatomic , strong) NSMutableDictionary * taskMuDic;
@property (nonatomic , copy) BGCompletedHandler   CompletedHandler;
@end
static  NSString * const MCConfigurationIdentifier = @"com.QQFoundation.ConfigurationIdentifier";

@implementation MCDownloadManager
+ (instancetype)defaultManager
{
    static  MCDownloadManager *defaultManager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[self alloc]init];
    });
    return defaultManager;
}
- (instancetype)init
{
    if (self = [super init]) {
        //获取App闪退等情况退出后保存的任务
        NSMutableDictionary *dictM = [self.Session valueForKey:@"tasks"];
        [dictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSURLSessionDownloadTask *obj, BOOL * _Nonnull stop) {
            MCDownloadItem *Item = self.taskMuDic[[self getURLFromTask:obj]];
            if(!Item){
                NSLog(@"[Error] not found task for url: %@", [self getURLFromTask:obj]);
                [obj cancel];
            }else{
                Item.downloadTask = obj;
            }
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillTerminate) name:UIApplicationWillTerminateNotification object:nil];

    }
    return self;
}
- (void)addCompletionHandler:(void (^)())completionHandler identifier:(NSString *)identifier
{
    if ([MCConfigurationIdentifier isEqualToString:identifier]) {
        self.CompletedHandler = completionHandler;
    }
}
- (MCDownloadItem *)startDownloadWith:(NSString *)downloadString
{
    if (downloadString.length <=0) {
        NSLog(@"下载地址不能为空！！！");
        return nil;
    }
    MCDownloadItem *item = [self.taskMuDic objectForKey:downloadString];
    if (item && item.loadStatus == MCDownloadComplete) {
        return item;
    }else if(item &&  item.loadStatus == MCDownloadPause){
        [self resumeTaskWith:downloadString];
        item = [[MCDownloadItem alloc]init];
        item.loadStatus = MCDownloadLoading;
        return item;
    }else if(item.loadStatus == MCDownloadLoading){
        item = [[MCDownloadItem alloc]init];
        return item;
    }else{
        item = [[MCDownloadItem alloc]init];
    }
    item.downloadString = downloadString;
    NSURL *downloadURL = [NSURL URLWithString:downloadString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    self.loadTask = [self.Session downloadTaskWithRequest:request];
    [self.loadTask resume];
    item.loadStatus =  MCDownloadLoading;//这里暂时直接是进入下载中。 后面判断等待状态
    item.downloadTask = self.loadTask;
    [self.taskMuDic setObject:item forKey:downloadString];
    [self saveDownloadStatus];
    return item;
}
- (void)pauseTaskWith:(NSString *)downloadString
{
    if (downloadString.length <=0) {
        NSLog(@"地址不能为空");
        return;
    }
    MCDownloadItem *Item = self.taskMuDic[downloadString];
    NSURLSessionDownloadTask *task  = Item.downloadTask;
    [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {

    }];
    
}
- (void)PauseAllTask
{
    [self.taskMuDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, MCDownloadItem *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@====%ld====%ld",obj.downloadTask,(long)obj.downloadTask.state,(long)obj.loadStatus);
        if (obj.downloadTask.state != NSURLSessionTaskStateCompleted && obj.loadStatus == MCDownloadLoading) {
            [obj.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            }];
        }
    }];
}
- (void)resumeTaskWith:(NSString *)downloadString
{
    if (downloadString.length <= 0) {
        NSLog(@"URL is not to be nil !!");
        return;
    }
    MCDownloadItem *item = self.taskMuDic[downloadString];
    if (item.resumeData) {
        item.downloadTask =  [self.Session downloadTaskWithResumeData:item.resumeData];
        item.loadStatus = MCDownloadLoading;
        [item.downloadTask resume];
        [self saveDownloadStatus];
    }

}
- (void)resumeAllTask
{
    [self.taskMuDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, MCDownloadItem *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@====%ld====%ld",obj.downloadTask,(long)obj.downloadTask.state,(long)obj.loadStatus);
        if (obj.downloadTask.state != NSURLSessionTaskStateCompleted && obj.loadStatus == MCDownloadPause) {
            obj.downloadTask =  [self.Session downloadTaskWithResumeData:obj.resumeData];
            obj.loadStatus = MCDownloadLoading;
            [obj.downloadTask resume];
        }
    }];
}
- (void)removeFileWith:(NSString *)downloadString
{
    if (downloadString.length <= 0) {
        NSLog(@"URL is not to be nil !!");
        return;
    }
    MCDownloadItem *item = self.taskMuDic[downloadString];
    if (!item) {
        NSLog(@"不存在此任务！！");
        return;
    }
    if (item.loadStatus == MCDownloadLoading) {
        [item.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {}];
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@",[self CahePath],item.fileName];
    [QQFileManage removeItematPath:path];
}
- (void)cleanDisk
{
    [self PauseAllTask];
    [self.taskMuDic removeAllObjects];
    [self saveDownloadStatus];
    [QQFileManage removeItematPath:[self CahePath]];
    
}
- (void)appWillTerminate
{
    NSLog(@"qinmuqiao");
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"%s",__func__);

}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    NSLog(@"%s",__func__);

}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask
{
    NSLog(@"%s",__func__);

}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSLog(@"%s",__func__);

}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler
{
    NSLog(@"%s",__func__);

}
//将一个后台session作废完成后的回调，用来切换是否允许使用蜂窝煤网络，重新创建session
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"%s",__func__);
    NSLog(@"didBecomeInvalidWithError");
}
//下载完成时调用
//如果appDelegate实现下面的方法，后台下载完成时，会自动唤醒启动app。如果不实现，那么后台下载完成不唤醒，用户手动启动会调用相关回调方法
//-[AppDelegate application:handleEventsForBackgroundURLSession:completionHandler:]
//后台唤醒调用顺序： appdelegate ——> didFinishDownloadingToURL  ——> URLSessionDidFinishEventsForBackgroundURLSession
//手动启动调用顺序: didFinishDownloadingToURL  ——> URLSessionDidFinishEventsForBackgroundURLSession
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"%s", __func__);
    MCDownloadItem *item = [self.taskMuDic objectForKey:[self getURLFromTask:downloadTask]];
    if (!item) {
        NSLog(@"视频下载完成下载链接重定向为%@",[self getURLFromTask:downloadTask]);
        return;
    }
    NSError *err;
    NSString *path = [[self CahePath] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtPath:[location path] toPath:path error:&err];
    item.savePath = path;
    item.downloadTask = nil;
    item.loadStatus = MCDownloadComplete;
    item.resumeData = nil;
    item.fileName = downloadTask.response.suggestedFilename;
    [self saveDownloadStatus];
    
}
/* 下载恢复时调用
 * 在使用downloadTaskWithResumeData:方法获取到对应NSURLSessionDownloadTask，
 * 并该task调用resume的时候调用
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s", __func__);
    NSLog(@"下载恢复");
}
/* 下载过程中调用，用于跟踪下载进度
 * bytesWritten为单次下载大小
 * totalBytesWritten为当当前一共下载大小
 * totalBytesExpectedToWrite为文件大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress =(float) totalBytesWritten/totalBytesExpectedToWrite;
    NSLog(@"%.2f",progress);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    NSLog(@"%s", __func__);

    //NSLog(@"willPerformHTTPRedirection ------> %@",response);
}
/* 应用在后台，而且后台所有下载任务完成后才会调用这个方法，
 * 在所有其他NSURLSession和NSURLSessionDownloadTask委托方法执行完后回调，
 * 可以在该方法中做下载数据管理和UI刷新
 *
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    NSLog(@"%s", __func__);
    if (self.CompletedHandler) {
        self.CompletedHandler();
        self.CompletedHandler = nil;
    }
}
/* 在任务下载完成、下载失败
 * 或者是应用被杀掉后，重新启动应用并创建相关identifier的Session时调用
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    NSLog(@"%s", __func__);

    MCDownloadItem *item = self.taskMuDic[[self getURLFromTask:task]];
    
    if (error) {
        NSData *resumeData = [error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData];
        if (resumeData) {
            item.resumeData = resumeData;
            item.downloadTask = nil;
            item.loadStatus = MCDownloadPause;
            item.fileName = task.response.suggestedFilename;
            [self saveDownloadStatus];
        }
    }
}


- (NSString *)getURLFromTask:(NSURLSessionTask *)task {
    
    //301/302定向的originRequest和currentRequest的url不同
    NSString *url = nil;
    NSURLRequest *req = [task originalRequest];
    url = req.URL.absoluteString;
    //bridge swift , sometimes originalRequest not have url
    if(url.length==0){
        url = [task currentRequest].URL.absoluteString;
    }
    return url;
}
- (NSMutableDictionary *)taskMuDic
{
    if (_taskMuDic) {
        return _taskMuDic;
    }
    _taskMuDic = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getUserInfoFile]];
    if (!_taskMuDic) {
        _taskMuDic = [NSMutableDictionary dictionary];
    }else{
        _taskMuDic = _taskMuDic.mutableCopy;

    }
    return _taskMuDic;
}
- (NSString *)getUserInfoFile {
    NSString * path = [[QQFileManage cachesPath] stringByAppendingPathComponent:@"user.data"];
    return path;
}
- (void)saveDownloadStatus {
    [NSKeyedArchiver archiveRootObject:_taskMuDic toFile:[self getUserInfoFile]];
}
- (NSString *)CahePath
{
    __block NSString *CahePath = [NSString stringWithFormat:@"%@%@",[QQFileManage cachesPath],@"/MCDownload"];
    if ([QQFileManage isContainAtPath:CahePath]) {
        return CahePath;
    }else{
        [QQFileManage createFolderWithPath:[QQFileManage cachesPath] folderName:@"MCDownload" success:^(NSString *Path, NSError *error) {
            if (!error) {
                CahePath = Path;
            }
        }];
        return CahePath;
    }
}
- (NSURLSessionConfiguration *)Configuration
{
    if (!_Configuration) {
        _Configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:MCConfigurationIdentifier];
        _Configuration.allowsCellularAccess = YES;
    }
    return _Configuration;
}
- (NSURLSession *)Session
{
    if (!_Session) {
        _Session = [NSURLSession sessionWithConfiguration:self.Configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _Session;
}
@end
