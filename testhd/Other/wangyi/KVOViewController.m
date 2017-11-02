//
//  KVOViewController.m
//  testhd
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "KVOViewController.h"
#import "TestViewController.h"
@interface KVOViewController ()

@property(nonatomic,strong)KVOViewController *kvoVC;
@property(nonatomic,strong)UILabel *contextLabel;
@property(nonatomic,assign)int number;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.view.backgroundColor = [UIColor grayColor];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"文字点击     YYText"];
    text.yy_font = [UIFont boldSystemFontOfSize:18.0f];
    text.yy_color = [UIColor blueColor];
    [text yy_setColor:[UIColor redColor] range:NSMakeRange(0, 4)];
    
    
    
    [text yy_setTextHighlightRange:NSMakeRange(0, 4)//设置点击的位置
                             color:[UIColor orangeColor]
                   backgroundColor:[UIColor whiteColor]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             NSLog(@"这里是点击事件");
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"文字点击效果" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [alert show];
                             
                         }];
    
    YYLabel *heightRangeLabel = [YYLabel new];
//    heightRangeLabel.frame = CGRectMake(100, 250, 160, 25);
    heightRangeLabel.attributedText = text;
    heightRangeLabel.userInteractionEnabled = YES;
    heightRangeLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:heightRangeLabel];

    [heightRangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(MainWidth,40));
        make.top.mas_equalTo(40);
    }];
 
    NSMutableAttributedString *textSubstring = [[NSMutableAttributedString alloc] initWithString:@"对这个世界如果你有太多的抱怨"];
    textSubstring.yy_font = [UIFont boldSystemFontOfSize:20];//字体
    textSubstring.yy_lineSpacing = 20;//行间距
    
    NSRange range0 = [[textSubstring string] rangeOfString:@"这个世界" options:NSCaseInsensitiveSearch];
    //字体
    [textSubstring yy_setFont:[UIFont systemFontOfSize:25] range:range0];
    //文字颜色
    [textSubstring yy_setColor:[UIColor purpleColor] range:range0];
    //文字间距
    [textSubstring yy_setKern:@(2) range:range0];
    
    YYLabel *subLabel = [[YYLabel alloc] init];
    [self.view addSubview:subLabel];
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(MainWidth, 40));
        make.top.mas_equalTo(heightRangeLabel.mas_bottom);
    }];
    
     subLabel.attributedText = textSubstring;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [self removeObserver:self forKeyPath:@"kvovc" context:nil];
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
