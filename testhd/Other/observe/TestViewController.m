//
//  TestViewController.m
//  testhd
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "TestViewController.h"
#import "KVOViewController.h"
#import "OtherViewController.h"
#import "ViewController.h"
#import "ReadViewController.h"
#import "ScienceViewController.h"
#define KscreenWidth [UIScreen mainScreen].bounds.size.width

#define KscreenHeight [UIScreen mainScreen].bounds.size.height
static CGFloat const labelWidth = 100;  // 标题文字宽度
static CGFloat const radio = 1.3;   // 点击或者滑动scrollView 标题Label放大倍数
@interface TestViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,strong)UIScrollView *titleScrollView;
@property(nonatomic,strong)UIScrollView *contextScrollView;
@property(nonatomic,strong)NSMutableArray *titleArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];



      // 1.添加所有子控制器
    [self setUpChildViewController];
    // 2.初始化UIScrollView
    [self setUpScrollView];

    // 3.添加所有子控制器对应标题
     [self setUpTitleLabel];
    // 不想要添加
    self.automaticallyAdjustsScrollViewInsets = NO;


    // 2.添加所有子控制器对应标题

    // Do any additional setup after loading the view.
}
// 初始化UIScrollView
- (void)setUpScrollView{
    self.titleScrollView = [[UIScrollView alloc] init];
    self.titleScrollView.backgroundColor = [UIColor whiteColor];
    self.titleScrollView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [self.view addSubview:self.titleScrollView];
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(self.view.mas_left);
    }];
      self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.contextScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.contextScrollView];

    [self.contextScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.top.mas_equalTo(self.titleScrollView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    NSInteger count = self.childViewControllers.count;
    self.titleScrollView.contentSize = CGSizeMake(count*labelWidth, 0);
    self.contextScrollView.contentSize = CGSizeMake(count*MainWidth ,0);
    self.contextScrollView.pagingEnabled = YES;
    self.contextScrollView.bounces = NO;// 弹簧效果
    self.contextScrollView.showsHorizontalScrollIndicator = NO;
    self.contextScrollView.delegate = self;

}
-(void)setUpTitleLabel{
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = 44;
    for (int i = 0 ;i<count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        UILabel *label = [[UILabel alloc] init];
        labelX= i *labelWidth;
        label.frame = CGRectMake(labelX, labelY, labelWidth, labelH);
        label.text = vc.title;
        label.highlightedTextColor = [UIColor redColor];
        label.tag = i;
        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self.titleArray addObject:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
        if (i == 0) {
            [self tapClick:tap];
        }
        [self.titleScrollView addSubview:label];


    }
}

-(void)setUpTitleCenter:(UILabel *)centerLabel{

    CGFloat offsetX = centerLabel.center.x - MainWidth * 0.5;

    if (offsetX <0) {
      offsetX =0;
    }

    CGFloat maxOffsetX = self.titleScrollView.contentSize.width-MainWidth;

    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
   // 滚动标题滚动条
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];

}

#pragma mark - UIScrollViewDelegate  一滚动就会调用

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currenPage = scrollView.contentOffset.x/scrollView.bounds.size.width;

    NSInteger leftIndex = currenPage;
    NSInteger rigtIndex = leftIndex+1;
    UILabel *leftLabel = self.titleArray[leftIndex];

    UILabel *rightLabel;
    if (rigtIndex <self.titleArray.count-1) {
        rightLabel = self.titleArray[rigtIndex];
    }
    CGFloat rightScale = currenPage-leftIndex;
    NSLog(@"rightScale--%f",rightScale);

    CGFloat leftScale = 1-rightScale ;
    NSLog(@"leftScale--%f",leftScale);

    // 左边缩放
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3+ 1);

    // 右边缩放
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3+ 1);
    
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
        rightLabel.textColor = [UIColor colorWithRed:rightScale green:1 blue:1 alpha:1];
        NSLog(@"night");
    }else{
        leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
        rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
         NSLog(@"moon");
    }
    
   
    


//    NSLog(@"%f",currenPage);
}

#pragma mark - 结束滚动 需要做的事情

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self showVc:index];
    UILabel *selLabel = self.titleArray[index];
    [self selectLabel:selLabel];
    [self setUpTitleCenter:selLabel];

}
-(void)showVc:(NSInteger)index{
    CGFloat offsetX = index*MainWidth;
    UIViewController *vc = self.childViewControllers[index];
    if (vc.isViewLoaded) {
        return;
    }

    [self.contextScrollView addSubview:vc.view];

    vc.view.frame = CGRectMake(offsetX, 0, MainWidth, MainHeight);

}
-(void)selectLabel:(UILabel *)label{
    _titleLabel.highlighted = NO;
    _titleLabel.transform = CGAffineTransformIdentity;
    _titleLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    label.highlighted = YES;
    label.transform = CGAffineTransformMakeScale(radio, radio);
    _titleLabel = label;
}


//
//static CGFloat const labelW = 100;  // 标题文字宽度
//
//static CGFloat const radio = 1.3;   // 点击或者滑动scrollView 标题Label放大倍数
//
//#define KscreenWidth [UIScreen mainScreen].bounds.size.width
//
//#define KscreenHeight [UIScreen mainScreen].bounds.size.height
//
//@interface TestViewController ()<UIScrollViewDelegate>
//
//@property (nonatomic, weak) UILabel *titleLabel;
//
//@property (strong, nonatomic)  UIScrollView *titleScrollView;
//
//@property (strong, nonatomic)  UIScrollView *contextScrollView;
//
//@property (nonatomic, strong) NSMutableArray *titleArray;
//
//@end
//
//@implementation TestViewController
//
///*
// 网易新闻实现步骤:
// 1.搭建结构(导航控制器)
// * 自定义导航控制器根控制器NewsViewController
// * 搭建NewsViewController界面(上下滚动条)
// * 确定NewsViewController有多少个子控制器,添加子控制器
// 2.设置上面滚动条标题
// * 遍历所有子控制器
// 3.监听滚动条标题点击
// * 3.1 让标题选中,文字变为红色
// * 3.2 滚动到对应的位置
// * 3.3 在对应的位置添加子控制器view
// 4.监听滚动完成时候
// * 4.1 在对应的位置添加子控制器view
// * 4.2 选中子控制器对应的标题
// */
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor =[UIColor whiteColor];
//
//
//    // 1.添加所有子控制器
//    [self setUpChildViewController];
//
//    // 3.初始化UIScrollView
//    [self setUpScrollView];
//
//
//
//    // 2.添加所有子控制器对应标题
//    [self setUpTitleLabel];
//
//    // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
//    // 不想要添加
//    self.automaticallyAdjustsScrollViewInsets = NO;
//
//
//}
//
//
//// 初始化UIScrollView
//- (void)setUpScrollView
//{
//
//    self.titleScrollView = [[UIScrollView alloc] init];
//    self.titleScrollView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.titleScrollView];
//    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view.mas_width);
//        make.top.mas_equalTo(64);
//        make.height.mas_equalTo(44);
//        make.left.mas_equalTo(self.view.mas_left);
//    }];
//    self.titleScrollView.showsHorizontalScrollIndicator = NO;
//    self.contextScrollView = [[UIScrollView alloc] init];
//    [self.view addSubview:self.contextScrollView];
//
//    [self.contextScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view.mas_width);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//        make.top.mas_equalTo(self.titleScrollView.mas_bottom);
//        make.left.mas_equalTo(self.view.mas_left);
//    }];
//    NSInteger count = self.childViewControllers.count;
//    self.titleScrollView.contentSize = CGSizeMake(count*labelW, 0);
//    self.contextScrollView.contentSize = CGSizeMake(count*MainWidth ,0);
//    self.contextScrollView.pagingEnabled = YES;
//    self.contextScrollView.bounces = NO;// 弹簧效果
//    self.contextScrollView.showsHorizontalScrollIndicator = NO;
//    self.contextScrollView.delegate = self;
//
////     NSUInteger count = self.childViewControllers.count;
////    self.titleScrollView = [[UIScrollView alloc] init];
////    self.titleScrollView.backgroundColor = [UIColor whiteColor];
////    [self.view addSubview:self.titleScrollView];
////    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.equalTo(self.view.mas_width);
////        make.top.mas_equalTo(64);
////        make.height.mas_equalTo(44);
////        make.left.mas_equalTo(self.view.mas_left);
////    }];
////    self.titleScrollView.showsHorizontalScrollIndicator = NO;
////    self.contextScrollView = [[UIScrollView alloc] init];
////    [self.view addSubview:self.contextScrollView];
////
////    [self.contextScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.equalTo(self.view.mas_width);
////        make.bottom.mas_equalTo(self.view.mas_bottom);
////        make.top.mas_equalTo(self.titleScrollView.mas_bottom);
////        make.left.mas_equalTo(self.view.mas_left);
////    }];
////
////
////    // 设置标题滚动条
////    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
////    self.titleScrollView.showsHorizontalScrollIndicator = NO;
////
////    // 设置内容滚动条
////    self.contextScrollView.contentSize = CGSizeMake(count * KscreenWidth, 0);
////    // 开启分页
////    self.contextScrollView.pagingEnabled = YES;
////    // 没有弹簧效果
////    self.contextScrollView.bounces = NO;
////    // 隐藏水平滚动条
////    self.contextScrollView.showsHorizontalScrollIndicator = NO;
////    // 设置代理
////    self.contextScrollView.delegate = self;
//}
//
//
//// 添加所有子控制器对应标题
//- (void)setUpTitleLabel
//{
////    NSUInteger count = self.childViewControllers.count;
////
////    CGFloat labelX = 0;
////    CGFloat labelY = 0;
////    CGFloat labelH = 44;
////
////    for (int i = 0; i < count; i++) {
////        // 获取对应子控制器
////        UIViewController *vc = self.childViewControllers[i];
////
////        // 创建label
////        UILabel *label = [[UILabel alloc] init];
////
////        labelX = i * labelW;
////
////        // 设置尺寸
////        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
////
////        // 设置label文字
////        label.text = vc.title;
////
////        // 设置高亮文字颜色
////        label.highlightedTextColor = [UIColor redColor];
////
////        // 设置label的tag
////        label.tag = i;
////
////        // 设置用户的交互
////        label.userInteractionEnabled = YES;
////
////        // 文字居中
////        label.textAlignment = NSTextAlignmentCenter;
////
////
////        // 添加到titleArray数组
////        [self.titleArray addObject:label];
////
////        // 添加点按手势
////        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
////        [label addGestureRecognizer:tap];
////
////        // 默认选中第0个label
////        if (i == 0) {
////            [self titleClick:tap];
////        }
////
////        // 添加label到标题滚动条上
////        [self.titleScrollView addSubview:label];
////    }
//
//    NSUInteger count = self.childViewControllers.count;
//    CGFloat labelX = 0;
//    CGFloat labelY = 0;
//    CGFloat labelH = 44;
//    for (int i = 0 ;i<count; i++) {
//        UIViewController *vc = self.childViewControllers[i];
//        UILabel *label = [[UILabel alloc] init];
//        labelX= i *labelW;
//        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
//        label.text = vc.title;
//        label.highlightedTextColor = [UIColor redColor];
//        label.tag = i;
//        label.userInteractionEnabled = YES;
//        label.textAlignment = NSTextAlignmentCenter;
//        [self.titleArray addObject:label];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
//        [label addGestureRecognizer:tap];
//        if (i == 0) {
//            [self titleClick:tap];
//        }
//        [self.titleScrollView addSubview:label];
//
//
//    }
//
//}
//
//// 设置标题居中
//- (void)setUpTitleCenter:(UILabel *)centerLabel
//{
////    // 计算偏移量
////    CGFloat offsetX = centerLabel.center.x - KscreenWidth * 0.5;
////
////    if (offsetX < 0) offsetX = 0;
////
////    // 获取最大滚动范围
////    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - KscreenWidth;
////
////    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
////
////
////    // 滚动标题滚动条
////    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
//
//    CGFloat offsetX = centerLabel.center.x - MainWidth * 0.5;
//
//    if (offsetX <0) {
//        offsetX =0;
//    }
//
//    CGFloat maxOffsetX = self.titleScrollView.contentSize.width-MainWidth;
//
//    if (offsetX > maxOffsetX) {
//        offsetX = maxOffsetX;
//    }
//    // 滚动标题滚动条
//    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
//
//}
//
//#pragma mark - UIScrollViewDelegate
//#pragma mark - UIScrollViewDelegate  一滚动就会调用
//
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat currenPage = scrollView.contentOffset.x/scrollView.bounds.size.width;
//
//    NSInteger leftIndex = currenPage;
//    NSInteger rigtIndex = leftIndex+1;
//    UILabel *leftLabel = self.titleArray[leftIndex];
//
//    UILabel *rightLabel;
//    if (rigtIndex <self.titleArray.count-1) {
//        rightLabel = self.titleArray[rigtIndex];
//    }
//    CGFloat rightScale = currenPage-leftIndex;
//    NSLog(@"rightScale--%f",rightScale);
//
//    CGFloat leftScale = 1-rightScale ;
//    NSLog(@"leftScale--%f",leftScale);
//
//    // 左边缩放
//    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3+ 1);
//
//    // 右边缩放
//    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3+ 1);
//
//    leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
//    rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
//
//
//    NSLog(@"%f",currenPage);
//}
//
//
//#pragma mark - 结束滚动 需要做的事情
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    // 计算滚动到哪一页
//    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    [self showVc:index];
//    UILabel *selLabel = self.titleArray[index];
//    [self selectLabel:selLabel];
//    [self setUpTitleCenter:selLabel];
//
//}
//
//// 显示控制器的view
//- (void)showVc:(NSInteger)index
//{
//    CGFloat offsetX = index*MainWidth;
//    UIViewController *vc = self.childViewControllers[index];
//    if (vc.isViewLoaded) {
//        return;
//    }
//
//    [self.contextScrollView addSubview:vc.view];
//
//    vc.view.frame = CGRectMake(offsetX, 0, MainWidth, MainHeight);
//}
//
//// 点击标题的时候就会调用
//- (void)titleClick:(UITapGestureRecognizer *)tap
//{
//
//
//    // 0.获取选中的label
////    UILabel *selLabel = (UILabel *)tap.view;
//
////    // 1.标题颜色变成红色,设置高亮状态下的颜色
////    [self selectLabel:selLabel];
////
////    // 2.滚动到对应的位置
////    NSInteger index = selLabel.tag;
////    // 2.1 计算滚动的位置
////    CGFloat offsetX = index * KscreenWidth;
////    self.contextScrollView.contentOffset = CGPointMake(offsetX, 0);
////
////    // 3.给对应位置添加对应子控制器
////    [self showVc:index];
////
////    // 4.让选中的标题居中
////    [self setUpTitleCenter:selLabel];
//
//
//        UILabel *selLabel =(UILabel *)tap.view;
//        [self selectLabel:selLabel];
//        NSInteger index = selLabel.tag;
//        CGFloat offsetX = index*MainWidth;
//        self.contextScrollView.contentOffset= CGPointMake(offsetX, 0);
//        [self showVc:index];
//        [self setUpTitleCenter:selLabel];
//
//
//}
//
//// 选中label
//
////- (void)selectLabel:(UILabel *)label
////{
//////    // 取消之前Label高亮
//////    _titleLabel.highlighted = NO;
//////    // 取消之前Label形变
//////    _titleLabel.transform = CGAffineTransformIdentity;
//////    // 恢复之前Label颜色
//////    _titleLabel.textColor = [UIColor blackColor];
//////
//////    // 高亮当前label
//////    label.highlighted = YES;
//////    // 形变当前label
//////    label.transform = CGAffineTransformMakeScale(radio, radio);
//////
//////    // 记录当前label
//////    _titleLabel = label;
////
////        _titleLabel.highlighted = NO;
////        _titleLabel.transform = CGAffineTransformIdentity;
////        _titleLabel.textColor = [UIColor blackColor];
////        label.highlighted = YES;
////        label.transform = CGAffineTransformMakeScale(radio, radio);
////        _titleLabel = label;
////
////}
//-(void)selectLabel:(UILabel *)label{
//    _titleLabel.highlighted = NO;
//    _titleLabel.transform = CGAffineTransformIdentity;
//    _titleLabel.textColor = [UIColor blackColor];
//    label.highlighted = YES;
//    label.transform = CGAffineTransformMakeScale(radio, radio);
//    _titleLabel = label;
//}
// 添加所有子控制器
-(void)setUpChildViewController{
    ViewController *hotVC = [[ViewController alloc] init];
    hotVC.title = @"推荐";
    [self addChildViewController:hotVC];
    OtherViewController *otherVC = [[OtherViewController alloc] init];
    otherVC.title = @"头条";
    [self addChildViewController:otherVC];
    KVOViewController *kvoVC = [[KVOViewController alloc] init];
    kvoVC.title = @"热点";
    [self addChildViewController:kvoVC];

    ReadViewController *readerVC = [[ReadViewController alloc] init];
    readerVC.title = @"阅读";
    [self addChildViewController:readerVC];

    ScienceViewController *scienceVC = [[ScienceViewController alloc] init];
    scienceVC.title= @"科技";
    [self addChildViewController:scienceVC];


}
-(void)tapClick:(UITapGestureRecognizer *)tap{
    UILabel *selLabel =(UILabel *)tap.view;
    [self selectLabel:selLabel];
    NSInteger index = selLabel.tag;
    CGFloat offsetX = index*MainWidth;
    self.contextScrollView.contentOffset= CGPointMake(offsetX, 0);
    [self showVc:index];
    [self setUpTitleCenter:selLabel];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 懒加载
- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
//- (NSMutableArray *)titleArray
//{
//    if (_titleArray == nil) {
//        _titleArray = [NSMutableArray array];
//    }
//    return _titleArray;
//}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
