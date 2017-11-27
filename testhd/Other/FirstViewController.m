//
//  FirstViewController.m
//  testhd
//
//  Created by 罗衍运123 on 2017/11/26.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "FirstViewController.h"
#import "CollectionViewCell.h"
#define kcellIdentifier @"CollectionViewCell"

@interface FirstViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIScrollView *contextScrollView;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleImageArr;
@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)UIButton *selctedBtn;
@property(nonatomic,strong)UIPageControl* myPageControl;

@property (nonatomic, strong) UIPickerView *timePicker;
@property(nonatomic,strong)NSArray *proTimeList;
@property(nonatomic,strong)NSArray *proTitleList;



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMainUI];
//    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleImageArr= @[@"1.jpg",@"2.jpg",@"3.jpg"];
        _titleArr= @[@"收藏",@"历史",@"夜间",@"龙",@"虎",@"豹",@"狼",@"狗",@"猫"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    
    
    
    // Do any additional setup after loading the view.
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        // layout.minimumInteritemSpacing = 10;// 垂直方向的间距
        // layout.minimumLineSpacing = 10; // 水平方向的间距
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 130) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


-(void)setUpMainUI{
    self.contextScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.contextScrollView];
    
    [self.contextScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    NSArray *btnTitle= @[@"龙",@"象",@"狮",@"虎",@"豹",@"狼",@"狗",@"猫",@"鼠"];
//    self.titleScrollView.contentSize = CGSizeMake(count*labelWidth, 0);
    self.contextScrollView.contentSize = CGSizeMake(btnTitle.count*MainWidth/3 ,0);
    self.contextScrollView.pagingEnabled = YES;
    self.contextScrollView.bounces = NO;// 弹簧效果
    self.contextScrollView.showsHorizontalScrollIndicator = NO;
    self.contextScrollView.delegate = self;
//     NSArray *btnTitle= @[@"收藏",@"历史",@"夜间",@"龙",@"虎",@"豹",@"狼",@"狗",@"猫"];
    [self setUpTitleLabelWithCount:btnTitle];
    
    UIPageControl* myPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0.0, 90, MainWidth, 10)];
    self.myPageControl = myPageControl;
    
//    myPageControl.backgroundColor = [UIColor redColor];
    myPageControl.numberOfPages =btnTitle.count/3;
//        myPageControl.currentPage =1;
    myPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    myPageControl.pageIndicatorTintColor = [UIColor blackColor];
    myPageControl.hidesForSinglePage=YES;
    myPageControl.defersCurrentPageDisplay = YES;
     [myPageControl addTarget:self action:@selector(clickPageController:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myPageControl];
    
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    
    
//    CGFloat btnWidth = MainWidth/3;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 70));
        make.centerX.mas_equalTo(self.view);
        make.top.equalTo(self.myPageControl.mas_bottom).with.offset(10);
    }];
    [btn setTitle:@"点击pickView" forState:UIControlStateNormal];
    //                [btn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
  
    [btn dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:(UIControlState)UIControlStateNormal];
    
    
    
   
}

-(void)clickBtn{
    [self setUpPickView];
    
}
-(void)setUpPickView{
    //时间选择器
    // 选择框
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 300, 320, 216)];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    
    _proTimeList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    _proTitleList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _titleArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_titleArr[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _titleArr[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *time = _titleArr[component][row];
//    if (component == 0) {
//        _hour = [time integerValue];
//    } else if (component == 1) {
//        _minute = [time integerValue];
//    }
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
//pagecontroll的委托方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    NSLog(@"%d", page);
    
    // 设置页码
    self.myPageControl.currentPage = page;
}


- (void)clickPageController:(UIPageControl *)pageController event:(UIEvent *)touchs{
    //令UIScrollView做出相应的滑动显示
    CGSize viewSize = self.contextScrollView.frame.size;
    CGRect rect = CGRectMake(pageController.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.contextScrollView scrollRectToVisible:rect animated:YES];
}

-(void)setUpTitleLabelWithCount:(NSArray *)getData{
    //    NSUInteger count = self.childViewControllers.count;
    int count = (int) getData.count;
    NSArray *btnArray= @[@"me_unselected.png",@"order_unselected.png",@"square_unselected.png"];
    NSArray *selectedArray= @[@"me_selected.png",@"order_selected.png",@"square_selected.png",];
//    NSArray *btnTitle= @[@"收藏",@"历史",@"夜间",@"龙",@"虎",@"豹",@"狼",@"狗",@"猫"];
//    CGFloat labelX = 0;
//    CGFloat labelY = 0;
//    CGFloat labelH = 120;

    for (int i = 0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [self.contextScrollView addSubview:btn];
        
    
        CGFloat btnWidth = MainWidth/3;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(btnWidth, 70));
            make.left.mas_equalTo(btnWidth*i);
            make.top.equalTo(0).with.offset(10);
        }];
        [btn setTitle:getData[i] forState:UIControlStateNormal];
//                [btn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btnArray[i%3]] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageNamed:selectedArray[i%3]] forState:UIControlStateSelected];
        if (i == 0) {
//            self.selctedBtn.selected = NO;
            btn.selected= YES;
            self.selctedBtn = btn;
        }
        [btn addTarget:self action:@selector(btnMethod:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:(UIControlState)UIControlStateNormal];
        
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,35, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
       
    }
}

-(void)btnMethod:(UIButton *)btn{
    
    //1.先将之前选中的按钮设置为未选中
    self.selctedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    btn.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selctedBtn = btn;
    NSLog(@"点击");
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArr.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    CollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[CollectionViewCell alloc] init];
    }
    cell.titleIMage.image = [UIImage imageNamed:self.titleImageArr[indexPath.row%3]];
    cell.numberLabel.text = self.titleArr[indexPath.row];
    cell.backgroundColor = [UIColor  grayColor];
    return cell;
    
}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//    NSString *reuseIdentifier;
////    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
////        reuseIdentifier = kfooterIdentifier;
////    }else{
////        reuseIdentifier = kheaderIdentifier;
//    }
//
//    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
//
//    UILabel *label = (UILabel *)[view viewWithTag:1];
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
//        label.text = [NSString stringWithFormat:@"这是header:%d",indexPath.section];
//    }
//    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        view.backgroundColor = [UIColor lightGrayColor];
//        label.text = [NSString stringWithFormat:@"这是footer:%d",indexPath.section];
//    }
//    return view;
//}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 130);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

////返回头headerView的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={320,45};
//    return size;
//}
////返回头footerView的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size={320,45};
//    return size;
//}
//每个section中不同的行之间的行间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CGFLOAT_MIN;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.startBtn.selected = YES;
    
    //1.先将之前选中的按钮设置为未选中
    self.selctedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    cell.startBtn.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selctedBtn = cell.startBtn;
//    [cell setBackgroundColor:[UIColor greenColor]];
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor redColor]];
}




//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    // 计算滚动到哪一页
//    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    NSLog(@"%ld",index);
//
//}
//
//#pragma mark - 结束滚动 需要做的事情
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    // 计算滚动到哪一页
//    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
//    NSLog(@"%ld",index);
//}
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
