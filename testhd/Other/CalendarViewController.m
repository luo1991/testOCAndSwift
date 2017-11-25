//
//  CalendarViewController.m
//  testhd
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "CalendarViewController.h"
#import "HWCalendar.h"
#import "PersonViewController.h"
#import "AlertToastView.h"
@interface CalendarViewController ()<HWCalendarDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)HWCalendar *calendar;
@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation CalendarViewController

- (void)addNavigatorShareBtn {
    //创建一个UIBarButton对象，给他定好名字，类型，动作
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(clickRightBarBtn)];
    
    //创建一个UIBarButton对象，给他定好名字，类型，动作
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索"
//                                                                        style:UIBarButtonItemStylePlain
//                                                                       target:self
//                                                                       action:@selector(clickLeftBtn)];
    //创建一个UIBarButton对象，给他定好名字，类型，动作
    UIBarButtonItem *leftButtonItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"index"] style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBtn)];
    
    //把这个对象赋值navigationItem的rightBarButtonItem
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    //把这个对象赋值navigationItem的rightBarButtonItem
    self.navigationItem.leftBarButtonItems = @[leftButtonItem1];
    //给Button上面的字设置颜色
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
}
-(void)clickRightBarBtn{
     NSLog(@"右边");
//    [ToastView showViewWithTitle:@"这是什么" toast:@"东西啊"];
    
    AlertToastView *alert = [[AlertToastView alloc] initWithTarget:self showTitle:@"测试" content:@"请输入文字" footTitles:@[@"左",@"中",@"右"]];
    [alert show];
    

//    PersonViewController *personVC = [[PersonViewController alloc] init];
//    [self.navigationController pushViewController:personVC animated:NO];
    
}
-(void)clickLeftBtn{
   
    [self setUpSearchBar];
    
    NSLog(@"左边");
}

-(void)setUpSearchBar{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 30, MainWidth, 40)];
    
    
    _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索相关信息";
    _searchBar.showsCancelButton = YES;
    _searchBar.barTintColor = KbackColor ;
    
    [self.navigationController.view addSubview:_searchBar];
    
    for (id searchbuttons in [[_searchBar subviews][0]subviews]) //只需在此处修改即可
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            // 修改文字颜色
            [cancelButton setTitle:@"取消"forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        }
    
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.hidden = YES;
    [searchBar resignFirstResponder];
    self.tabelView.tableHeaderView = self.calendar;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.tabelView.tableHeaderView= [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchBar = searchBar;
    
    
    
}
-(void)leftBtn{
    NSLog(@"dddd");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigatorShareBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //日历
    HWCalendar *calendar = [[HWCalendar alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 360)];
    calendar.delegate = self;
    calendar.backgroundColor = KbackColor;
    calendar.showTimePicker = YES;
    self.calendar = calendar;
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [PublicToastView showViewWithToast:@"功能未开通，敬请期待" superView:self.view];
    
    
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
