//
//  TabbarItem.m
//  testhd
//
//  Created by admin on 2017/11/2.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "TabbarItem.h"

@implementation TabbarItem
-(id)initWithFrame:(CGRect)frame normalIamge:(NSString *)norImage selectImage:(NSString *)selectImage itemTitle:(NSString *)title{
    self = [self.class buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.frame = frame;
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn.frame = CGRectMake((frame.size.width-22)/2.0f, 5.5, 22, 38);
        [_iconBtn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
        [_iconBtn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        _iconBtn.userInteractionEnabled = YES;
        _iconBtn.selected = NO;
        [self addSubview:_iconBtn];
        
        _redicon = [[UILabel alloc] initWithFrame:CGRectMake(_iconBtn.frame.size.width-5, -1, 8, 8)];
        _redicon.backgroundColor =XRGB(ff, 59, 4c);
        _redicon.layer.masksToBounds = YES;
        _redicon.layer.cornerRadius = 5;
        [_iconBtn addSubview:_redicon];
        _redicon.hidden = YES;
    }
    return self;
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        _iconBtn.selected = YES;
        _titleLabel.textColor = [UIColor redColor];
    }else{
        _iconBtn.selected = NO;
        _titleLabel.textColor = [UIColor grayColor];
    }
}

/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}  
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
