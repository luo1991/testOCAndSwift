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




@interface ReadViewController ()<UIScrollViewDelegate>

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
