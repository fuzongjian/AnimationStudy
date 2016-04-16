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

@end
