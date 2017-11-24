//
//  TitleScrollview.h
//  testhd
//
//  Created by admin on 2017/11/24.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TitleScrollviewDelegate <NSObject>

//确认选项后，如有其它特殊操作，用此代理事件
- (void)didSelectOptionIndexString:(NSString *)indexString;

@end
@interface TitleScrollview : UIView

@property (nonatomic, weak) id<TitleScrollviewDelegate> delegate;

@end
