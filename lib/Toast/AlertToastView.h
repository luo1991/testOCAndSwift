//
//  AlertToastView.h
//  Doctor_Square
//
//  Created by 董力祯 on 16/7/13.
//  Copyright © 2016年 董力祯. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlertToastView;

@protocol AlertToastViewDelegate <NSObject>

-(void)alertToastView:(AlertToastView*)alert didSelectedIndex:(NSInteger)index;

@end
@interface AlertToastView : UIView


-(id)initWithTarget:(id)target showTitle:(NSString*)title content:(NSString*)content footTitles:(NSArray*)footTitles;

-(void)show;
@property(nonatomic,assign)id target;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

- (IBAction)itemClicked:(id)sender;

@end
