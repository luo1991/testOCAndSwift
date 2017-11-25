//
//  ToastView.h
//  Doctor_Square
//
//  Created by 董力祯 on 16/5/11.
//  Copyright © 2016年 董力祯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView

+(void)showViewWithTitle:(NSString*)title toast:(NSString*)toast;

+(CGSize)CGSizeWithSize:(CGSize)size andText:(NSString*)text andFont:(UIFont*)font;

+ (UIImage *)resizeableImage:(UIImage *)image withEdge: (UIEdgeInsets)edgeset;

@end
