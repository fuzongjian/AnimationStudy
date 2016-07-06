//
//  WaveViewController.m
//  AnimationStudy
//
//  Created by Shao Jie on 16/7/6.
//  Copyright © 2016年 xingbida. All rights reserved.
//
#define WIDTH     [UIScreen mainScreen].bounds.size.width-20
#import "WaveViewController.h"
#import "WaveView.h"
@interface WaveViewController ()
@property (nonatomic,strong) WaveView * waveView;
@end

@implementation WaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
    _waveView.center = self.view.center;
    [self.view addSubview:_waveView];
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 20, 30)];
    slider.center = CGPointMake(self.view.center.x, _waveView.center.y+WIDTH-100);
    slider.minimumValue = 0.0;
    slider.maximumValue = 100;
    slider.value = (slider.minimumValue + slider.maximumValue)*0.1;
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    // Do any additional setup after loading the view.
}
- (void)sliderChange:(UISlider *)slider{
    _waveView.percent = slider.value/100.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
