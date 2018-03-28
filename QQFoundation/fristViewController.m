//
//  fristViewController.m
//  QQFoundation
//
//  Created by ZhangQun on 2017/10/12.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "fristViewController.h"
#import "QQButton.h"
#import "fiveViewController.h"
#import "QQTabBarController.h"
#import "QQButton.h"
#import "QQImagePicker.h"
#import "QQTool.h"
#import "QQTextField.h"
#import "QQAlertController.h"
#import "UIView+QQFrame.h"
@interface fristViewController ()

@end

@implementation fristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title  = @"one";

    CGFloat MaxHeight = 60;
    CGFloat MaxWidth = 60;
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 30, 30)];
    imageView.image =[UIImage imageNamed:@"multi_network_error_icon@2x"];
    CGSize imageSize = [imageView sizeThatFits:CGSizeZero];
    if (imageSize.width >MaxWidth && imageSize.height<=MaxHeight) {
        imageView.height =  imageView.height *(imageView.width/MaxWidth);
        imageView.width = MaxWidth;

    }else if (imageSize.height >MaxHeight &&imageSize.width <= MaxWidth){
        imageView.width =  imageView.width *(imageView.height/MaxHeight);
        imageView.height = MaxHeight;
    }else if(imageSize.height >MaxHeight &&imageSize.width>MaxWidth) {
        imageView.width = MaxWidth;
        imageView.height =imageSize.height *(MaxWidth/imageSize.width);
    }else{
        imageView.width = imageSize.width;
        imageView.height= imageSize.height;
    }
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[fiveViewController new] animated:YES];
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
