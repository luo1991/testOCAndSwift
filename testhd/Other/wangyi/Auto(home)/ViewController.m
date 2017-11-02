//
//  ViewController.m
//  testhd
//
//  Created by admin on 17/9/18.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "ViewController.h"
#import "HdTableViewCell.h"
#import "testhd-Bridging-Header.h"

static const CGFloat MJDuration = 2.0;


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property (strong,nonatomic)NSArray * imageArray;
@property (strong,nonatomic)NSArray * headImageArray;

@property (strong,nonatomic)NSArray * detailArray;
//去缓存cell的高度
@property(nonatomic,strong)NSMutableDictionary *heightAtIndexPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"热门";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49-44-64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
     self.tableView.estimatedRowHeight = 80.0f;
    self.headImageArray = @[@"data",@"location",@"write"];
    self.imageArray = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    
    self.detailArray = @[@"shot",@"Aduahguhauhguhaudghuahguhudhauhg",@"dhuahgudhaughuahdughuahguhauhguhdahudhuahughduahguhadguhaduhguadhughduahguahguhadugh"];
    

    [self.tableView registerNib:[UINib nibWithNibName:@"HdTableViewCell" bundle:nil] forCellReuseIdentifier:@"hdcell"];
    
 //方式1
     __weak __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];

//
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
   
//
    return;
//    自定义文字
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    // 马上进入刷新状态
//    [header beginRefreshing];
    
    // 设置刷新控件
    self.tableView.mj_header = header;
    
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        // 马上进入刷新状态
    
//        [self.tableView.mj_header beginRefreshing];
    
    
}
#pragma mark 下拉加载
-(void)loadNewData{
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}
#pragma mark 上拉加载
-(void)loadMoreData{
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}
// 重复字符串N次
- (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *String = [NSMutableString new];
    
    for (int i = 0; i < repeat; i++) {
        [String appendString:text];
    }
    
    return String;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.headImageArray.count;
//    return 20;
    
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    
//    NSLog(@"self.heightAtIndexPath %@",height);
    if(height)
    {
        return height.floatValue;
    }
    else
    {
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *ident = @"hdcell";
    HdTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath]; ;
   
    if (!cell) {
        cell = [[HdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
//   停止滑动的时候异步加载图片
    if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
    {
     
    }
    cell.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    cell.contextLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    cell.contextLabel.text = [self  getText:@"内容" withRepeat:((int)indexPath.row+2) * 10 + 1];;
    //开始异步加载图片
     cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    cell.headImage.image = [UIImage imageNamed:self.headImageArray[indexPath.row%3]];
    cell.detailImage.image = [UIImage imageNamed:self.imageArray[indexPath.row%3]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
