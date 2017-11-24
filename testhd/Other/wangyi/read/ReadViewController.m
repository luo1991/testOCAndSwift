//
//  ReadViewController.m
//  testhd
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//



static CGFloat const labelWidth = 80;  // 标题文字宽度
static CGFloat const radio = 1.3;   // 点击或者滑动scrollView 标题Label放大倍数

#import "ReadViewController.h"



#import "HWCalendar.h"

@interface ReadViewController ()<HWCalendarDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *titleScrollView;

@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *yearLabel;// 显示年份的控件

@property(nonatomic,assign)NSInteger month;


@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSInteger month = [NSDate month:[NSDate date]];
    self.month = month;
//    NSInteger year = [NSDate year:[NSDate date]];
    NSMutableArray *getData = [NSMutableArray array];
    for (int i= (int)month; i > 0; i--) {
        NSString *getMonth = [NSString stringWithFormat:@"%d月",i];
        [getData insertObject:getMonth atIndex:0];
        if (i==1) {
            for (int j= 12; j > 0; j--){
                NSString *getMonth = [NSString stringWithFormat:@" %d月 ",j];
                [getData insertObject:getMonth atIndex:0];
            }
        }
    }
    
    
//    NSLog(@"huoqushuju %@",getData);
    self.titleScrollView = [[UIScrollView alloc] init];
    self.titleScrollView.backgroundColor = [UIColor whiteColor];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
//    [self.view addSubview:self.titleScrollView];
//    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view.mas_width);
//        make.top.mas_equalTo(0);
//        make.height.mas_equalTo(44);
//        make.left.equalTo(@0);
//    }];
    self.titleScrollView.contentSize = CGSizeMake(getData.count*labelWidth+40, 0);
    self.titleScrollView.delegate = self;
    [self setUpTitleLabelWithCount:getData];
    
    //日历
    HWCalendar *calendar = [[HWCalendar alloc] init];
    calendar.delegate = self;
    calendar.showTimePicker = YES;
    [self.view addSubview:calendar];
//    WithFrame:CGRectMake(7, [UIScreen mainScreen].bounds.size.height, 400, 396)
    [calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(400, 396));
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view);
    }];
    
//    self.calendar = calendar;

    
   
    
    
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


-(void)setUpTitleLabelWithCount:(NSMutableArray *)getData{
//    NSUInteger count = self.childViewControllers.count;
    int count = (int) getData.count;
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = 44;
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth/2, labelH)];
//    [self.view addSubview:_yearLabel];
    NSString *year = [NSString stringWithFormat:@"%ld",[NSDate year:[NSDate date]]];
    _yearLabel.backgroundColor = [UIColor lightGrayColor];
    _yearLabel.textAlignment = NSTextAlignmentCenter;
    _yearLabel.text=year;
    for (int i = 0 ;i<count; i++) {
        UILabel *label = [[UILabel alloc] init];
        labelX= (i+0.5) *labelWidth;
        label.frame = CGRectMake(labelX, labelY, labelWidth, labelH);
        label.text = getData[i];
        label.highlightedTextColor = [UIColor redColor];
        label.tag = i;
        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [self.titleArray addObject:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
        if (i == count-1) {
            [self tapClick:tap];
            [self selectLabel:label];
            
        }
        [self.titleScrollView addSubview:label];
        
        
    }
}
-(void)selectLabel:(UILabel *)label{
    _titleLabel.highlighted = NO;
    _titleLabel.transform = CGAffineTransformIdentity;
    _titleLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    label.highlighted = YES;
    label.transform = CGAffineTransformMakeScale(radio, radio);
    _titleLabel = label;
    
    if ([label.text rangeOfString:@" "].location!=NSNotFound) {
        _yearLabel.text =  [NSString stringWithFormat:@"%ld",[NSDate year:[NSDate date]]-1];
    }else{
        _yearLabel.text =  [NSString stringWithFormat:@"%ld",[NSDate year:[NSDate date]]];
    }
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    UILabel *selLabel =(UILabel *)tap.view;
    [self selectLabel:selLabel];

    [self setUpTitleCenter:selLabel];
   
    
}
-(void)setUpTitleCenter:(UILabel *)centerLabel{
   
//    return;
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
    
    NSLog(@"scrollView.contentOffset.x  %f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x<labelWidth*12) {
        _yearLabel.text =  [NSString stringWithFormat:@"%ld",[NSDate year:[NSDate date]]-1];// 去年
    }else{
        _yearLabel.text =  [NSString stringWithFormat:@"%ld",[NSDate year:[NSDate date]]];//今年
    }
    
//    CGFloat currenPage = scrollView.contentOffset.x/scrollView.bounds.size.width;
////    NSLog(@"currenPage %f",currenPage);
//
//
//    NSInteger leftIndex = currenPage;
//    NSInteger rigtIndex = leftIndex+1;
//
//
//    UILabel *leftLabel = self.titleArray[leftIndex];
    
//    NSLog(@"leftalabel  %@",leftLabel.text);
    
//
//    UILabel *rightLabel;
//    if (rigtIndex <self.titleArray.count-2) {
//        rightLabel = self.titleArray[rigtIndex];
//    }
//    CGFloat rightScale = currenPage-leftIndex;
//        NSLog(@"rightScale--%f",rightScale);
//
//    CGFloat leftScale = 1-rightScale ;
//        NSLog(@"leftScale--%f",leftScale);
//
//    // 左边缩放
//    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3+ 1);
//
//    // 右边缩放
//    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3+ 1);
//
//    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
//        leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
//        rightLabel.textColor = [UIColor colorWithRed:rightScale green:1 blue:1 alpha:1];
//        //        NSLog(@"night");
//    }else{
//        leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
//        rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
//        //        NSLog(@"moon");
//    }
   
}
#pragma mark - 结束滚动 需要做的事情

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSLog(@"哪一页 %ld ",index);
    
//    UILabel *selLabel = self.titleArray[index];
//
//    [self selectLabel:selLabel];
//    [self setUpTitleCenter:selLabel];
    
}



#pragma mark - HWCalendarDelegate
- (void)calendar:(HWCalendar *)calendar didClickSureButtonWithDate:(NSString *)date
{
    NSLog(@"  HWCalendar  date %@",date);
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
