//
//  WaterfallCollectionViewCell.m
//  testhd
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "WaterfallCollectionViewCell.h"

@implementation WaterfallCollectionViewCell
#pragma mark - Accessors
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageView.layer setMasksToBounds:YES];
    }
    return _imageView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
@end
