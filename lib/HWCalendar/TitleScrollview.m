//
//  TitleScrollview.m
//  testhd
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "TitleScrollview.h"

static CGFloat const labelWidth = 80;  // 标题文字宽度
static CGFloat const radio = 1.3;   // 点击或者滑动scrollView 标题Label放大倍数

@interface TitleScrollview ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *titleScrollView;

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *yearLabel;// 显示年份的控件
@property(nonatomic,assign)NSInteger month;

@end

@implementation TitleScrollview

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self setup];
    }
    
    return self;
}
- (void)setup{
    NSInteger month = [NSDate month:[NSDate date]];
    self.month = 12;
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
    
//    NSLog(@"data %@",getData);
    
    self.titleScrollView = [[UIScrollView alloc] init];
    self.titleScrollView.backgroundColor = [UIColor whiteColor];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    [self addSubview:self.titleScrollView];
    self.titleScrollView.delegate = self;
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.mas_left);
    }];
    self.titleScrollView.contentSize = CGSizeMake(getData.count*labelWidth+56, 0);
    
    self.titleScrollView.bounces = NO;// 弹簧效果
     [self setUpTitleLabelWithCount:getData];
    self.userInteractionEnabled= YES;
    self.titleScrollView.userInteractionEnabled = YES;
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
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, labelH)];
    [self addSubview:_yearLabel];
    _yearLabel.backgroundColor = [UIColor whiteColor];
    _yearLabel.textColor = KbackColor;
    _yearLabel.textAlignment = NSTextAlignmentCenter;
    NSString *year = [NSString stringWithFormat:@"%ld年",[NSDate year:[NSDate date]]];
    _yearLabel.text=year;
    for (int i = 0 ;i<count; i++) {
        UILabel *label = [[UILabel alloc] init];
        labelX= (i+0.7) *labelWidth;
        label.frame = CGRectMake(labelX, labelY, labelWidth, labelH);
        label.text = getData[i];
        label.highlightedTextColor = KbackColor;
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
            [self setUpTitleCenter:label];
            
            
        }
        [self.titleScrollView addSubview:label];
                
    }
}
-(void)selectLabel:(UILabel *)label{
  
    _titleLabel.highlighted = NO;
    _titleLabel.transform = CGAffineTransformIdentity;
    
//    _titleLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    label.highlighted = YES;
    label.transform = CGAffineTransformMakeScale(radio, radio);
//    label.textColor = [UIColor whiteColor];
    

    _titleLabel = label;
   
//    _titleLabel.backgroundColor = KbackColor;

}

#pragma mark 点击事件

-(void)tapClick:(UITapGestureRecognizer *)tap{
    self.month= 10;
    UILabel *selLabel =(UILabel *)tap.view;
    [self selectLabel:selLabel];
    if ([selLabel.text rangeOfString:@" "].location!=NSNotFound) {
        _yearLabel.text =  [NSString stringWithFormat:@"%ld年",[NSDate year:[NSDate date]]-1];

    }else{
        _yearLabel.text =  [NSString stringWithFormat:@"%ld年",[NSDate year:[NSDate date]]];

    }
    if ([self.delegate respondsToSelector:@selector(didSelectOptionIndexString:)]) {
        [self.delegate didSelectOptionIndexString:selLabel.text];
        
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
    if (scrollView.contentOffset.x<labelWidth*12) {
        _yearLabel.text =  [NSString stringWithFormat:@"%ld年",[NSDate year:[NSDate date]]-1];// 去年

    }else{
        _yearLabel.text =  [NSString stringWithFormat:@"%ld年",[NSDate year:[NSDate date]]];//今年

    }
    
}
#pragma mark - 结束滚动 需要做的事情

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
