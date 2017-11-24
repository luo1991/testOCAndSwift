//
//  HWCalendar.m
//  HWCalendar
//
//  Created by wqb on 2017/1/12.
//  Copyright © 2017年 hero_wqb. All rights reserved.
//

#import "HWCalendar.h"
#import "HWOptionButton.h"
#import "TitleScrollview.h"

#define KCol 7
#define KBtnW 44
#define KBtnH 44
#define KMaxCount 37
#define KBtnTag 100
#define KTipsW 40
#define KShowYearsCount 100
#define KMainColor [UIColor colorWithRed:0.0f green:139/255.0f blue:125/255.0f alpha:1.0f]
#define KbackColor [UIColor colorWithRed:173/255.0f green:212/255.0f blue:208/255.0f alpha:1.0f]

@interface HWCalendar ()<UIPickerViewDelegate, UIPickerViewDataSource, HWOptionButtonDelegate,TitleScrollviewDelegate>

@property (nonatomic, strong) NSArray *weekArray;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) NSArray *yearArray;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic, strong) UIPickerView *timePicker;
@property (nonatomic, weak) UIView *calendarView;
@property (nonatomic, weak) HWOptionButton *yearBtn;
@property (nonatomic, weak) HWOptionButton *monthBtn;
@property (nonatomic, weak) UILabel *weekLabel;
@property (nonatomic, weak) UILabel *yearLabel;
@property (nonatomic, weak) UILabel *monthLabel;
@property (nonatomic, weak) UILabel *dayLabel;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger currentYear;
@property (nonatomic, assign) NSInteger currentMonth;
@property (nonatomic, assign) NSInteger currentDay;

@end

@implementation HWCalendar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //获取当前时间
        [self getCurrentDate];
        
        //获取数据源
        [self getDataSource];
        
        //创建控件
        [self creatControl];
        
        //初始化设置
        [self setDefaultInfo];
        
        //刷新数据
        [self reloadData];
    }
    
    return self;
}

- (void)getDataSource
{
    _weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    _timeArray = @[@[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"], @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59"]];
    
    NSInteger firstYear = _year - KShowYearsCount / 2;
    NSMutableArray *yearArray = [NSMutableArray array];
    for (int i = 0; i < KShowYearsCount; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld", firstYear + i]];
    }
    _yearArray = yearArray;
    _monthArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
}

- (void)setDefaultInfo
{
    self.backgroundColor = [UIColor whiteColor];
    [_timePicker selectRow:_hour inComponent:0 animated:NO];
    [_timePicker selectRow:_minute - 1 inComponent:1 animated:NO];
    _currentYear = _year;
    _currentMonth = _month;
    _currentDay = _day;
}

- (void)creatControl
{
    TitleScrollview *headScrollview= [[TitleScrollview alloc] initWithFrame:CGRectMake(0, 0, MainWidth, KBtnH)];
    headScrollview.delegate = self;
    [self addSubview:headScrollview];
    
    
    //星期标签
    for (int i = 0; i < _weekArray.count; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(KTipsW + KBtnH * i, KBtnH, KBtnH, KBtnH)];
        week.textAlignment = NSTextAlignmentCenter;
        week.text = _weekArray[i];
        [self addSubview:week];
    }
    
    //日历核心视图
    UIView *calendarView = [[UIView alloc] initWithFrame:CGRectMake(KTipsW, KBtnH * 2, KBtnW * 7, KBtnH * 6)];
    [self addSubview:calendarView];
    self.calendarView = calendarView;
    
    //每一个日期用一个按钮去创建，当一个月的第一天是星期六并且有31天时为最多个数，5行零2个，共37个
    for (int i = 0; i < KMaxCount; i++) {
        CGFloat btnX = i % KCol * KBtnW;
        CGFloat btnY = i / KCol * KBtnH;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, KBtnW, KBtnH)];
        btn.tag = i + KBtnTag;
        btn.layer.cornerRadius = KBtnW * 0.5;
        btn.layer.masksToBounds = YES;
        [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:KMainColor forState:UIControlStateSelected];
        [btn setBackgroundImage:[self imageWithColor:KbackColor] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[self imageWithColor:KbackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(dateBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [calendarView addSubview:btn];
    }
    
//    //确认按钮
//    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(backTodayBtn.frame), CGRectGetMaxY(calendarView.frame), yearBtnW, KBtnH)];
//    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
//    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [sureBtn setTitleColor:KMainColor forState:UIControlStateNormal];
//    [sureBtn addTarget:self action:@selector(sureBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:sureBtn];
//    
//    //取消按钮
//    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(sureBtn.frame) - yearBtnW, CGRectGetMinY(sureBtn.frame), yearBtnW, KBtnH)];
//    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancelBtn setTitleColor:KMainColor forState:UIControlStateNormal];
//    [cancelBtn addTarget:self action:@selector(cancelBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:cancelBtn];
    
//    //时间选择器
//    _timePicker = [[UIPickerView alloc] init];
//    _timePicker.backgroundColor = KMainColor;
//    _timePicker.hidden = YES;
//    _timePicker.delegate = self;
//    _timePicker.dataSource = self;
//    [self addSubview:_timePicker];
}

//set方法
- (void)setShowTimePicker:(BOOL)showTimePicker
{
    _showTimePicker = showTimePicker;
    
    if (showTimePicker) {
        _timePicker.hidden = NO;
        _dayLabel.frame = CGRectMake(0, CGRectGetMaxY(_monthLabel.frame) + 10, KTipsW, 120);
        _timePicker.frame = CGRectMake(10, CGRectGetMaxY(_dayLabel.frame), KTipsW - 20, 88);
    }else {
        _timePicker.hidden = YES;
        _dayLabel.frame = CGRectMake(0, CGRectGetMaxY(_monthLabel.frame) + 30, 200, 120);
    }
}



//刷新数据
- (void)reloadData
{
    
    
    NSInteger totalDays = [self numberOfDaysInMonth];
    NSInteger firstDay = [self firstDayOfWeekInMonth];
    
    _yearLabel.text = [NSString stringWithFormat:@"%ld", _year];
    _monthLabel.text = [NSString stringWithFormat:@"%ld月", _month];
    _yearBtn.title = [NSString stringWithFormat:@"%ld年", _year];
    _monthBtn.title = [NSString stringWithFormat:@"%ld月", _month];
    
    for (int i = 0; i < KMaxCount; i++) {
        UIButton *btn = (UIButton *)[self.calendarView viewWithTag:i + KBtnTag];
        btn.selected = NO;
        
        if (i < firstDay - 1 || i > totalDays + firstDay - 2) {
            btn.enabled = NO;
            [btn setTitle:@"" forState:UIControlStateNormal];
        }else {
            if (_year == _currentYear && _month == _currentMonth) {
                if (btn.tag - KBtnTag - (firstDay - 2) == _currentDay) {
                    btn.selected = YES;
                    _day = _currentDay;
                    _weekLabel.text = [NSString stringWithFormat:@"星期%@", _weekArray[(btn.tag - KBtnTag) % 7]];
                    _dayLabel.text = [NSString stringWithFormat:@"%ld", _day];
                }
            }else {
                if (i == firstDay - 1) {
                    btn.selected = YES;
                    _day = btn.tag - KBtnTag - (firstDay - 2);
                    _weekLabel.text = [NSString stringWithFormat:@"星期%@", _weekArray[(btn.tag - KBtnTag) % 7]];
                    _dayLabel.text = [NSString stringWithFormat:@"%ld", _day];
                }
            }
            btn.enabled = YES;
            [btn setTitle:[NSString stringWithFormat:@"%ld", i - (firstDay - 1) + 1] forState:UIControlStateNormal];
        }
    }
    
    [self sureBtnOnClick];
}

//获取当前时间
- (void)getCurrentDate
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    _year = [components year];
    _month = [components month];
    _day = [components day];
    _hour = [components hour];
    _minute = [components minute];
}

//根据选中日期，获取相应NSDate
- (NSDate *)getSelectDate
{
    //初始化NSDateComponents，设置为选中日期
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = _year;
    dateComponents.month = _month;
    
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:dateComponents];
}

//获取目标月份的天数
- (NSInteger)numberOfDaysInMonth
{
    //获取选中日期月份的天数
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self getSelectDate]].length;
}

//获取目标月份第一天星期几
- (NSInteger)firstDayOfWeekInMonth
{
    //获取选中日期月份第一天星期几，因为默认日历顺序为“日一二三四五六”，所以这里返回的1对应星期日，2对应星期一，依次类推
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfYear forDate:[self getSelectDate]];
}

//根据颜色返回图片
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//选中日期时调用
- (void)dateBtnOnClick:(UIButton *)btn
{
    _day = btn.tag - KBtnTag - ([self firstDayOfWeekInMonth] - 2);
    _weekLabel.text = [NSString stringWithFormat:@"星期%@", _weekArray[(btn.tag - KBtnTag) % 7]];
    _dayLabel.text = [NSString stringWithFormat:@"%ld", _day];
    
    if (btn.selected) return;
    
    for (int i = 0; i < KMaxCount; i++) {
        UIButton *button = [self.calendarView viewWithTag:i + KBtnTag];
        button.selected = NO;
    }
    
    btn.selected = YES;
    
//    NSLog(@"%ld %ld %ld",_year,_month,_day);
    [self sureBtnOnClick];
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _timeArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_timeArray[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _timeArray[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *time = _timeArray[component][row];
    if (component == 0) {
        _hour = [time integerValue];
    } else if (component == 1) {
        _minute = [time integerValue];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor whiteColor];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:20.0f];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}



//确认按钮点击事件
- (void)sureBtnOnClick
{
//    [self dismiss];
    
    NSString *date;
//    if (_showTimePicker) {
//        date = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld", _year, _month, _day, _hour, _minute];
//    }else {
        date = [NSString stringWithFormat:@"%ld-%ld-%ld", _year, _month, _day];
//    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(calendar:didClickSureButtonWithDate:)]) {
        [_delegate calendar:self didClickSureButtonWithDate:date];
    }
}

//取消按钮点击事件
- (void)cancelBtnOnClick
{
    [self dismiss];
}

//弹入视图
- (void)show
{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(7, 140, self.bounds.size.width, self.bounds.size.height);
    }];
}

//弹出视图
- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = CGRectMake(7, [UIScreen mainScreen].bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    }];
}

#pragma mark - HWOptionButtonDelegate
- (void)didSelectOptionIndexString:(NSString *)indexString
{
    if (indexString.length > 3) {
        
        _year = [NSDate year:[NSDate date]]-1;
        
        _month = [[indexString substringToIndex:3] integerValue];
        

    }else {
        _year = [NSDate year:[NSDate date]];
        
        _month = [[indexString substringToIndex:2] integerValue];
        

    }
//    date = [NSString stringWithFormat:@"%ld-%02ld-%02ld", _year, _month, _day];
//    NSLog(@"%ld年 %ld月 ",_year,_month);
//    NSLog(@"%ld日",_day);
    
    [self reloadData];
}

@end
