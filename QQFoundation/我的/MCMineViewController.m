//
//  MCMineViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/8/8.
//  Copyright © 2018年 Yuan er. All rights reserved.
//

#import "MCMineViewController.h"
#import "MCSearchCell.h"
#import "NSObject+MB.h"
#import "QQImagePicker.h"
#import "CPCLRecorderTool.h"
#import "CPCLLocationTool.h"
#import "CPCLCameraTool.h"
#import "QQFileManage.h"
#import "HSDownloadManager.h"
#import "CPCLSaveFileTool.h"
@interface MCMineViewController ()<QQImagePickerDelegate,UIDocumentPickerDelegate>
@property(strong,nonatomic)CPCLCameraTool *camesTool;
@property(strong,nonatomic)CPCLLocationTool *locationTool;
@property(strong,nonatomic)CPCLRecorderTool *recorderTool;
@property(strong,nonatomic)CPCLSaveFileTool *saveFileTool;

@end

@implementation MCMineViewController
{
    UIButton *btn;
    UIImageView *imagv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.recorderTool = [[CPCLRecorderTool alloc]init];
    btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(100, 200, 100, 40);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(btnClick1) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
    imagv = [[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 70, 70)];
    [self.view addSubview:imagv];

    self.saveFileTool = [[CPCLSaveFileTool alloc]init];
    /***
    self.tabManager[@"MCSearchItem"] = @"MCSearchCell";
    if (self.fromHovering) {
        self.BaseQQTableView.top = 0;
    }else{
        self.BaseQQTableView.height = self.BaseQQTableView.height - MCTabbarHeight;
    }
    [self.BaseQQTableView setUpWithUrl:@"" Parameters:@{@"page":@"1",@"name":@"ahah"} formController:self];
    
    [self.BaseQQTableView setUpWithUrl:@"" Parameters:@{@"name":@"ahah"} formController:self];
     */
}
- (void)btnClick
{
//    QQImagePicker * im = [QQImagePicker ShareInstance];
//    [im initwithCropRect:CGRectMake(50, 200, KScreenWidth - 100, 200) ChoosePicType:(QQChoosePicLibray)];
//    im.delegate = self;
    [self.recorderTool startRecording];
//    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"icon_em_al" ofType:@"png"];
//    [self.saveFileTool saveWithPath:fullPath];
//    UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc] initWithURL:[NSURL fileURLWithPath:fullPath] inMode:UIDocumentPickerModeExportToService];
//    // 设置代理
//    documentPickerVC.delegate = self;
//    // 设置模态弹出方式
//    documentPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self.navigationController presentViewController:documentPickerVC animated:YES completion:nil];

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

- (void)btnClick1
{
//    NSString *  downloadUrl2 = @"https://img2.baidu.com/it/u=2313537653,2504552417&fm=253&fmt=auto&app=120&f=JPEG?w=667&h=500";

//    NSString *  downloadUrl2 = @"https://vrbt.zj.migu.cn/image/circleBg/bg2-3.png";
//    NSString *  downloadUrl2 = @"https://yysgctest.iflytektstd.com/zj.h5.sdk/static/img/com-photo.eda75128.png";
//    NSString *  downloadUrl2 = @"https://freevod.vip.migu.cn/1TeoYW%2Bqq3hZq8UnysnyS0nKsCSPaUCpPUN9fxr8FqEF1y3e9eAnBEDxLrIP2lw7pImyRM62bgJLjNcO45Jz8iaFroQ47uV1RhbtGcQS0ihWm34VUgl50jUJF3fLFCUH/1040080152331651133515564K4HpFk0ringtonemp4-cp-daily1_ringtonemp4-cp-daily.mp4?ec=2&flag=+&F=013015&channelid=08&msisdn=64aacefa-239e-41b0-85a0-86c0f321094b";
//
//    [[HSDownloadManager sharedInstance] deleteAllFile];
//
//    [[HSDownloadManager sharedInstance] download:downloadUrl2  progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//    } state:^(DownloadState state,NSString *path) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (state == DownloadStateCompleted){
//                UIImage *immage = [UIImage imageWithContentsOfFile:path];
//                imagv.image = immage;
//            }
//            
//        });
//    }];
    
//    [QQFileManage createFolderWithPath:[QQFileManage documentsPath] folderName:@"test" success:^(NSString *Path, NSError *error) {
//        if(error == nil){
//
//        }else{
//            NSLog(@"error : %@", error);
//        }
//    }];
    [self.recorderTool stopRecording];
    [self.recorderTool getRecorderWithHandler:^(NSDictionary<NSString *,NSObject *> * dic) {
        NSLog(@"%@",dic);
    }];
//    self.locationTool = [[CPCLLocationTool alloc]init];
//    [self.locationTool getLocationWithHandler:^(NSDictionary<NSString *,NSObject *> * dic) {
//        NSLog(@"11111===");
//    }];
//    self.camesTool = [[CPCLCameraTool alloc]init];
//    [self.camesTool getCameraImageWithHandler:^(NSDictionary<NSString *,NSObject *> * dic) {
//        NSLog(@"11111===");
//    }];
}
- (void)QQtableView:(QQtableView *)QQtableView requestFailed:(NSError *)error
{
    
}
- (void)QQtableView:(QQtableView *)QQtableView isPullDown:(BOOL)PullDown SuccessData:(id)SuccessData
{
    
}
- (void)initUI{
    QQTableViewSection *sec = [QQTableViewSection section];
    
    for (int i = 0; i<=10; i++) {
        MCSearchItem *item = [[MCSearchItem alloc]init];
        item.text = [NSString stringWithFormat:@"mine=%d",i];
        [sec addItem:item];
    }
    [self.BaseMutableArray addObject:sec];
    [self.tabManager replaceWithSectionsFromArray:self.BaseMutableArray];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
