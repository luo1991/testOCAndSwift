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
#import "HotViewController.h"
#import "TabbarItem.h"
#import "CalendarViewController.h"
@interface HdTabBarController ()
@property(nonatomic,strong)UIButton *selectBtn;
@end

@implementation HdTabBarController


-(void)setUptabbarItem{
    
     _showIndex=0;
    
    TestViewController  *HomeViewController= [[TestViewController alloc] init];
    HdNavigationController *homeNav = [[HdNavigationController alloc] initWithRootViewController:HomeViewController];
    
    HotViewController *hotVC = [[HotViewController alloc] init];
    HdNavigationController *hotNav = [[HdNavigationController alloc] initWithRootViewController:hotVC];
    
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    HdNavigationController *otherNav = [[HdNavigationController alloc] initWithRootViewController:otherVC];
    
    PersonViewController *personVC = [[PersonViewController alloc] init];
    HdNavigationController *personNav = [[HdNavigationController alloc] initWithRootViewController:personVC];
    
    self.viewControllers = @[homeNav,hotNav,otherNav,personNav];
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, MainHeight-49, MainWidth, 49)];
//   [ self.tabBar insertSubview:backView atIndex:0 ];
    [self.view addSubview:backView];
    
     backView.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.opaque = YES;
    
    NSArray *titles=@[@"",@"",@"",@""];
    NSArray *images_nor=@[@"square_unselected",@"timeStore_unselected",@"order_unselected",@"me_unselected"];
    NSArray *images_sel=@[@"square_selected",@"timeStore_selected",@"order_selected",@"me_selected"];
    
    CGFloat width=MainWidth/titles.count;
    
    for (NSInteger i=0; i<titles.count; i++) {
        CGRect frame=CGRectMake(width*i, 0, width, 49);
        
        TabbarItem *item=[[TabbarItem alloc]initWithFrame:frame normalIamge:[images_nor objectAtIndex:i] selectImage:[images_sel objectAtIndex:i] itemTitle:titles[i]];
        item.tag=i;
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [item addTarget:self action:@selector(itemTouchDouble:) forControlEvents:UIControlEventTouchDownRepeat];
        if (i==0) {
            item.selected=YES;
            self.selectBtn = item;
        }
        [backView addSubview:item];
        item.userInteractionEnabled = YES;
    }
    
    
}

-(void)itemClicked:(UIButton*)button{
    
    //1.先将之前选中的按钮设置为未选中
    self.selectBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectBtn = button;
    NSInteger index=button.tag;
    
//    if (_showIndex==index) {
//        return;
//    }
    self.selectedIndex=index;
    _showIndex=index;
    
//    for (NSInteger i=0; i<4; i++) {
//        UIButton *btn=[self.tabBar viewWithTag:10000+i];
//        if (i==index) {
////            btn.selected=YES;
////        }else{
////            btn.selected=NO;
////        }
////    }
////
//    NSLog(@"index");
}

-(void)itemTouchDouble:(UIButton*)button{
    
    NSInteger index=button.tag-10000;
    if (_showIndex==index) {
        if (_target&&[_target respondsToSelector:@selector(baseTabItemDidToucedtouble)]) {
            [_target baseTabItemDidToucedtouble];
        }
    }
}

-(void)refreshView{
    
    TabbarItem *item=[self.tabBar viewWithTag:10002];
//    if ([ChatDataManger getAllUnReadMessageNumber]>0) {
//        item.redicon.hidden=NO;
//    }else{
//        item.redicon.hidden=YES;
//    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
//     self.tabBar.hidden = YES;
   

//    [self setUptabbarItem ];


//    return;
    
    
        [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    CalendarViewController  *calendarVC= [[CalendarViewController alloc] init];
    [self addChildViewController:calendarVC andTitle:@"日历" andNormalImage:@"index" andSelectImage:@"index_cur"];
    TestViewController  *HomeViewController= [[TestViewController alloc] init];
    [self addChildViewController:HomeViewController andTitle:@"首页" andNormalImage:@"index" andSelectImage:@"index_cur"];
    HotViewController *hotVC = [[HotViewController alloc] init];
    [self addChildViewController:hotVC andTitle:@"消息" andNormalImage:@"index" andSelectImage:@"news_cur"];
    
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    [self addChildViewController:otherVC andTitle:@"咨询" andNormalImage:@"index" andSelectImage:@""];
   
    PersonViewController *personVC = [[PersonViewController alloc] init];
    [self addChildViewController:personVC andTitle:@"我的" andNormalImage:@"index" andSelectImage:@""];
    
    // Do any additional setup after loading the view.
}
-(void)addChildViewController:(UIViewController *)childController andTitle:(NSString *)titleString andNormalImage:(NSString *)normalImage andSelectImage:(NSString *)selectImage{
    HdNavigationController *navController = [[HdNavigationController alloc] initWithRootViewController:childController];
//    navController.navigationItem.title = titleString;
    [navController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:22],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navController.navigationBar.barTintColor = [UIColor redColor];
    
    [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"3.jpg"] forBarMetrics:UIBarMetricsDefault];
    childController.title = titleString;
    childController.tabBarItem.image = [UIImage imageNamed:normalImage];
    
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    self.tabBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);

     self.tabBar.tintColor = [UIColor redColor];
    
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
