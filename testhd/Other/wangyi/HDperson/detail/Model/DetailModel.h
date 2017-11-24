//
//  DetailModel.h
//  testhd
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetaillistModel : NSObject
@property(nonatomic,copy)NSString *checkDate;
@property(nonatomic,copy)NSString *checkExplain;
@property(nonatomic,copy)NSString *isCheck;
@property(nonatomic,copy)NSString *listOperator;
@property(nonatomic,copy)NSString *reason;


@end



@interface DetailModel : NSObject
@property(nonatomic,copy)NSString *calendarTypeExplain;
@property(nonatomic,copy)NSString *checkExplain;
@property(nonatomic,copy)NSString *endDate;
@property(nonatomic,copy)NSString *hour;
@property(nonatomic,copy)NSString *isCheck;
@property(nonatomic,copy)NSString *leader;
@property(nonatomic,strong)NSArray *list;
@property(nonatomic,copy)NSString *realname;
@property(nonatomic,copy)NSString *reason;
@property(nonatomic,copy)NSString *showType;
@property(nonatomic,copy)NSString *signType;
@property(nonatomic,copy)NSString *signTypeExplain;
@property(nonatomic,copy)NSString *startDate;
@property(nonatomic,copy)NSString *listOperator;
@end
