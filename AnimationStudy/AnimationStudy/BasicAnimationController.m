//
//  BasicAnimationController.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/4/16.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "BasicAnimationController.h"
@interface BasicAnimationController ()
@property (weak, nonatomic) IBOutlet UIImageView *WorkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *PersonImageView;
@property (weak, nonatomic) IBOutlet UILabel *shakeLable;
@end
@implementation BasicAnimationController

- (void)viewDidLoad{
    
}
//- (void)addAnimation:(CAAnimation *)anim forKey:(nullable NSString *)key;
//如果不指定forkey每次都会添加一个新的动画，越来越快
/**  + (instancetype)animationWithKeyPath:(nullable NSString *)path;
 *  path:需要产生动画效果的属性，可以改变的属性：
 *  transform.scale 比例转换   、bounds、position、cornerRadius、borderWidth、。。。。
 *
 *
 *
 *
 */
/*---------------------------------------------关键帧动画--------------------------------------------------*/
#pragma mark --- 模拟app抖动
- (IBAction)animation_shake:(id)sender {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.values = @[@(-M_PI / 36),@(M_PI / 36),@(M_PI / 36)];
    animation.duration = 0.15;
    animation.repeatCount = CGFLOAT_MAX;
    [self.WorkImageView.layer addAnimation:animation forKey:@"animation_shake"];
}
#pragma mark --- path 属性
- (IBAction)animation_path:(id)sender {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 150, 150)];
    animation.path = path.CGPath;
    [self.PersonImageView.layer addAnimation:animation forKey:@"animatjion_path"];
}
#pragma mark --- values 属性
- (IBAction)animation_values:(id)sender {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    CGPoint point1 = CGPointMake(100, 300);
    CGPoint point2 = CGPointMake(50, 200);
    CGPoint point3 = CGPointMake(100, 100);
    CGPoint point4 = CGPointMake(50, 200);
    CGPoint point5 = CGPointMake(100, 300);
    animation.values = @[[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2],[NSValue valueWithCGPoint:point3],[NSValue valueWithCGPoint:point4],[NSValue valueWithCGPoint:point5]];
    [self.PersonImageView.layer addAnimation:animation forKey:@"animation_values"];
}
- (IBAction)shakeButtonClicked:(id)sender {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat duration = 5;
    animation.values = @[@(-duration),@(0),@(duration),@(0),@(-duration),@(0),@(duration),@(0)];
    animation.duration = 0.3f;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    [_shakeLable.layer addAnimation:animation forKey:@"shake"];
}
/*---------------------------------------------基本动画--------------------------------------------------*/
#pragma mark --- 旋转
- (IBAction)animation_rotation:(id)sender{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 2;
    animation.repeatCount = 1;
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    [self.PersonImageView.layer addAnimation:animation forKey:@"animation_rotation"];
}
#pragma mark --- 缩放
- (IBAction)animation_scale:(id)sender{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.5;
    animation.fromValue = @(1.0f);
    animation.toValue = @(0.7f);
    animation.repeatCount = 1;
    [self.WorkImageView.layer addAnimation:animation forKey:@"animation_scale"];
}
#pragma mark --- 位移
/**  动画执行完毕以后会回到起始的位置的原因如下：
 *   1、核心动画的本质是在后台移动图层中的内容，控件本身的frame没有发生改变
 *   2、可以通过设置动画代理来观察动画执行完毕之后控件的frame值、layer的frame值、layer的position值都是没有发生改变的
 *   解决方案如下：
 *   1、在动画结束的代理中，改变frame的值就ok
 *   2、在添加动画之前设置 removedOnCompletion = NO，fillMode = kCAFillModeForwards 两个属性就ok，但是控件的frame值始终都没有变化
 */
- (IBAction)animation_position:(id)sender{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.0;//默认动画时间是0.25秒
    //设置动画的属性值
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, 70)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(240, 500)];
    animation.delegate = self;
    
    //当动画执行完毕后不要删除动画对象
    //animation.removedOnCompletion = NO;
    //animation.fillMode = kCAFillModeForwards;
    
    [self.PersonImageView.layer addAnimation:animation forKey:@"animation_position"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
  
}
- (IBAction)animation_shadow:(id)sender{
    //阴影颜色
    self.PersonImageView.layer.shadowColor = [UIColor yellowColor].CGColor;
    //阴影偏移
    self.PersonImageView.layer.shadowOffset = CGSizeMake(-5, -5);
    //阴影的透明度
    self.PersonImageView.layer.shadowOpacity = 1;
    //阴影半径（半径越大，阴影效果越明显）
    self.PersonImageView.layer.shadowRadius = 5;
}
@end
