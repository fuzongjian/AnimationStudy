//
//  LoadingView.h
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/5/5.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LoadingType){
    //三个点在一条直线上运动
    LoadingTypeThreeDot,
    //10个圆点围成一个圆进行旋转
    LoadingTypeCircleDot,
    //许多圆点围城一个圆进行旋转
    LoadingTypeCircleDots,
    //以图片为基础
    LoadingTypeImage,
    //三根线条上下抖动
    LoadingTypeLine,
    //三个点围成一个三角形旋转
    LoadingTypeTriangle,
    //点组成的正方形动画
    LoadingTypeQurate,
};
@interface LoadingView : UIView
//至于控制器view之上
+ (void)showOnView:(UIView *)view type:(LoadingType)loadingType;
//置于window之上，
+ (void)showLoadingViewType:(LoadingType)loadingType userInteractionEnabled:(BOOL)enable;
+ (void)hide;
@end
