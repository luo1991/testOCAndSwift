//
//  ViewController.m
//  testhd
//
//  Created by admin on 17/9/18.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "ViewController.h"
#import "HdTableViewCell.h"
#import "testhd-Bridging-Header.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;

@property (strong,nonatomic)NSArray * imageArray;
@property (strong,nonatomic)NSArray * headImageArray;

@property (strong,nonatomic)NSArray * detailArray;
//去缓存cell的高度
@property(nonatomic,strong)NSMutableDictionary *heightAtIndexPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"热门";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
     self.tableView.estimatedRowHeight = 80.0f;
    self.headImageArray = @[@"data",@"location",@"write"];
    self.imageArray = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    
    
    self.detailArray = @[@"shot",@"Aduahguhauhguhaudghuahguhudhauhg",@"dhuahgudhaughuahdughuahguhauhguhdahudhuahughduahguhadguhaduhguadhughduahguahguhadugh"];
    
//    [self.tableView registerClass:[HdTableViewCell class] forCellReuseIdentifier:@"hdcell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HdTableViewCell" bundle:nil] forCellReuseIdentifier:@"hdcell"];
    
    
}
// 重复字符串N次
- (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *String = [NSMutableString new];
    
    for (int i = 0; i < repeat; i++) {
        [String appendString:text];
    }
    
    return String;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.headImageArray.count;
    return 20;
    
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    
//    NSLog(@"self.heightAtIndexPath %@",height);
    if(height)
    {
        return height.floatValue;
    }
    else
    {
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return UITableViewAutomaticDimension;
//    
//}
//
//- (void)drawRect:(CGRect)rect {
//    if(image) { [image drawAtPoint:imagePoint];
//        self.image = nil;
//    }else {
//        [placeHolder drawAtPoint:imagePoint];
//    }
//    [text drawInRect:textRect withFont:fontlineBreakMode:UILineBreakModeTailTruncation];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *ident = @"hdcell";
    HdTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath]; ;
   
    if (!cell) {
        cell = [[HdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
//   停止滑动的时候异步加载图片
    if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
    {
     
    }
    cell.contextLabel.text = [self  getText:@"内容" withRepeat:(indexPath.row+2) * 5 + 1];;
    //开始异步加载图片
    cell.headImage.image = [UIImage imageNamed:self.headImageArray[1]];
    cell.detailImage.image = [UIImage imageNamed:self.imageArray[1]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
