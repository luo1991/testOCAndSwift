//
//  HotViewController.m
//  testhd
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "HotViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
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
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.headerHeight = 15;
        layout.footerHeight = 10;
        layout.minimumColumnSpacing = 20;
        layout.minimumInteritemSpacing = 30;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView .autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
     return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
// 瀑布流的实现
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
