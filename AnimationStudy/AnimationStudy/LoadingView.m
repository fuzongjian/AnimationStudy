//
//  LoadingView.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/5/5.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "LoadingView.h"

static LoadingView * loadingView;
@interface LoadingView()
@property (nonatomic,strong) CAReplicatorLayer * replicatorLayer;
@end
@implementation LoadingView
- (instancetype)initWithFrame:(CGRect)frame type:(LoadingType)loadingType{
    if (self = [super initWithFrame:frame]) {
        switch (loadingType) {
            case LoadingTypeCircleDot:
                [self animation_circleDot];
                break;
            case LoadingTypeImage:
                [self animation_image];
                break;
            case LoadingTypeThreeDot:
                [self animation_threeDot];
                break;
            case LoadingTypeCircleDots:
                [self animation_circleDots];
                break;
            case LoadingTypeLine:
                [self animation_line];
                break;
            case LoadingTypeTriangle:
                [self animation_triangle];
                break;
            case LoadingTypeQurate:
                [self animation_qurare];
                break;
            default:
                break;
        }
    }
    return self;
}
+ (void)showOnView:(UIView *)view type:(LoadingType)loadingType{
    [self hide];
    loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) type:loadingType];
    loadingView.center = view.center;
    loadingView.backgroundColor = [UIColor clearColor];
    [view addSubview:loadingView];
}
+ (void)showLoadingViewType:(LoadingType)loadingType userInteractionEnabled:(BOOL)enable{
    [self hide];
    if (enable) {
        loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) type:loadingType];
    }else{
        loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) type:loadingType];
    }
    loadingView.backgroundColor = [UIColor clearColor];
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    loadingView.center = window.center;
    [window addSubview:loadingView];
}
+ (void)hide{
    if (loadingView) {
        [loadingView removeFromSuperview];
    }
}
- (void)animation_qurare{
    CABasicAnimation * (^getAnimation)(void) = ^{
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"transform"];
        basic.fromValue         = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];
        basic.toValue           = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0)];
        basic.duration          = 0.8;
        basic.repeatCount       = HUGE;
        basic.autoreverses      = YES;
        return basic;
    };
    CABasicAnimation * (^getSecondAnimation)(void) = ^{
        CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alpha.fromValue         = @(1.0);
        alpha.toValue           = @(0.0);
        return alpha;
    };
    CALayer * (^getLayer)(void) = ^{
        /*        基本间距及模板层的创建         */
        NSInteger column                    = 3;
        CGFloat between                     = 5.0;
        CGFloat radius                      = (50 - between * (column - 1))/column;
        CAShapeLayer *shape                 = [CAShapeLayer layer];
        shape.frame                         = CGRectMake(0, 0, radius, radius);
        shape.path                          = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
        shape.fillColor                     = [UIColor redColor].CGColor;
        
        
        /*        创建动画组         */
        CAAnimationGroup *animationGroup    = [CAAnimationGroup animation];
        animationGroup.animations           = @[getAnimation(), getSecondAnimation()];
        animationGroup.duration             = 0.8;
        animationGroup.autoreverses         = YES;
        animationGroup.repeatCount          = HUGE;
        [shape addAnimation:animationGroup forKey:@"groupAnimation"];
        
        
        /*        创建第一行的动画克隆层对象         */
        CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
        replicatorLayerX.frame              = CGRectMake(0, 0, 100, 100);
        replicatorLayerX.instanceDelay      = 0.3;
        replicatorLayerX.instanceCount      = column;
        replicatorLayerX.instanceTransform  = CATransform3DTranslate(CATransform3DIdentity, radius+between, 0, 0);
        [replicatorLayerX addSublayer:shape];
        
        
        /*        创建3行的动画克隆层对象         */
        CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
        replicatorLayerY.frame              = CGRectMake(0, 0, 50, 50);
        replicatorLayerY.instanceDelay      = 0.3;
        replicatorLayerY.instanceCount      = column;
        
        
        /*        给CAReplicatorLayer对象的子层添加转换规则 这里决定了子层的布局         */
        replicatorLayerY.instanceTransform  = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
        [replicatorLayerY addSublayer:replicatorLayerX];
        return replicatorLayerY;
    };
    CALayer * layer = getLayer();
    layer.position = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    [self.layer addSublayer:layer];
}
- (void)animation_triangle{
    
    //模板层初始化
    CGFloat radius = 100.0/6.0;
    CGFloat transX = 100 - radius;
    CAShapeLayer * dotLayer = [CAShapeLayer layer];
    dotLayer.frame = CGRectMake(0, 0, radius, radius);
    dotLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    dotLayer.strokeColor = [UIColor redColor].CGColor;
    dotLayer.fillColor = [UIColor redColor].CGColor;
    dotLayer.lineWidth = 1;
    CABasicAnimation * (^getAnimation)(void) = ^{
        
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
        animation.fromValue         = [NSValue valueWithCATransform3D:fromValue];
        CATransform3D toValue   = CATransform3DTranslate(CATransform3DIdentity, 100 - 100 / 6.0, 0.0, 0.0);
        toValue                 = CATransform3DRotate(toValue,2*M_PI/3.0, 0.0, 0.0, 1.0);
        animation.toValue           = [NSValue valueWithCATransform3D:toValue];
        animation.autoreverses      = NO;
        animation.repeatCount       = HUGE;
        animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration          = 0.8;
        return  animation;
    };
    [dotLayer addAnimation:getAnimation() forKey:@"rotateAnimation"];
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, radius, radius);
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceDelay = 0.0;
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120*M_PI/180.0, 0.0, 0.0, 1.0);
    replicatorLayer.instanceTransform = trans3D;
    [replicatorLayer addSublayer:dotLayer];
    [self.layer addSublayer:replicatorLayer];
    
}
- (void)animation_line{
    self.replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1].CGColor;
    [self.layer addSublayer:self.replicatorLayer];
    
    CGFloat count = 3;
    CGFloat lineH = 50;
    CGFloat lineMarginX = 40;
    CGFloat lineInter = 10;
    CGFloat lineW = 5;
    
    CALayer * lineLayer = [CALayer layer];
    lineLayer.bounds = CGRectMake(0, 0, lineW, lineH);
    lineLayer.position = CGPointMake(lineMarginX, self.replicatorLayer.frame.size.height - 25);
    lineLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    [self.replicatorLayer addSublayer:lineLayer];
    self.replicatorLayer.instanceCount = count;
    // 每隔layer的间距
    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(lineInter, 0, 0);
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    basicAnimation.toValue = @(lineH * 0.4);
    basicAnimation.duration = 0.5;
    // 原路返回动画一遍（设置动画自动反转即怎么去怎么回来）
    basicAnimation.autoreverses = YES;
    basicAnimation.repeatCount = MAXFLOAT;
    [lineLayer addAnimation:basicAnimation forKey:nil];
    self.replicatorLayer.instanceDelay = 0.5/count;
}

- (void)animation_circleDots{
    self.replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.layer addSublayer:self.replicatorLayer];
    
    CALayer * dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 10, 10);
    dotLayer.position = CGPointMake(50, 20);
    dotLayer.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.6].CGColor;
    dotLayer.cornerRadius = 5;
    dotLayer.masksToBounds = YES;
    [self.replicatorLayer addSublayer:dotLayer];
    
    CGFloat count = 100.0;
    self.replicatorLayer.instanceCount = count;
    self.replicatorLayer.instanceTransform  = CATransform3DMakeRotation(2*M_PI/count, 0, 0, 1);
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.duration = 1.0;
    basicAnimation.fromValue = @1;
    basicAnimation.toValue = @0.1;
    basicAnimation.repeatCount = MAXFLOAT;
    [dotLayer addAnimation:basicAnimation forKey:nil];
    
    self.replicatorLayer.instanceDelay = 1.0/count;
    dotLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
}
- (void)animation_threeDot{
    self.replicatorLayer.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5].CGColor;
    [self.layer addSublayer:self.replicatorLayer];
    
    // 震动层
    CALayer * dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 15, 15);
    dotLayer.position = CGPointMake(15, self.replicatorLayer.frame.size.height/2.0);
    dotLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer.cornerRadius = 7.5;
    [self.replicatorLayer addSublayer:dotLayer];
    
    self.replicatorLayer.instanceCount = 3;// 复制2个layer ＋ 本身 ＝ 3个
    // 拷贝副本的3D变换，每隔layer的间距
    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.replicatorLayer.frame.size.width/3.0, 0, 0);
    
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimation.duration = 0.8;
    basicAnimation.fromValue = @1;
    basicAnimation.toValue = @0;
    basicAnimation.repeatCount = MAXFLOAT;
    [dotLayer addAnimation:basicAnimation forKey:nil];
    
    self.replicatorLayer.instanceDelay = 0.8/3;// 每隔时间出现一个layer
    self.replicatorLayer.instanceGreenOffset = -0.1; //颜色递减值
//    self.replicatorLayer.instanceRedOffset= 0.02;
    
    dotLayer.transform = CATransform3DMakeScale(0, 0, 0);//x、y、z放大缩小的倍数
}
- (void)animation_circleDot{
    
    self.replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.layer addSublayer:self.replicatorLayer];
    
    CGFloat count = 10;
    self.replicatorLayer.instanceCount = count;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(2*M_PI/count, 0, 0, 1);
    self.replicatorLayer.instanceDelay = 1/count;
    
    CALayer *(^returnDotLayer)(void) = ^{
        CALayer * dotLayer = [CALayer layer];
        dotLayer.bounds = CGRectMake(0, 0, 10, 10);
        dotLayer.position = CGPointMake(50, 20);
        dotLayer.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.6].CGColor;
        dotLayer.cornerRadius = 5;
        dotLayer.masksToBounds = YES;
        
        CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        basicAnimation.duration = 1.0;
        basicAnimation.fromValue = @1;
        basicAnimation.toValue = @0.2;
        basicAnimation.repeatCount = MAXFLOAT;
        [dotLayer addAnimation:basicAnimation forKey:nil];
        dotLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
        return dotLayer;
    };
    [self.replicatorLayer addSublayer:returnDotLayer()];
    
    

}

- (void)animation_image{
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    CALayer * loadingLayer = [CALayer layer];
    loadingLayer.contents = (__bridge id)([UIImage imageNamed:@"icon_downloading"].CGImage);
    loadingLayer.bounds = CGRectMake(0, 0, 90, 90);
    loadingLayer.position = center;
    [self.layer addSublayer:loadingLayer];
    
    
    //startAnimation
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = HUGE_VAL;
    animation.duration = 1;
    animation.cumulative = YES;
    animation.beginTime = CACurrentMediaTime();
    [loadingLayer addAnimation:animation forKey:@"rotationAnimation"];
    
    CAKeyframeAnimation *(^returnAnimation)(CGFloat);//代码块的声明
    returnAnimation = ^(CGFloat width){
        NSArray * values = @[[NSValue valueWithCGRect:CGRectMake(0, 0, width * 0.7, width * 0.7)],
                             [NSValue valueWithCGRect:CGRectMake(0, 0, width, width)],
                             [NSValue valueWithCGRect:CGRectMake(0, 0, width * 0.9, width * 0.9)]];
        
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
    };
    
    [loadingLayer addAnimation:returnAnimation(100) forKey:nil];
}
// 懒加载
- (CAReplicatorLayer *)replicatorLayer{
    if (_replicatorLayer == nil) {
        _replicatorLayer =[CAReplicatorLayer layer];
        _replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
        _replicatorLayer.position = self.center;
        _replicatorLayer.cornerRadius = 10;
        _replicatorLayer.masksToBounds = YES;
    }
    return _replicatorLayer;
}
@end
