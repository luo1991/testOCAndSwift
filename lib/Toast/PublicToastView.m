//
//  PublicToastView.m
//  Doctor_Square
//
//  Created by 董力祯 on 16/5/9.
//  Copyright © 2016年 董力祯. All rights reserved.
//

#import "PublicToastView.h"

#import "ToastLabelView.h"

@implementation PublicToastView

static PublicToastView *toastView;
static ToastLabelView *toastLabel;


+(void)showViewWithToast:(NSString *)text superView:(UIView *)superView{

    [self showViewWithToast:text superView:superView toastShowStyle:ToastShowStyleNormal];
}

+(void)showViewWithToast:(NSString *)text superView:(UIView *)superView toastShowStyle:(ToastShowStyle)showStyle{

    CGFloat width=superView.frame.size.width;
    CGFloat height=superView.frame.size.height;
    
    //提示框的单例
    if (!toastView) {
        toastView=[[PublicToastView alloc]init];
    }
    toastView.frame=superView.bounds;
    
    switch (showStyle) {
        case ToastShowStyleNormal:{
            
            if (!toastLabel) {
                toastLabel=[[ToastLabelView alloc]init];
            }
            [toastView addSubview:toastLabel];
            
            toastLabel.showLabel.text=text;
            toastLabel.backgroundColor=[UIColor grayColor ];

            CGSize size=[ToastView CGSizeWithSize:CGSizeMake(width-100, 0) andText:text andFont:toastLabel.showLabel.font];
            
            CGRect frame=toastLabel.frame;
            
            frame.size.width=size.width+60;
            frame.size.height=size.height+30;
            
            frame.origin.x=(width-frame.size.width)/2;
            frame.origin.y=(height-frame.size.height-60)/2;
    
            toastLabel.frame=frame;
            
        }
            break;
        default:
            break;
    }
    [superView addSubview:toastView];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0f];
}
+(void)dismiss{
    [UIView animateWithDuration:0.3 animations:^{
        toastView.alpha=0;
    } completion:^(BOOL finished) {
        toastView.alpha=0.98;
        [toastView removeFromSuperview];
        [toastLabel removeFromSuperview];
    }];
}
+(void)showLoadingWithView:(UIView *)view{

    [MBProgressHUD showHUDAddedTo:view animated:YES];
}
+(void)dismissLoadingWithView:(UIView *)view{

    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
