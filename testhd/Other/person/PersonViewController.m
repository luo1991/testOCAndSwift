//
//  PersonViewController.m
//  testhd
//
//  Created by admin on 2017/10/20.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITableView *infoTableView;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor grayColor];
    _dataArray = @[@[@"消息通知"],@[@"绑定手机",@"修改密码",@"清理缓存"],@[@"意见提交",@"当前版本",@"客服热线"]];
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-64) style:UITableViewStyleGrouped];
    self.infoTableView.dk_backgroundColorPicker   = DKColorPickerWithKey(SEP);
    [self.view addSubview:self.infoTableView];

    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
   
    self.infoTableView.tableHeaderView= [ self setUPHeaderView] ;
    
    // Do any additional setup after loading the view.
}
-(UIView *)setUPHeaderView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 150)];

    UIImageView *headImage = [[UIImageView alloc] init];
    [headView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.top.mas_equalTo(5);
    }];
    headImage.layer.cornerRadius= 35;
    headImage.layer.masksToBounds = YES;
    headImage.image = [UIImage imageNamed:@"3.jpg"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    [headImage addGestureRecognizer:tap];
    headImage.userInteractionEnabled = YES;
    NSArray *btnArray= @[@"news_cur.png",@"index.png",@"index_cur.png"];
    NSArray *btnTitle= @[@"收藏",@"历史",@"夜间"];
    for (int i = 0; i<btnArray.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        
        [headView addSubview:btn];
        CGFloat btnWidth = MainWidth/3;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(btnWidth, 70));
            make.left.mas_equalTo(btnWidth*i);
            make.top.equalTo(headImage.mas_bottom).with.offset(10);
        }];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btnArray[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnMethod:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn dk_setTitleColorPicker:DKColorPickerWithKey(TEXT) forState:(UIControlState)UIControlStateNormal];
        
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,35, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
        
    }
    
    return headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"personInfo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.dk_backgroundColorPicker  = DKColorPickerWithKey(BG);
    cell.selectionStyle = UITableViewCellSelectionStyleNone; 
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)btnMethod:(UIButton *)btn{
   
    NSInteger index = btn.tag;
    
    NSLog(@" %@ %ld",btn.titleLabel.text,(long)index);
    switch (index) {
        case 0:
            {
                
            }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
//             btn.titleLabel.text = nil;
            if ( [self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
                [btn.dk_manager dawnComing];// 白天模式
               
            [btn setTitle:@"夜间" forState:UIControlStateNormal];
            }else{
                [btn.dk_manager nightFalling];// 夜间模式
               
                [btn setTitle:@"日间" forState:UIControlStateNormal];
                
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)tapMethod:(UITapGestureRecognizer *)tap{
    NSLog(@"tap");
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
