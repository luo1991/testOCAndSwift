//
//  ToastLabelView.m
//  Doctor_Square
//
//  Created by 董力祯 on 16/7/21.
//  Copyright © 2016年 董力祯. All rights reserved.
//

#import "ToastLabelView.h"

@implementation ToastLabelView

-(id)init{

    self=[[[NSBundle mainBundle] loadNibNamed:@"ToastLabelView" owner:self options:nil] lastObject];
    if (self) {

        UIImageView *view=[self viewWithTag:888];
        view.image=[ToastView resizeableImage:[UIImage imageNamed:@"toastBack"] withEdge:UIEdgeInsetsMake(20, 20, 20, 20)];
    }
    return self;
}

@end
