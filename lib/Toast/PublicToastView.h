//
//  PublicToastView.h
//  Doctor_Square
//
//  Created by 董力祯 on 16/5/9.
//  Copyright © 2016年 董力祯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ToastShowStyleNormal,
}ToastShowStyle;

@interface PublicToastView : UIView

+(void)showViewWithToast:(NSString*)text superView:(UIView*)superView;

+(void)showViewWithToast:(NSString*)text superView:(UIView*)superView toastShowStyle:(ToastShowStyle)showStyle;

+(void)dismiss;

+(void)showLoadingWithView:(UIView*)view;
+(void)dismissLoadingWithView:(UIView *)view;
@end
