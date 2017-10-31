//
//  ScienceViewController.m
//  testhd
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "ScienceViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ScienceViewController ()
@property(nonatomic,strong)MPMoviePlayerController *playerVC;
@end

@implementation ScienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

////    [SVProgressHUD show];
//    [SVProgressHUD showWithStatus:@"注册成功"];
//    sleep(2);
//    [SVProgressHUD dismiss];
//     [SVProgressHUD showErrorWithStatus:@"注册成功"];
    
//    sleep(2);
     [SVProgressHUD showErrorWithStatus:@"注册失败"];
//    sleep(3);
//    [SVProgressHUD showImage:[UIImage imageNamed:@"2.jpg"] status:@"欢迎回来"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    
    
    // Do any additional setup after loading the view.
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
