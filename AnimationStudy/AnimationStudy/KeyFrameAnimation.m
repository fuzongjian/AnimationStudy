//
//  KeyFrameAnimation.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/4/16.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "KeyFrameAnimation.h"
@interface KeyFrameAnimation ()
@property (nonatomic,strong) NSMutableArray * photoArray;
@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;
@end
@implementation KeyFrameAnimation
- (void)viewDidLoad{
    for (int i = 1; i < 11; i ++) {
        NSString * path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"gif_%d.png",i] ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        [self.photoArray addObject:image];
    }
    // 帧动画时间
    self.animationImageView.animationDuration = 0.8;
    // 设置帧动画序列
    self.animationImageView.animationImages = self.photoArray;
    // 0 表示无限循环
    self.animationImageView.animationRepeatCount = 0;
}
- (IBAction)StartAnimation:(id)sender {
    [self.animationImageView startAnimating];
}
- (NSMutableArray *)photoArray{
    if (_photoArray == nil) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}
@end
