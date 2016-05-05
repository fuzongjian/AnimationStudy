//
//  LoadingController.m
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/5/5.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "LoadingController.h"
#import "LoadingView.h"
@implementation LoadingController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)startButtonClicked:(id)sender {
    [LoadingView showLoadingToView:self.view];
}
- (IBAction)stopButtonClicked:(id)sender {
    [LoadingView hidenLoadingFromView:self.view];
}
@end
