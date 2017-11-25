//
//  ToastView.m
//  Doctor_Square
//
//  Created by 董力祯 on 16/5/11.
//  Copyright © 2016年 董力祯. All rights reserved.
//

#import "ToastView.h"
#import "ViewZoom.h"

@implementation ToastView

+(void)showViewWithTitle:(NSString *)title toast:(NSString *)toast{

    UIView *view=[[[NSBundle mainBundle] loadNibNamed:@"ToastView" owner:self options:nil] lastObject];
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=5;
    UILabel *titleLabel=[view viewWithTag:100];
    titleLabel.text=title;
    
    UILabel *toastLabel=[view viewWithTag:101];
    toastLabel.text=toast;
    
    CGRect frame=view.frame;
    frame.size.height=[self CGSizeWithSize:CGSizeMake(frame.size.width-80, 0) andText:toast andFont:toastLabel.font].height+85;
    frame.origin.x=(MainWidth-frame.size.width)/2;
    frame.origin.y=(MainHeight-frame.size.height)/2;
    view.frame=frame;
    [ViewZoom showSubView:view];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}
+(CGSize)CGSizeWithSize:(CGSize)size andText:(NSString*)text andFont:(UIFont*)font{
    
    if (!text.length) {
        return size;
    }
    CGSize lastSize=CGSizeZero;
    if (size.width==0) {
        lastSize=CGSizeMake(CGFLOAT_MAX, size.height);
    }
    if (size.height==0) {
        lastSize=CGSizeMake(size.width, CGFLOAT_MAX);
    }
    size=[text boundingRectWithSize:lastSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:NULL].size;
    size.height+=1;
    
    return size;
}

+ (UIImage *)resizeableImage:(UIImage *)image withEdge: (UIEdgeInsets)edgeset{
    
    return  [image resizableImageWithCapInsets:edgeset resizingMode:UIImageResizingModeTile];
}

+(void)dismiss{

    [ViewZoom dismiss];
}

@end
