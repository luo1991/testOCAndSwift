//
//  ScienceViewController.m
//  testhd
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "ScienceViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ScienceViewController ()<UITextViewDelegate>
@property(nonatomic,strong)MPMoviePlayerController *playerVC;
@property(nonatomic,strong)UITextView *textView;

@end

@implementation ScienceViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [IQKeyboardManager sharedManager].enable = YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

////    [SVProgressHUD show];
//    [SVProgressHUD showWithStatus:@"注册成功"];
//    sleep(2);
//    [SVProgressHUD dismiss];
//     [SVProgressHUD showErrorWithStatus:@"注册成功"];
    
//    sleep(2);
//     [SVProgressHUD showErrorWithStatus:@"注册失败"];
//    sleep(3);
//    [SVProgressHUD showImage:[UIImage imageNamed:@"2.jpg"] status:@"欢迎回来"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
    
    _textView= [[UITextView alloc] init];
    [self.view addSubview:_textView];
    _textView.delegate = self;
    _textView.backgroundColor= [UIColor yellowColor];
    _textView.text= @"请输入备注";
    _textView.textColor = [UIColor grayColor];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MainWidth, 100));
        make.top.mas_equalTo(200);
        make.left.equalTo(@(0));
    }];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入备注";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入备注"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
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
