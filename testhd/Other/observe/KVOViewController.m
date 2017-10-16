//
//  KVOViewController.m
//  testhd
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //KVO （键值监听） Key-Value Observing
    // KVO 的实现依赖于OC强大的Runtime，
    // 原理：当观察某对象A时，KVO机制动态创建一个对象A当前类的子类，并为这个新的子类重写了被观察属性keyPath的setter方法。setter 方法随后负责通知观察对象属性的改变状况。
    
    
    //    KVC（键值编码） 即 Key-Value Coding
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
