//
//  TabbarItem.h
//  testhd
//
//  Created by admin on 2017/11/2.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarItem : UIButton{
    UIButton *_iconBtn;
    UILabel *_titleLabel;
}
-(id)initWithFrame:(CGRect)frame normalIamge:(NSString *)norImage selectImage:(NSString *)selectImage itemTitle:(NSString *)title;

@property(nonatomic,strong)UILabel *redicon;
@end
