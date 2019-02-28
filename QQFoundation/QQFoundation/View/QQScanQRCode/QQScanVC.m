//
//  QQScanVC.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/8/26.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQScanVC.h"
#define QRCodeWidth  260.0   //正方形二维码的边长
#define SCREENWidth  [UIScreen mainScreen].bounds.size.width   //设备屏幕的宽度
#define SCREENHeight [UIScreen mainScreen].bounds.size.height //设备屏幕的高度

@interface QQScanVC ()

@end

@implementation QQScanVC
{
    AVCaptureSession *session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initUI];
    [self initScan];
}
- (void)initUI{
    
    //设置统一的视图颜色和视图的透明度
    UIColor *color = [UIColor blackColor];
    float alpha = 0.7;
    
    //设置扫描区域外部上部的视图
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 64, SCREENWidth, (SCREENHeight-64-QRCodeWidth)/2.0-64);
    topView.backgroundColor = color;
    topView.alpha = alpha;
    
    //设置扫描区域外部左边的视图
    UIView *leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, 64+topView.frame.size.height, (SCREENWidth-QRCodeWidth)/2.0,QRCodeWidth);
    leftView.backgroundColor = color;
    leftView.alpha = alpha;
    
    //设置扫描区域外部右边的视图
    UIView *rightView = [[UIView alloc]init];
    rightView.frame = CGRectMake((SCREENWidth-QRCodeWidth)/2.0+QRCodeWidth,64+topView.frame.size.height, (SCREENWidth-QRCodeWidth)/2.0,QRCodeWidth);
    rightView.backgroundColor = color;
    rightView.alpha = alpha;
    
    //设置扫描区域外部底部的视图
    UIView *botView = [[UIView alloc]init];
    botView.frame = CGRectMake(0, 64+QRCodeWidth+topView.frame.size.height,SCREENWidth,SCREENHeight-64-QRCodeWidth-topView.frame.size.height);
    botView.backgroundColor = color;
    botView.alpha = alpha;
    
    //将设置好的扫描二维码区域之外的视图添加到视图图层上
    [self.view addSubview:topView];
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:botView];

}
- (void)initScan
{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if (!input) return;
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置有效扫描区域
    //有效区域的的frame 是屏幕的右上角为原点 数值是0 ～ 1
    //特别注意的地方：有效的扫描区域，定位是以设置的右顶点为原点。屏幕宽所在的那条线为y轴，屏幕高所在的线为x轴
    CGFloat x = ((SCREENHeight-QRCodeWidth-64)/2.0)/SCREENHeight;
    CGFloat y = ((SCREENWidth-QRCodeWidth)/2.0)/SCREENWidth;
    CGFloat width = QRCodeWidth/SCREENWidth;
    CGFloat height = QRCodeWidth/SCREENWidth;
    output.rectOfInterest = CGRectMake(x,
                                       y,
                                       width,
                                       height);
    CGRect scanCrop=[self getScanCrop:CGRectMake(x, y, width, height) readerViewBounds:self.view.frame];
    output.rectOfInterest = scanCrop;
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    [session addInput:input];
    [session addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //开始捕获
    [session startRunning];
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(QQScanVC:didScanResult:)]) {
        [self.delegate QQScanVC:self didScanResult:metadataObjects];
    }
//    [session stopRunning];
    NSLog(@"%@",metadataObjects);
}
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds) + 30;
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds) + 30;
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds) - 60;
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds) - 60;
    
    return CGRectMake(x, y, width, height);
    
}
@end
