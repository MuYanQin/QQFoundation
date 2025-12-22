//
//  CPCLSaveFileTool.m
//  QQFoundation
//
//  Created by peanut on 2024/11/21.
//  Copyright © 2024 慕纯. All rights reserved.
//

#import "CPCLSaveFileTool.h"
@interface CPCLSaveFileTool ()<UIDocumentPickerDelegate>
@property(nonatomic,copy) void (^callBack)(NSDictionary<NSString*,NSObject*>*);
@end
@implementation CPCLSaveFileTool
- (void)saveWithPath:(NSString *)path{
    UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc] initWithURL:[NSURL fileURLWithPath:path] inMode:UIDocumentPickerModeExportToService];
    // 设置代理
    documentPickerVC.delegate = self;
    // 设置模态弹出方式
    documentPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:documentPickerVC animated:YES completion:nil];

}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    // 获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        // 通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            // 读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            //NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            if (error) {
                // 读取出错
            } else {
                // 上传
                NSLog(@"fileName : %@", fileName);
            }
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    } else {
        // 授权失败
    }
}
@end
