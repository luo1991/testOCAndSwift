//
//  PersonTableViewCell.m
//  testhd
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "PersonTableViewCell.h"

@implementation PersonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
