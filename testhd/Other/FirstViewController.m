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

@interface FirstViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIScrollView *contextScrollView;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleImageArr;
@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)UIButton *selctedBtn;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpMainUI];
    [self.view addSubview:self.collectionView];
    
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
    NSInteger count = self.childViewControllers.count;
//    self.titleScrollView.contentSize = CGSizeMake(count*labelWidth, 0);
    self.contextScrollView.contentSize = CGSizeMake(count*MainWidth ,0);
    self.contextScrollView.pagingEnabled = YES;
    self.contextScrollView.bounces = NO;// 弹簧效果
    self.contextScrollView.showsHorizontalScrollIndicator = NO;
    self.contextScrollView.delegate = self;
    
}

//
//-(void)setUpTitleLabelWithCount:(NSMutableArray *)getData{
//    //    NSUInteger count = self.childViewControllers.count;
//    int count = (int) getData.count;
//    NSArray *btnArray= @[@"news_cur.png",@"index.png",@"index_cur.png"];
//    NSArray *btnTitle= @[@"收藏",@"历史",@"夜间",@"龙",@"虎",@"豹",@"狼",@"狗",@"猫"];
//    CGFloat labelX = 0;
//    CGFloat labelY = 0;
//    CGFloat labelH = 44;
//
//    for (int i = 0 ;i<count; i++) {
//        UIButton *btn = [[UIButton alloc] init];
//        labelX= (i+0.5) *MainWidth/3;
//        btn.frame = CGRectMake(labelX, labelY, MainWidth/3, labelH);
//        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
////        label.highlightedTextColor = [UIColor redColor];
//        btn.tag = i;
////        label.dk_textColorPicker = DKColorPickerWithKey(TEXT);
////        label.userInteractionEnabled = YES;
////        label.textAlignment = NSTextAlignmentCenter;
//
////        if (i == count-1) {
////            [self tapClick:tap];
////            [self selectLabel:label];
////
////        }
//        [self.contextScrollView addSubview:btn];
//
//
//    }
//}
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
