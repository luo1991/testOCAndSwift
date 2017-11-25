//
//  ViewZoom.m
//  美图聊聊
//
//  Created by 董力祯 on 15/4/26.
//  Copyright (c) 2015年 MTLL. All rights reserved.
//

#import "ViewZoom.h"
#import "AppDelegate.h"

@implementation ViewZoom

static ViewZoom *zoom;

+(void)showSubView:(UIView *)showView{

    if (!zoom) {
        zoom=[[ViewZoom alloc]init];
        zoom.backgroundColor=XRGBA(0, 0, 0, 0.6);
    }
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=[UIApplication sharedApplication].keyWindow.bounds;
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
    [zoom addSubview:button];

    zoom.frame=[UIApplication sharedApplication].keyWindow.bounds;
    
    [UIView  animateWithDuration:0.5 animations:^{
        [zoom addSubview:showView];
        [[UIApplication sharedApplication].keyWindow addSubview:zoom];
    }];
}
+(void)showAcctionSheetView:(UIView *)showView{

    if (!zoom) {
        zoom=[[ViewZoom alloc]init];
        zoom.backgroundColor=XRGBA(0, 0, 0, 0.6);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [zoom addGestureRecognizer:tap];
    }
    zoom.frame=[UIApplication sharedApplication].keyWindow.bounds;
    
    [zoom addSubview:showView];
    
    CGRect oriFrame=showView.frame;
    CGRect frame=showView.frame;
    frame.origin.y=zoom.frame.size.height;
    showView.frame=frame;
    
    [UIView  animateWithDuration:0.5 animations:^{
        [[UIApplication sharedApplication].keyWindow addSubview:zoom];
        showView.frame=oriFrame;
    }];
}
+(void)dismiss{
    
    [UIView  animateWithDuration:0.5 animations:^{
        for (UIView *subView in zoom.subviews) {
            [subView removeFromSuperview];
        }
        [zoom removeFromSuperview];
    }];
}
@end
