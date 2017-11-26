//
//  CollectionViewCell.m
//  testhd
//
//  Created by 罗衍运123 on 2017/11/26.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_startBtn setImage:[UIImage imageNamed:@"index"] forState:UIControlStateNormal];
    [_startBtn setImage:[UIImage imageNamed:@"index_cur"] forState:UIControlStateSelected];
    
    // Initialization code
}

@end
