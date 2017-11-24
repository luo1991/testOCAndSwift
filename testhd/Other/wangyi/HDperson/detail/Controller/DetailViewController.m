//
//  DetailViewController.m
//  testhd
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "DetailViewController.h"
#import "HttpToolRequest.h"
#import "DetailModel.h"
#import "DetailCell.h"
@interface DetailViewController ()<XRCarouselViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) XRCarouselView *carouselView;

@property(nonatomic,copy)DetailModel *dataModel;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *detailData;
@property(nonatomic,strong)NSArray *titleData;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDetailData];
    [self setUpAdView];
    
   
    
}
-(UIView *)setUpAdView{
    _carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    _carouselView.delegate = self;
    
    //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
    _carouselView.placeholderImage = [UIImage imageNamed:@"placeholderImage.jpg"];
    
    //设置图片数组及图片描述文字
    _carouselView.imageArray = @[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.jpg"],[UIImage imageNamed:@"cat1.jpg"]];
    
//    NSArray *arr = @[
//                     @"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg",//网络图片
//                     [UIImage imageNamed:@"1.jpg"],//本地图片，传image，不能传名称
//                     @"http://photo.l99.com/source/11/1330351552722_cxn26e.gif",//网络gif图片
//                     gifImageNamed(@"2.gif")//本地gif使用gifImageNamed(name)函数创建
//                     ];
    _carouselView.describeArray = @[@"第一张",@"第2张",@"第3张",@"第4张"];
    
    //设置每张图片的停留时间，默认值为5s，最少为1s
    _carouselView.time = 3;
    
    //设置分页控件的图片,不设置则为系统默认
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomCenter;
    _carouselView.changeMode= ChangeModeFade;
    
    // 设置滑动时gif停止播放
    _carouselView.gifPlayMode = GifPlayModePauseWhenScroll;
    
    return _carouselView;
}
-(void)getDetailData{
    
    
    [HttpToolRequest postWithUrl:detailURL params:@{@"id":@"402880125fb31931015fb31bbc1b0000"} success:^(id responseObject) {
        //将字典数组转成模型数组, 最常用
        
        NSLog(@"%@",responseObject);
//        将字典转为模型
        _dataModel = [DetailModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self setUpTalbeView];
        
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    NSLog(@"点击%lu",(long)index);
}
-(void)setUpTalbeView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
       self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.tableHeaderView = [self setUpAdView];
    }
    
    [_tableView registerNib:[UINib nibWithNibName:@"detailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    _titleData= @[@"姓名",@"审批人",@"日期",@"类型",@"申请原因",@"申请状态",@"审批记录"];
     _detailData= @[_dataModel.realname,_dataModel.leader,_dataModel.endDate,_dataModel.listOperator,_dataModel.reason,_dataModel.calendarTypeExplain,_dataModel.checkExplain];
    [_tableView reloadData];
    
    
}
#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleData.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"DetailCell";
    DetailCell *cell =[tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    cell.titleLabel.text = _titleData[indexPath.row];
    cell.nameLabel.text= _detailData[indexPath.row];
   
    return cell;
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
