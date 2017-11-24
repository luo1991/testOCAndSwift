//
//  LoginViewController.m
//  testhd
//
//  Created by admin on 2017/11/3.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *normalLogin;

@property (weak, nonatomic) IBOutlet UIButton *qqLogin;

@property (weak, nonatomic) IBOutlet UIButton *weixinLogin;


@property (weak, nonatomic) IBOutlet UIButton *weiboLogin;
@end

@implementation LoginViewController

//-(id)init{
//    
//    self=[[[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:self options:nil] lastObject];
//    if (self) {
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
