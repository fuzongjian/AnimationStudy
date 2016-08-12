//
//  LoadingController.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/5/5.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "LoadingController.h"
#import "LoadingView.h"
@interface LoadingController ()
@property (nonatomic,strong) NSTimer * timer;
@end
@implementation LoadingController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [LoadingView showOnView:self.view type:6];
}
- (IBAction)startButtonClicked:(id)sender {
    [self timerMethod];
    [self.timer fire];
    [LoadingView showOnView:self.view type:0];
}
- (IBAction)stopButtonClicked:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    [LoadingView hide];
}

- (void)timerMethod{
    static NSInteger count = 0;
    if (count > 6) {
        count = 0;
    }
    [LoadingView showOnView:self.view type:count];
    count ++;
}
- (NSTimer *)timer{
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    }
    return _timer;
}
@end
