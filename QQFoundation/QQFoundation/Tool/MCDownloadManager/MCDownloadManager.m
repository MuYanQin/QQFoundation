//
//  MCDownloadManager.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/6/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCDownloadManager.h"
#import "QQFileManage.h"
#import "MCDownloadItem.h"
@interface MCDownloadManager ()<NSURLSessionDelegate,NSURLSessionDownloadDelegate>
@property (nonatomic , strong) NSURLSessionConfiguration * Configuration;
@property (nonatomic , strong) NSURLSession * Session;
@property (nonatomic , strong) NSURLSessionDownloadTask * loadTask;
@property (nonatomic , strong) NSMutableDictionary * taskMuDic;
@end
static  NSString * const MCConfigurationIdentifier = @"ConfigurationIdentifier";

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
- (MCDownloadItem *)startDownloadWith:(NSString *)downloadString
{
    if (downloadString.length <=0) {
        NSLog(@"下载地址不能为空！！！");
        return nil;
    }
    MCDownloadItem *item = [self.taskMuDic objectForKey:downloadString];
    if (item) {
        return item;
    }else{
        item = [[MCDownloadItem alloc]init];
    }
    item.downloadString = downloadString;
    NSURL *downloadURL = [NSURL URLWithString:downloadString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    self.loadTask = [self.Session downloadTaskWithRequest:request];
    [self.loadTask resume];
    item.loadStatus =  MCDownloadLoading;
    [self.taskMuDic setObject:item forKey:downloadString];
    [self saveDownloadStatus];
    return item;
}
#pragma mark - NSURLSessionDownloadDelegate
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
    NSLog(@"%f", progress);
}
//下载完成时调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    
    MCDownloadItem *item = [self.taskMuDic objectForKey:[self getURLFromTask:downloadTask]];
    NSError *err;
    NSString *path = [[self CahePath] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtPath:[location path] toPath:path error:&err];
    item.savePath = path;
    item.loadStatus = MCDownloadComplete;
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
    
}
#pragma mark - NSURLSessionDelegate
// 1.接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"接收到服务器响应的时候调用 -- %@", [NSThread currentThread]);
    
    // 允许处理服务器的响应，才会继续接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}

// 2.接收到服务器的数据（可能调用多次）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据
    NSLog(@"我被调用了");
    
}
/* 应用在后台，而且后台所有下载任务完成后，
 * 在所有其他NSURLSession和NSURLSessionDownloadTask委托方法执行完后回调，
 * 可以在该方法中做下载数据管理和UI刷新
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    
    
}
/* 在任务下载完成、下载失败
 * 或者是应用被杀掉后，重新启动应用并创建相关identifier的Session时调用
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    NSLog(@"%@",error);
    //解析服务器返回数据
//    if(self.dataM){
//        NSString *temp = [[NSString alloc] initWithData:self.dataM encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", temp);
//        NSData *jsonData = [temp dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSError *err;
//        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                             
//                                                            options:NSJSONReadingMutableContainers
//                             
//                                                              error:&err];
//        NSLog(@"====%@", dic);
//        NSLog(@"====errerr%@", err);
//    }
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
    _taskMuDic = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getUserInfoFile]];
    if (!_taskMuDic) {
        _taskMuDic = [NSMutableDictionary dictionary];
    }else{
        _taskMuDic = [NSMutableDictionary dictionaryWithDictionary:_taskMuDic];

    }
    return _taskMuDic;
}
- (NSString *)getUserInfoFile {
    NSString * path = [[QQFileManage GetCachesPath] stringByAppendingPathComponent:@"user.data"];
    return path;
}
- (void)saveDownloadStatus {
    [NSKeyedArchiver archiveRootObject:_taskMuDic toFile:[self getUserInfoFile]];
}
- (NSString *)CahePath
{
    __block NSString *CahePath = [NSString stringWithFormat:@"%@%@",[QQFileManage GetCachesPath],@"/MCDownload"];
    if ([QQFileManage isContainAtPath:CahePath]) {
        return CahePath;
    }else{
        [QQFileManage CreateFolderWithPath:[QQFileManage GetCachesPath] FolderName:@"MCDownload" Success:^(NSString *Path, NSError *error) {
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
        _Configuration.allowsCellularAccess = NO;
    }
    return _Configuration;
}
- (NSURLSession *)Session
{
    _Session = [NSURLSession sessionWithConfiguration:self.Configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    return _Session;
}
@end
