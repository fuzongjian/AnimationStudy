//
//  LoadingView.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/5/5.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "LoadingView.h"
@interface LoadingView ()
@property (nonatomic,strong) CALayer * loadingLayer;
@end
@implementation LoadingView
+ (void)showLoadingToView:(UIView *)view{
    LoadingView * loading = [[self alloc] initWithView:view];
    [view addSubview:loading];
}

+ (void)hidenLoadingFromView:(UIView *)view{
    for (UIView * otherView in view.subviews) {
        if ([otherView isKindOfClass:self]) {
            [otherView removeFromSuperview];
            return;
        }
    }
}
- (id)initWithView:(UIView *)view{
    return [self initWithFrame:view.frame];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setUpFrame:frame];
        [self startAnimation];
    }
    return self;
}
- (void)setUpFrame:(CGRect)frame{
    self.frame = CGRectMake(0, 0, 100, 100);
    self.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.loadingLayer = [CALayer layer];
    self.loadingLayer.contents = (__bridge id)([UIImage imageNamed:@"icon_downloading"].CGImage);
    self.loadingLayer.bounds = CGRectMake(0, 0, 90, 90);
    self.loadingLayer.position = center;
    [self.layer addSublayer:self.loadingLayer];
}
- (void)startAnimation{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = HUGE_VAL;
    animation.duration = 1;
    
    animation.cumulative = YES;
    animation.beginTime = CACurrentMediaTime();
    [self.loadingLayer addAnimation:animation forKey:@"rotationAnimation"];
    
    
    NSArray * values = [self valueArrayWithWidth:100];
    CAKeyframeAnimation * boundsAnimation = [self bounsAnimationWithValues:values];
    [self.loadingLayer addAnimation:boundsAnimation forKey:nil];
}
- (CAKeyframeAnimation *)bounsAnimationWithValues:(NSArray *)values {
    CAKeyframeAnimation *boundsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.duration = 0.6;
    boundsAnimation.beginTime = CACurrentMediaTime();
    boundsAnimation.values = values;
    boundsAnimation.keyTimes = @[@(0),@(0.3),@(0.6)];
    boundsAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    boundsAnimation.removedOnCompletion = NO;
    boundsAnimation.fillMode = kCAFillModeForwards;
    return boundsAnimation;
}
- (NSArray *)valueArrayWithWidth:(CGFloat)width {
    return @[[NSValue valueWithCGRect:CGRectMake(0, 0, width * 0.7, width * 0.7)],
             [NSValue valueWithCGRect:CGRectMake(0, 0, width, width)],
             [NSValue valueWithCGRect:CGRectMake(0, 0, width * 0.9, width * 0.9)]];
}

@end
