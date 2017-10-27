//
//  HdNavigationController.m
//  testhd
//
//  Created by admin on 17/9/27.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "HdNavigationController.h"

@interface HdNavigationController ()

@end

@implementation HdNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"3.jpg"] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
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
