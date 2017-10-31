//
//  HotViewController.m
//  testhd
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "HotViewController.h"
#import "WaterfallCollectionViewCell.h"

#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"
@interface HotViewController ()
@property (nonatomic, strong) NSArray *cellSizes;
@property (nonatomic, strong) NSArray *personDatas;

@end

@implementation HotViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.headerHeight = 15;
        layout.footerHeight = 10;
        layout.minimumColumnSpacing = 5; //左右cell的间距
        layout.minimumInteritemSpacing = 5;//上下cell的间距
         layout.columnCount = 3;    //3列， 根据列数，间距等，使每个cell的宽度固定
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView .autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[WaterfallCollectionViewCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        
    }
     return _collectionView;
}
- (NSArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(1920, 1441)],
                       [NSValue valueWithCGSize:CGSizeMake(640, 640)],
                       [NSValue valueWithCGSize:CGSizeMake(640 , 640)],
                       [NSValue valueWithCGSize:CGSizeMake(400, 550)]
                       ];
    }
    return _cellSizes;
}
- (NSArray *)personDatas {
    if (!_personDatas) {
        _personDatas = @[@"1.jpg", @"2.jpg", @"3.jpg", @"cat1.jpg"];
    }
    return _personDatas;
}
#pragma mark - Life Cycle

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
// 瀑布流的实现
    [self.view addSubview:self.collectionView];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
    
}
- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
//    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation)? 2 : 3;

    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterfallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    if (!cell) {
        cell = [[WaterfallCollectionViewCell alloc] init];
    }
    cell.imageView.image = [UIImage imageNamed:self.personDatas[indexPath.item % 4]];
    return cell;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//     UICollectionReusableView *reusableView = nil;
//    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
//        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                          withReuseIdentifier:HEADER_IDENTIFIER
//                                                                 forIndexPath:indexPath];
//    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
//        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                          withReuseIdentifier:FOOTER_IDENTIFIER
//                                                                 forIndexPath:indexPath];
//    }
//
//    return reusableView;
//}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellSizes[indexPath.item % 4] CGSizeValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
