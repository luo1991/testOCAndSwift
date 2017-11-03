//
//  HdNavigationController.h
//  testhd
//
//  Created by admin on 17/9/27.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    BaseNavLeftItemStyleBack,
    BaseNavLeftItemStyleCancel,
    BaseNavLeftItemStyleClear,
}BaseNavLeftItemStyle;

@protocol BaseNavigationDelegate <NSObject>

@optional
/**导航栏被点击*/
-(void)baseNavigationBarDidClicked;

@end
@interface HdNavigationController : UINavigationController

/**设置标题*/
+(UIView*)setNavigationBarTitle:(NSString*)title;

/**设置导航左标题样式*/
+(UIButton*)setNavigationBarLeftItemStyle:(BaseNavLeftItemStyle)leftStyle target:(id)target action:(SEL)action;

+(UIButton*)setNavigationBarLeftItemWithtarget:(id)target action:(SEL)action;
/**设置导航右标题样式（文字）*/
+(UIButton*)setNavigationBarRightItemWithTitle:(NSString*)title Target:(id)target action:(SEL)action;

/**设置导航右标题样式（图片）*/
+(UIButton*)setNavigationBarRightItemWithImage:(NSString*)imageName Target:(id)target action:(SEL)action;


@property (nonatomic,assign)id target;

@property (nonatomic,strong)UISwipeGestureRecognizer *swipGest;

-(void)setCanSwipBack:(BOOL)canBack;
@end
