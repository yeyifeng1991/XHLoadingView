//
//  HXLoadingView.h
//  XHLoadingGIf
//
//  Created by mc on 2018/6/26.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 1.导入系统的库
 ImageIO  https://my.oschina.net/u/2340880/blog/838680
 MobileCoreServices
 */
@interface XHLoadingView : UIView
// 动画消失
+(void)endLoading;
@property (nonatomic,assign) NSTimeInterval timeDelay;// 时间间隔 默认为5s
@property (nonatomic,assign) NSTimeInterval animationSpeed;// 动画评率 默认为0.05
@property (nonatomic,strong) UIView * showView; // 动画展示的View  默认为主视图的View
@property (nonatomic,strong) NSString * gifName; // 动画的名称 默认动画名称为run
// 展示动画 不会消失
+(void)showLoading;
// 开始动画 默认时间消失
+(void)startLoading;
/*
 @showView 展示的View
 @timeDelay 消失的时间
 */
+(void)showWithView:(UIView*)showView dismissDelay:(NSTimeInterval)timeDelay;
/*
 @showView 展示的View
 @timeDelay 消失的时间
 @Speed     动画运行的速度
 */
+(void)showWithView:(UIView*)showView animationSpeed:(NSTimeInterval)Speed dismissDelay:(NSTimeInterval)timeDelay;
/*
 @showView 展示的View
 @gifName  动画的名称
 @timeDelay 消失的时间
 @Speed     动画运行的速度
 */
+(void)showWithView:(UIView*)showView gifName:(NSString*)gifName animationSpeed:(NSTimeInterval)Speed dismissDelay:(NSTimeInterval)timeDelay;

@end
