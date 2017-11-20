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
@interface DetailViewController ()<XRCarouselViewDelegate>
@property (nonatomic, strong) XRCarouselView *carouselView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self getDetailData];
    [self setUpAdView];
    
   
    
}
-(void)setUpAdView{
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
    
    // 设置滑动时gif停止播放
    _carouselView.gifPlayMode = GifPlayModePauseWhenScroll;
    
    [self.view addSubview:_carouselView];
}
-(void)getDetailData{
    
    
    [HttpToolRequest postWithUrl:nil params:nil success:^(id responseObject) {
        //将字典数组转成模型数组, 最常用
        NSArray *data = [DetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
    } fail:^(NSError *error) {
        
    }];
    
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
