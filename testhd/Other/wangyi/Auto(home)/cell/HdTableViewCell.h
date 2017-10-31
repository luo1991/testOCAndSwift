//
//  HdTableViewCell.h
//  testhd
//
//  Created by admin on 17/9/18.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HdTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@end
