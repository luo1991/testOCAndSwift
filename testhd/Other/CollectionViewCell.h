//
//  CollectionViewCell.h
//  testhd
//
//  Created by 罗衍运123 on 2017/11/26.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleIMage;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end
