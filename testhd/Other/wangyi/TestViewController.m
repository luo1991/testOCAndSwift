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
#import "InfoViewController.h"
#import "HotViewController.h"
#define KscreenWidth [UIScreen mainScreen].bounds.size.width

#define KscreenHeight [UIScreen mainScreen].bounds.size.height
static CGFloat const labelWidth = 100;  // 标题文字宽度
static CGFloat const radio = 1.3;   // 点击或者滑动scrollView 标题Label放大倍数
@interface TestViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,strong)UIScrollView *titleScrollView;
@property(nonatomic,strong)UIScrollView *contextScrollView;
@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if(!_HUD){
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        _HUD.removeFromSuperViewOnHide = NO;
        _HUD.mode = MBProgressHUDModeIndeterminate;
        [self.view addSubview:_HUD];
    }
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
        make.left.equalTo(self.view.mas_left);
    }];

    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.contextScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.contextScrollView];
    
    [self.contextScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
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
//    NSLog(@"rightScale--%f",rightScale);
    
    CGFloat leftScale = 1-rightScale ;
//    NSLog(@"leftScale--%f",leftScale);
    
    // 左边缩放
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3+ 1);
    
    // 右边缩放
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3+ 1);
    
    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
        rightLabel.textColor = [UIColor colorWithRed:rightScale green:1 blue:1 alpha:1];
//        NSLog(@"night");
    }else{
        leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
        rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
//        NSLog(@"moon");
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
    //
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


// 添加所有子控制器
-(void)setUpChildViewController{
   
    ViewController *hotVC = [[ViewController alloc] init];
    hotVC.title = @"推荐";
    [self addChildViewController:hotVC];
    KVOViewController *kvoVC = [[KVOViewController alloc] init];
    kvoVC.title = @"热点";
    [self addChildViewController:kvoVC];
    HotViewController *readerVC = [[HotViewController alloc] init];
   
//    ReadViewController *readerVC = [[ReadViewController alloc] init];
    readerVC.title = @"阅读";
    [self addChildViewController:readerVC];
    InfoViewController *otherVC = [[InfoViewController alloc] init];
    otherVC.title = @"定制";
    [self addChildViewController:otherVC];
   
    
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





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
