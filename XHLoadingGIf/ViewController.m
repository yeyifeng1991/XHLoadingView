//
//  ViewController.m
//  XHLoadingGIf
//
//  Created by mc on 2018/6/26.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "ViewController.h"
#import "XHLoadingView.h"
#import "VDGifPlayerTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
    [XHLoadingView startLoading]; // 加载动画
//    [XHLoadingView showLoading];
//    [XHLoadingView showWithView:self.view dismissDelay:10]; // 加载动画设置时间
//    [XHLoadingView showWithView:self.view animationSpeed:0.01 dismissDelay:5]; // 加载动画设置频率
//    [XHLoadingView showWithView:self.view gifName:@"ride" animationSpeed:0.02 dismissDelay:15];
    
//    [VDGifPlayerTool addGifWithName:@"run" toView:self.view];
    
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [XHLoadingView endLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
