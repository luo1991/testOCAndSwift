//
//  HdNavigationController.m
//  testhd
//
//  Created by admin on 17/9/27.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "HdNavigationController.h"


#define NAV_COLOR_TITLE     XRGB(33, 33, 33)

@interface HdNavigationController ()

@end

@implementation HdNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor=Public_Color_nav;
    self.navigationBar.translucent=NO;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    tap.numberOfTapsRequired=2;
    [self.navigationBar addGestureRecognizer:tap];
    
//    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, MainWidth, 3)];
//    line.image=[ApplicationUtils resizeableImage:[UIImage imageNamed:@"nav_shadow"] withEdge:UIEdgeInsetsMake(0, 2, 0, 2)];
//    [self.view addSubview:line];
    
    
    
    _swipGest=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip)];
    _swipGest.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_swipGest];
}

-(void)swip{
    
    if (self.viewControllers.count!=1) {
        [self popViewControllerAnimated:YES];
    }
}

-(void)click{
    
    if (self.target&&[self.target respondsToSelector:@selector(baseNavigationBarDidClicked)]) {
        [self.target baseNavigationBarDidClicked];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#define navigationWidth   150
+(UIView*)setNavigationBarTitle:(NSString *)title{
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((MainWidth-navigationWidth)/2.0f, 7, navigationWidth, 30)];
    label.text=title;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:20];
    label.textColor=NAV_COLOR_TITLE;
    return label;
}
+(UIButton*)setNavigationBarLeftItemStyle:(BaseNavLeftItemStyle)leftStyle target:(id)target action:(SEL)action{
    
    UIViewController *viewController = target;
    if (!viewController) {
        return nil;
    }
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 60, 44)];
    leftButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    if (leftStyle==BaseNavLeftItemStyleBack) {
        UIImage *iconBack = [UIImage imageNamed:@"back"];
        [leftButton setImage:iconBack forState:UIControlStateNormal];
        [leftButton setImage:iconBack forState:UIControlStateHighlighted];
    }
    if (leftStyle==BaseNavLeftItemStyleCancel) {
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftButton setTitleColor:NAV_COLOR_TITLE forState:UIControlStateNormal];
        [leftButton setTitleColor:NAV_COLOR_TITLE forState:UIControlStateHighlighted];
        leftButton.titleLabel.font=[UIFont systemFontOfSize:17];
    }
    if (leftStyle==BaseNavLeftItemStyleClear) {
        
    }
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    viewController.navigationItem.leftBarButtonItem=leftBarItem;
    return leftButton;
}
+(UIButton*)setNavigationBarLeftItemWithtarget:(id)target action:(SEL)action{
    
    return [self setNavigationBarLeftItemStyle:BaseNavLeftItemStyleBack target:target action:action];
}
+(UIButton*)setNavigationBarRightItemWithTitle:(NSString *)title Target:(id)target action:(SEL)action{
    
    UIViewController *controller=target;
    if (!controller) {
        return nil;
    }
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:XRGB(66, 66, 66) forState:UIControlStateNormal];
    [button setTitleColor:XRGB(99, 99, 99) forState:UIControlStateDisabled];
    
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    controller.navigationItem.rightBarButtonItem=rightItem;
    
    return button;
}
+(UIButton*)setNavigationBarRightItemWithImage:(NSString*)imageName Target:(id)target action:(SEL)action{
    
    UIViewController *controller=target;
    if (!controller) {
        return nil;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 60, 44)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    controller.navigationItem.rightBarButtonItem=rightItem;
    return button;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
}

-(void)setCanSwipBack:(BOOL)canBack{
    
    if (canBack) {
        [self.view addGestureRecognizer:self.swipGest];
    }else{
        [self.view removeGestureRecognizer:self.swipGest];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
