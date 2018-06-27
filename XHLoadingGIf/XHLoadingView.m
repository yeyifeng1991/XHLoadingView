//
//  HXLoadingView.m
//  XHLoadingGIf
//
//  Created by mc on 2018/6/26.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "XHLoadingView.h"
#define  GIF_WIDTH 80*1.2
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface XHLoadingView ()
@property (nonatomic, strong)NSMutableArray<UIImage *> *images;
@property (nonatomic, strong)XHLoadingView *loading;
@property (nonatomic, strong)UIView *gifContentView;

@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;
@property (nonatomic, strong)NSTimer *timer;


@end
@implementation XHLoadingView

- (instancetype)init{
    self = [self initWithFrame:CGRectMake(0, 0, GIF_WIDTH, GIF_WIDTH)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = GIF_WIDTH/2;
        self.layer.masksToBounds = YES;
        self.timeDelay = 5.0;
        self.animationSpeed = 0.05;
        self.showView = [UIApplication sharedApplication].delegate.window;
        self.gifName = @"run";// 默认动画名称为run
//         self.gifName = @"ride";// 默认动画名称为run
  
    }
    return self;
}
// 会在默认时间消失
+ (void)startLoading{
    
    XHLoadingView *loading = [[self alloc]init];
//    UIWindow *keyView = [UIApplication sharedApplication].delegate.window;
    loading.center =loading.showView.center;
    
    [loading.showView addSubview:loading];
    [loading createGif];
    dispatch_main_after(loading.timeDelay, ^{
        [XHLoadingView endLoading];
    });
    
}
// 展示动画 不会消失
+(void)showLoading;
{
    XHLoadingView *loading = [[self alloc]init];
    //    UIWindow *keyView = [UIApplication sharedApplication].delegate.window;
    loading.center =loading.showView.center;
    
    [loading.showView addSubview:loading];
    [loading createGif];
    
}
/*
 @showView 展示的View
 @timeDelay 消失的时间
 */
+(void)showWithView:(UIView*)showView dismissDelay:(NSTimeInterval)timeDelay;
{
    XHLoadingView *loading = [[self alloc]init];
//    UIWindow *keyView = [UIApplication sharedApplication].delegate.window;
    loading.showView = showView;
    loading.timeDelay = timeDelay;
    loading.center = showView.center;
    [loading.showView addSubview:loading];
    [loading createGif];
    dispatch_main_after(loading.timeDelay, ^{
        [loading endLoading];
    });
}
/*
 @showView 展示的View
 @timeDelay 消失的时间
 @Speed     动画运行的速度
 */
+(void)showWithView:(UIView*)showView animationSpeed:(NSTimeInterval)Speed dismissDelay:(NSTimeInterval)timeDelay;
{
    XHLoadingView *loading = [[self alloc]init];
    //    UIWindow *keyView = [UIApplication sharedApplication].delegate.window;
    loading.showView = showView;
    loading.timeDelay = timeDelay;
    loading.animationSpeed = Speed;
    loading.center = showView.center;
    [loading.showView addSubview:loading];
    [loading createGif];
    dispatch_main_after(timeDelay, ^{
        [loading endLoading];
    });

}
/*
 @showView 展示的View
 @gifName  动画的名称
 @timeDelay 消失的时间
 @Speed     动画运行的速度
 */
+(void)showWithView:(UIView*)showView gifName:(NSString*)gifName animationSpeed:(NSTimeInterval)Speed dismissDelay:(NSTimeInterval)timeDelay;
{
    XHLoadingView *loading = [[self alloc]init];
    //    UIWindow *keyView = [UIApplication sharedApplication].delegate.window;
    loading.showView = showView;
    loading.timeDelay = timeDelay;
    loading.animationSpeed = Speed;
    loading.center = showView.center;
    loading.gifName = gifName;
    [loading.showView addSubview:loading];
    [loading createGif];
//    [loading createGif:loading.gifName];
    dispatch_main_after(timeDelay, ^{
        [loading endLoading];
    });
}
#pragma mark - 创建gif动画
- (void)createGif{
    
    //    _gifContentView.layer.borderColor = UIColorFromRGB(No_Choose_Color).CGColor;
    //    _gifContentView.layer.borderWidth = 1.0;
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    _gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:self.gifName ofType:@"gif"]];
    _gif = CGImageSourceCreateWithData((CFDataRef)gif, (CFDictionaryRef)_gifDic);
    _count = CGImageSourceGetCount(_gif);
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.animationSpeed target:self selector:@selector(startLoading) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)startLoading
{
    _index ++;
    _index = _index%_count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}

+ (void)endLoading{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[XHLoadingView class]]) {
            //            [UIView animateWithDuration:1.0 animations:^{
            //                view.alpha = 0;
            //            } completion:^(BOOL finished) {
            [((XHLoadingView *)view) stopGif];
            [view removeFromSuperview];
            //            }];
        }
    }
    
}
-(void)endLoading{
    for (UIView *view in self.showView.subviews) {
        if ([view isKindOfClass:[XHLoadingView class]]) {
            //            [UIView animateWithDuration:1.0 animations:^{
            //                view.alpha = 0;
            //            } completion:^(BOOL finished) {
            [((XHLoadingView *)view) stopGif];
            [view removeFromSuperview];
            //            }];
        }
    }
    
}

- (void)stopGif
{
    [_timer invalidate];
    _timer = nil;
}
- (void)dealloc{
    CFRelease(_gif);
}

static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}


@end
