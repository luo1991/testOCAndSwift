//
//  HotViewController.h
//  testhd
//
//  Created by admin on 2017/10/30.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@end
