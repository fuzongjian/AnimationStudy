//
//  TimerAnimation.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/4/16.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "TimerAnimation.h"
@interface TimerAnimation ()
@property (weak, nonatomic) IBOutlet UIView *ClockView;
@property (nonatomic,strong) UIView * second;
@end
@implementation TimerAnimation
- (void)viewDidLoad{
    _second = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 50)];
    _second.center = self.view.center;
/**
 *      anchorPoint 表示支点位置的坐标占bounds得比例，默认为中心点（0.5，0.5）旋转的中心点
 *
 */
    _second.layer.anchorPoint = CGPointMake(1, 1);
    _second.backgroundColor = [UIColor redColor];
    [self.view addSubview:_second];
    CADisplayLink * timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveSecond)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}
- (void)moveSecond{
    //计算当前的秒数
    NSDate * nowDate = [NSDate date];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSInteger seconds = [calendar component:NSCalendarUnitSecond fromDate:nowDate];
    //计算每一秒的弧度
    CGFloat roration = M_PI * 2 / 60;
    //每一秒的弧度 * 秒数，计算出本次要旋转的弧度
    roration = seconds * roration;
    //旋转秒针
    self.second.transform = CGAffineTransformMakeRotation(roration);
}
#pragma mark --- transform 解释
/**
 *   一、创建基于控件初始位置的形变
 *    CGAffineTransformMakeTranslation --- 平移
 *    CGAffineTransformMakeScale --- 缩放
 *    CGAffineTransformMakeRotation --- 旋转（正顺负逆）
 *
 *   二、基于transform参数的形变
 *    CGAffineTransformTranslate
 *    CGAffineTransformScale
 *    CGAffineTransformRotate
 */

@end
