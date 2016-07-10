//
//  LoadingView.h
//  AnimationStudy
//
//  Created by 陈舒澳 on 16/5/5.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,LoadingType){
    LoadingTypeThreeDot,
    LoadingTypeCircleDot,
    LoadingTypeCircleDots,
    LoadingTypeImage,
    LoadingTypeLine,
};
@interface LoadingView : UIView
//至于控制器view之上
+ (void)showOnView:(UIView *)view type:(LoadingType)loadingType;
//置于window之上，
+ (void)showLoadingViewType:(LoadingType)loadingType userInteractionEnabled:(BOOL)enable;
+ (void)hide;
@end
