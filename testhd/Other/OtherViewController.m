//
//  OtherViewController.m
//  testhd
//
//  Created by admin on 17/9/25.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "OtherViewController.h"
#import "testhd-Swift.h"
#import "Masonry.h"


#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height


#import "iCarousel.h"
@interface OtherViewController ()<iCarouselDataSource, iCarouselDelegate>
//<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong)  iCarousel *carousel;

@property(nonatomic,strong)UIPageControl* myPageControl ;
@end



@implementation OtherViewController

- (void)setUp
{
    //set up data
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < 10; i++)
    {
        [self.items addObject:@(i)];
    }
}


- (void)viewDidLoad {
     [self setUp];
    [super viewDidLoad];
    
    _carousel = [[iCarousel alloc] init];
   
    _carousel.contentMode = UIViewContentModeCenter;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_carousel];
    [_carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 120));
        make.top.equalTo(@0);
    }];
    
    _carousel.type = iCarouselTypeRotary;// 必须在下面的之前设置，不然需要 reload
    _carousel.delegate = self;
    _carousel.dataSource = self;
    
    /** 利用runtime遍历一个类的全部成员变量
     
     1.导入头文件    */
    unsigned int count =0;
    /** Ivar:表示成员变量类型 */
    
    objc_property_t *properties = class_copyPropertyList([hdtest class], &count);
    
    //获得一个指向该类成员变量的指针
    for(int i =0; i < count; i ++) {
        //获得Ivar
        objc_property_t property = properties[i];
        //根据ivar获得其成员变量的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        
//        [encoder encodeObject:[selfvalueForKeyPath:key] forKey:key];
        NSLog(@"%d----%@",i,key);
    
    }
    
   
    
//    [self.carousel scrollToItemAtIndex:6 animated:NO];// 设置当前显示
//    
//    self.carousel.clipsToBounds = YES;
   
    
    
    self.carousel .decelerationRate = 0.95;
   self.view.backgroundColor = UIColor.grayColor;
    
    
    UIPageControl* myPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0.0, 90, 320.0, 10)];
    myPageControl.backgroundColor = [UIColor grayColor];
    myPageControl.numberOfPages =self.items.count;
//    myPageControl.currentPage =1;
    myPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    myPageControl.pageIndicatorTintColor = [UIColor blackColor];
    myPageControl.hidesForSinglePage=YES;
    myPageControl.defersCurrentPageDisplay = YES;
    
//    [self.view addSubview:myPageControl];
//    _myPageControl = myPageControl;
    
    [myPageControl addTarget:self action:@selector(clickPageController:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.carousel.type = iCarouselTypeRotary;
    
//    self.view.backgroundColor = [UIColor grayColor];
//
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    flowLayout.minimumLineSpacing = 2;
//    flowLayout.itemSize = CGSizeMake(130, 130);
//    //列距
//    flowLayout.minimumInteritemSpacing = 30;
//    //行距
//    flowLayout.minimumLineSpacing = 10;
    //item大大小
//    flowLayout.itemSize = CGSizeMake((kScreenW-60)/3, 200);
//    //初始化
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 130) collectionViewLayout:flowLayout];
//    
//    //设置代理
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    collectionView.showsVerticalScrollIndicator = NO;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    //设置背景颜色
//    collectionView.backgroundColor = [UIColor whiteColor];
//    //添加视图显示
//    [self.view addSubview:collectionView];
//    
//    //注册时用UICollectionViewCell
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"点击跳转" forState:UIControlStateNormal];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//    }];
//    [button addTarget:self action:@selector(btnMethod) forControlEvents:UIControlEventTouchUpInside];
    
   

    
    
    
    // Do any additional setup after loading the view.
}
- (void)clickPageController:(UIPageControl *)pageController event:(UIEvent *)touchs{
    UITouch *touch = [[touchs allTouches] anyObject];
    CGPoint p = [touch locationInView:_myPageControl];
    CGFloat centerX = pageController.center.x;
    CGFloat left = centerX-15.0*self.items.count/2;
    [_myPageControl setCurrentPage:(int ) (p.x-left)/15];
    [self.carousel scrollToItemAtIndex:_myPageControl.currentPage animated:YES];
    
    NSLog(@"%f",(p.x-left)/15);
}

-(void)pageChanged:(id)sender{
    UIPageControl* control = (UIPageControl*)sender;
    NSInteger index = control.currentPage;
    //添加你要处理的代码
    
    NSLog(@"index %d",index);
    
    if (index == [self.items count] - 1) {
        [self.carousel scrollToItemAtIndex:0 animated:YES];
    } else {
        [self.carousel scrollToItemAtIndex:index+1 animated:YES];
    }
    
  
}



-(void)btnMethod{
 
    hdViewController *hdSwiftVC = [[hdViewController alloc] init];
     
    hdSwiftVC.title= @"Swift";
    [self.navigationController pushViewController:hdSwiftVC animated:YES];
    
//     mas_makeConstraints 只负责新增约束,Autolayout 不能同时存在两条针对于同一对象约束 否则会报错
    
//    mas_remakeConstraints 会清除之前的所有约束 仅保留最新的约束
    
//    mas_updateConstraints 针对上面的情况 会更新block中出现的约束 不会导致出现两个相同的约束的情况 但必须是同一参照物
    
    [_carousel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
//        make.baseline.mas_equalTo(10);
    }];
    NSLog(@"点击");
    
//    [self updateViewConstraints];
//    
//     [self layoutIfNeeded]
    
//    NSLog(@"按钮点击事件");
}

////设置个数
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return 10;
//}
//
////创建item
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
//    return cell;
//    
//}

#pragma mark -
#pragma mark iCarousel methods
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    
    NSLog(@"self.items %@",self.items);
    return [self.items count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
  
    //create new view if no view is available for recycling
    if (view == nil)
    {
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 100)];
        //        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor yellowColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
   label.text = [self.items[(NSUInteger)index] stringValue];
    view.backgroundColor = [UIColor redColor];
    return view;
}
//- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
//{
//       NSLog(@"fghhhhhh  %f",value);
////    if (option == iCarouselTypeRotary)
////    {
////        return value * 1.1f;
////    }
//    
//    if (option==iCarouselOptionVisibleItems) {
//        return 4;
//    }
// 
//    return value;
//}


//- (void)carouselDidScroll:(iCarousel *)carousel{
//    NSLog(@"滚动中");
//    //当前图片alpha为1 其他的图片为0.4
//    for (UIView *vvv in carousel.visibleItemViews) {
//        vvv.alpha = 0.4;
//    }
//    UIView *vv = [carousel currentItemView];
//    vv.alpha = 1;
//}

////item图片之间的间隔宽
//-(CGFloat)carouselItemWidth:(iCarousel *)carousel {
//    
//    return kScreenW;
//}

#pragma mark -
#pragma mark iCarousel taps
- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"Tapped view number: %ld", (long)index);
    
    if (index==1) {
        [self  btnMethod];
        
    }
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel {
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
    
    _myPageControl.currentPage =self.carousel.currentItemIndex;
    
   
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
