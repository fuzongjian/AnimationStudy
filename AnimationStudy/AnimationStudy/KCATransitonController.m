//
//  KCATransitonController.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/4/16.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "KCATransitonController.h"
@interface KCATransitonController ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *SecondImageView;
@end
@implementation KCATransitonController
- (void)viewDidLoad{
    
}

- (IBAction)SwipeRight:(UISwipeGestureRecognizer *)sender {
    CATransition * animation = [[CATransition alloc] init];
    //设置过渡类型即过渡效果
    //#define定义的常量
    NSArray * typeArrayOne = [NSArray arrayWithObjects:kCATransitionMoveIn,kCATransitionFade,kCATransitionPush,kCATransitionReveal, nil];
    //用字符串表示
    NSArray * typeArrayTwo = [NSArray arrayWithObjects:@"pageCurl",@"pageUnCurl",@"rippleEffect", @"suckEffect",@"cube",@"oglFlip",nil];
    //  .subtype属性过渡方向
    animation.type = [typeArrayTwo objectAtIndex:(arc4random() % 6)];
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        animation.subtype = kCATransitionFromRight;
    }else{
        animation.subtype = kCATransitionFromLeft;
    }
    int imageIndex = arc4random() % 30;
    //下面这种方式加载图片，内存最终会被释放
    NSString * imageName = [NSString stringWithFormat:@"%d.jpg",imageIndex];
    NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    self.ImageView.image = [UIImage imageWithContentsOfFile:path];
    [self.ImageView.layer addAnimation:animation forKey:@"animation_swipe"];
    
}
#pragma mark --- UIView的类方法实现转场动画
/*----------------------------------------- UIViewAnimationOptions -----------------------------------------------*/
//UIViewAnimationOptionLayoutSubviews //提交动画的时候布局子控件，表示子控件将和父控件一同动画。
//UIViewAnimationOptionAllowUserInteraction //动画时允许用户交流，比如触摸
//UIViewAnimationOptionBeginFromCurrentState //从当前状态开始动画
//UIViewAnimationOptionRepeat //动画无限重复
//UIViewAnimationOptionAutoreverse //执行动画回路,前提是设置动画无限重复
//UIViewAnimationOptionOverrideInheritedDuration //忽略外层动画嵌套的执行时间
//UIViewAnimationOptionOverrideInheritedCurve //忽略外层动画嵌套的时间变化曲线
//UIViewAnimationOptionAllowAnimatedContent //通过改变属性和重绘实现动画效果，如果key没有提交动画将使用快照
//UIViewAnimationOptionShowHideTransitionViews //用显隐的方式替代添加移除图层的动画效果
//UIViewAnimationOptionOverrideInheritedOptions //忽略嵌套继承的选项
////时间函数曲线相关‘
//UIViewAnimationOptionCurveEaseInOut //时间曲线函数，由慢到快
//UIViewAnimationOptionCurveEaseIn //时间曲线函数，由慢到特别快
//UIViewAnimationOptionCurveEaseOut //时间曲线函数，由快到慢
//UIViewAnimationOptionCurveLinear //时间曲线函数，匀速
//转场动画相关的
//UIViewAnimationOptionTransitionNone //无转场动画
//UIViewAnimationOptionTransitionFlipFromLeft //转场从左翻转
//UIViewAnimationOptionTransitionFlipFromRight //转场从右翻转
//UIViewAnimationOptionTransitionCurlUp //上卷转场
//UIViewAnimationOptionTransitionCurlDown //下卷转场
//UIViewAnimationOptionTransitionCrossDissolve //转场交叉消失
//UIViewAnimationOptionTransitionFlipFromTop //转场从上翻转
//UIViewAnimationOptionTransitionFlipFromBottom //转场从下翻转
#pragma mark --- UIView的类方法实现转场动画
- (IBAction)UIViewAnimation_Swipe:(UISwipeGestureRecognizer *)sender {
    NSString * imageName = [NSString stringWithFormat:@"%d.jpg",arc4random() % 30];
    NSString * path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    self.SecondImageView.image = [UIImage imageWithContentsOfFile:path];
    [UIView transitionWithView:self.SecondImageView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
//    [UIView transitionFromView:self.ImageView toView:self.SecondImageView duration:0.5 options:UIViewAnimationOptionAllowUserInteraction completion:^(BOOL finished) {
//        
//    }];
}

@end
