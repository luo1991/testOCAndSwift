//
//  CalendarViewController.m
//  testhd
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "CalendarViewController.h"
#import "HWCalendar.h"
@interface CalendarViewController ()<HWCalendarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)HWCalendar *calendar;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //日历
    HWCalendar *calendar = [[HWCalendar alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 360)];
    calendar.delegate = self;
    calendar.backgroundColor = KbackColor;
    calendar.showTimePicker = YES;

    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tabelView];
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    
    self.tabelView.tableHeaderView= calendar;
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  arc4random() % 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"calendar";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text =[NSString stringWithFormat:@"%d数据", arc4random() % 10];
    
    return cell;
}
-(void)calendar:(HWCalendar *)calendar didClickSureButtonWithDate:(NSString *)date{
    NSLog(@"选择日期 %@",date);
    
    [self.tabelView reloadData];
    
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
