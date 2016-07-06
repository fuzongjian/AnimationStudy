//
//  WaveView.m
//  AnimationStudy
//
//  Created by Shao Jie on 16/7/6.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "WaveView.h"
static CGFloat offset = 0.0;
static CGFloat height = 5;
@interface WaveView ()
@property (nonatomic,strong) CADisplayLink * link;
@end
@implementation WaveView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        _percent = 0.1;
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    offset += 10;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGContextSetLineWidth(context, 1);
    UIColor * blue = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3];
    CGContextSetFillColorWithColor(context, blue.CGColor);
    
    //计算开始的y的位置 y=Asin（ωx+φ）+h
    CGFloat startY = rect.size.height * (1.0 - _percent);
    CGPathMoveToPoint(pathRef, NULL, 0, startY);
    for (CGFloat i = 0.0; i < rect.size.width; i ++) {
        CGFloat y = height * sinf(i*2.5*M_PI/rect.size.width+offset*M_PI/rect.size.width)+startY;
        CGPathAddLineToPoint(pathRef, NULL, i, y);
    }
    CGPathAddLineToPoint(pathRef, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(pathRef, nil, 0, rect.size.height);
    CGContextAddPath(context, pathRef);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(pathRef);
}

- (void)startLink{
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (CADisplayLink *)link{
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(startLinkAnimation)];
    }
    return _link;
}
- (void)startLinkAnimation{
    [self setNeedsDisplay];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = self.layer.frame.size.width / 2;
    self.layer.borderWidth = 2.f;
    [self startLink];
}
- (void)setPercent:(CGFloat)percent{
    _percent = percent;
    if (percent == 0 || percent == 1) {
        height = 1;
    }else{
        height = 10;
    }
    [self startLink];
}
@end
