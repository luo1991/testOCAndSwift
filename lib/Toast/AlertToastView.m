//
//  AlertToastView.m
//  Doctor_Square
//
//  Created by 董力祯 on 16/7/13.
//  Copyright © 2016年 董力祯. All rights reserved.
//

#import "AlertToastView.h"

@implementation AlertToastView

-(id)initWithTarget:(id)target showTitle:(NSString *)title content:(NSString *)content footTitles:(NSArray *)footTitles{

    self=[[[NSBundle mainBundle] loadNibNamed:@"AlertToastView" owner:self options:nil] lastObject];
    if (self) {
        
        _target=target;
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=4;

        CGRect frame=self.frame;
        frame.origin.x=(MainWidth-frame.size.width)/2;

        if (title.length) {
            
            CGFloat height=[ToastView CGSizeWithSize:CGSizeMake(250, 0) andText:content andFont:_content.font].height;
            frame.size.height=114+height;
            frame.origin.y=(MainHeight-frame.size.height)/2;
            self.frame=frame;
            
            frame=_content.frame;
            frame.size.height=height;
            _content.frame=frame;
        }else{
            _content.font=[UIFont systemFontOfSize:15];
            CGFloat height=[ToastView CGSizeWithSize:CGSizeMake(250, 0) andText:content andFont:_content.font].height;
            frame.size.height=84+height;
            frame.origin.y=(MainHeight-frame.size.height)/2;
            self.frame=frame;

            frame=_content.frame;
            frame.origin.y=22;
            frame.size.height=height;
            _content.frame=frame;
        }
        
        _title.text=title;
        _content.text=content;
        for (NSInteger i=0; i<2; i++) {
            UIButton *btn=[self viewWithTag:100+i];
            [btn setTitle:[footTitles objectAtIndex:i] forState:UIControlStateNormal];
        }
    }
    return self;
}
-(void)show{

    [ViewZoom showSubView:self];
}
- (IBAction)itemClicked:(id)sender {
    
    [ViewZoom dismiss];
    if (_target&&[_target respondsToSelector:@selector(alertToastView:didSelectedIndex:)]) {
        NSInteger index=((UIButton*)sender).tag-100;
        [_target alertToastView:self didSelectedIndex:index];
    }
}
@end
