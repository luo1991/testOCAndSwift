//
//  KVOViewController.m
//  testhd
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()

@property(nonatomic,strong)KVOViewController *kvoVC;
@property(nonatomic,strong)UILabel *contextLabel;
@property(nonatomic,assign)int number;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.number = 0 ;
    NSLog(@"hjfljsdk");
    //KVO （键值监听） Key-Value Observing
    // KVO 的实现依赖于OC强大的Runtime，
    // 原理：当观察某对象A时，KVO机制动态创建一个对象A当前类的子类，并为这个新的子类重写了被观察属性keyPath的setter方法。setter 方法随后负责通知观察对象属性的改变状况。
    
    
    //    KVC（键值编码） 即 Key-Value Coding
    
    self.kvoVC = [[KVOViewController alloc] init];
    /*1.注册对象myKVO为被观察者: option中，
     NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;
     NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”; */
//   [ self.kvoVC addObserver:self forKeyPath:@"kvovc" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [button setTitle:@"点击" forState:UIControlStateNormal];
     [button setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnMethod) forControlEvents:UIControlEventTouchUpInside];
    self.contextLabel = [[UILabel alloc] init];
    [self.view addSubview:self.contextLabel];
    [self.contextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(self.view.mas_top);
    }];
    
    self.contextLabel.textColor = [UIColor blueColor];
     self.contextLabel.backgroundColor = [UIColor yellowColor];
    
    // Do any additional setup after loading the view.
}
-(void)btnMethod{
    NSLog(@"点击");
    self.kvoVC.number = self.kvoVC.number+1;
    
}
/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    
//    NSLog(@"kvovc");
//    
//    if ([keyPath isEqualToString:@"kvovc"]&&object == self.kvoVC) {
//        self.contextLabel.text = [NSString stringWithFormat:@"当前kvovc值为%@",[change valueForKey:@"new"]];
//        
//        //change的使用：上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
//        NSLog(@"oldnum:%@   newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
//        
//    }
//}
-(void)dealloc{
    /* 3.移除KVO */
//
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [self removeObserver:self forKeyPath:@"kvovc" context:nil];
    // Dispose of any resources that can be recreated.
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
