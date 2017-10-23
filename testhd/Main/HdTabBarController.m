//
//  HdTabBarController.m
//  testhd
//
//  Created by admin on 17/9/26.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "HdTabBarController.h"
#import "ViewController.h"
#import "OtherViewController.h"
#import "HdNavigationController.h"
#import "TestViewController.h"
#import "PersonViewController.h"
#import "InfoViewController.h"

@interface HdTabBarController ()

@end

@implementation HdTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
   
    TestViewController  *HomeViewController= [[TestViewController alloc] init];
    [self addChildViewController:HomeViewController andTitle:@"首页" andNormalImage:@"index" andSelectImage:@"index_cur.png"];
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    [self addChildViewController:otherVC andTitle:@"其他" andNormalImage:@"index" andSelectImage:@"news_cur"];
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    [self addChildViewController:infoVC andTitle:@"个人中心" andNormalImage:@"index" andSelectImage:@"news_cur"];
    PersonViewController *personVC = [[PersonViewController alloc] init];
    [self addChildViewController:personVC andTitle:@"我的" andNormalImage:@"index" andSelectImage:nil];
    
    // Do any additional setup after loading the view.
}
-(void)addChildViewController:(UIViewController *)childController andTitle:(NSString *)titleString andNormalImage:(NSString *)normalImage andSelectImage:(NSString *)selectImage{
    HdNavigationController *navController = [[HdNavigationController alloc] initWithRootViewController:childController];
//    navController.navigationItem.title = titleString;
    [navController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:22],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    navController.navigationBar.barTintColor = [UIColor redColor];
    
    [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3.jpg"] forBarMetrics:UIBarMetricsDefault];
    childController.title = titleString;
    childController.tabBarItem.image = [UIImage imageNamed:normalImage];
    
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    [self addChildViewController:navController];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
