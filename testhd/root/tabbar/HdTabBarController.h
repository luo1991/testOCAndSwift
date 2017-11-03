//
//  HdTabBarController.h
//  testhd
//
//  Created by admin on 17/9/26.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HdTabBarControllerDelegate <NSObject>

-(void)baseTabItemDidToucedtouble;

@end

@interface HdTabBarController : UITabBarController{
    NSInteger _showIndex;
}

@property(nonatomic,assign)id target;
-(void)refreshView;
@end
