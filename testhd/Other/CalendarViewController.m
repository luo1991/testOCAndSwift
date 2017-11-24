//
//  CalendarViewController.m
//  testhd
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "CalendarViewController.h"
#import "HWCalendar.h"
@interface CalendarViewController ()<HWCalendarDelegate>

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //日历
    HWCalendar *calendar = [[HWCalendar alloc] init];
    calendar.delegate = self;
    calendar.showTimePicker = YES;
    [self.view addSubview:calendar];
    //    WithFrame:CGRectMake(7, [UIScreen mainScreen].bounds.size.height, 400, 396)
    [calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MainWidth, 396));
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}
-(void)calendar:(HWCalendar *)calendar didClickSureButtonWithDate:(NSString *)date{
    NSLog(@"选择日期 %@",date);
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
