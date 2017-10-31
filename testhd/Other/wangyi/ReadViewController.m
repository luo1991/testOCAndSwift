//
//  ReadViewController.m
//  testhd
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//


typedef NS_ENUM(NSInteger, BluetoothState){
    BluetoothStateDisconnect = 0,
    BluetoothStateScanSuccess,
    BluetoothStateScaning,
    BluetoothStateConnected,
    BluetoothStateConnecting
};

typedef NS_ENUM(NSInteger, BluetoothFailState){
    BluetoothFailStateUnExit = 0,
    BluetoothFailStateUnKnow,
    BluetoothFailStateByHW,
    BluetoothFailStateByOff,
    BluetoothFailStateUnauthorized,
    BluetoothFailStateByTimeout
};





#import "ReadViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>

@interface ReadViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong , nonatomic) CBCentralManager *manager;//中央设备

@property (assign , nonatomic) BluetoothFailState bluetoothFailState;
@property (assign , nonatomic) BluetoothState bluetoothState;


@property (strong , nonatomic) CBPeripheral * discoveredPeripheral;//周边设备

@property (strong , nonatomic) CBCharacteristic *characteristic1;//周边设备服务特性


@property(nonatomic,strong)UITableView *buleTableView;

@property(nonatomic,strong)NSMutableArray *bleViewPerArr;

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.buleTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.buleTableView];
    [self.buleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
        make.top.left.mas_equalTo(0);
    }];
    self.buleTableView.delegate = self;
    self.buleTableView.dataSource = self;
    
    // 实例化蓝牙
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    self.manager.delegate = self;
    self.bleViewPerArr = [NSMutableArray array];
    
   
    
    
    // Do any additional setup after loading the view.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *buleId = @"bulePer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buleId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:buleId];
    }
    // 将蓝牙外设对象接出，取出name，显示
    //蓝牙对象在下面环节会查找出来，被放进BleViewPerArr数组里面，是CBPeripheral对象
    CBPeripheral *per=(CBPeripheral *)_bleViewPerArr[indexPath.row];
    NSString *bleName=[per.name substringWithRange:NSMakeRange(0, 9)];
    cell.textLabel.text = bleName;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.bleViewPerArr.count;
}


#pragma mark 开始扫描
-(void)scan{
    // 判断状态开始扫描周围设备，第一个参数为空则会扫描所有的可连接设备，你可以
//    指定一个CBUUID对象，从而只扫描注册用指定服务的设备
    //scanForPeripheralsWithServices方法调用完后会调用代理CBCentralManagerDelegate的
    
    [self.manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@NO}];
    _bluetoothState = BluetoothStateScaning;
    [self.bleViewPerArr removeAllObjects];
    if (_bluetoothState == BluetoothFailStateByOff) {
        NSLog(@"检查您的蓝牙是否开启");
        
    }
    
}

#pragma mark 检测蓝牙状态
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"central.state %ld",(long)central.state);
    
    
    
    if (central.state != CBCentralManagerStatePoweredOn) {
        NSLog(@"fail, state is off .");
        switch (central.state) {
            case CBManagerStatePoweredOff:
                NSLog(@"连接失败了\n请您再检查一下您的手机蓝牙是否开启，\n然后再试一次");
                _bluetoothFailState = BluetoothFailStateByOff;
                break;
            case CBCentralManagerStateResetting:
                
                _bluetoothFailState = BluetoothFailStateByTimeout;
                break;
            case CBCentralManagerStateUnsupported:
               NSLog(@"检测到您的手机不支持蓝牙4.0\n所以建立不了连接.建议更换您\n的手机再试试。");
                _bluetoothFailState = BluetoothFailStateByHW;
                break;
            case CBCentralManagerStateUnauthorized:
                NSLog(@"连接失败了\n请您再检查一下您的手机蓝牙是否开启，\n然后再试一次");
                _bluetoothFailState = BluetoothFailStateUnauthorized;
                break;
            case CBCentralManagerStateUnknown:
                
                _bluetoothFailState = BluetoothFailStateUnKnow;
                break;
                
            default:
                break;
        }
        return;
    }
    _bluetoothFailState = BluetoothFailStateUnExit;
     [self scan];
    NSLog(@"已开启蓝牙");
}
#pragma  mark  发现设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral == nil ||peripheral.identifier == nil) {
        return;
    }
    NSString *pername = [NSString stringWithFormat:@"%@",peripheral.name];
    NSRange range = [pername rangeOfString:@""];
    //如果从搜索到的设备中找到指定设备名，和BleViewPerArr数组没有它的地址
    //加入BleViewPerArr数组
    if (range.location != NSNotFound &&[_bleViewPerArr containsObject:peripheral]==NO) {
       
    }
     [_bleViewPerArr addObject:peripheral];
    NSLog(@" 名字%@",peripheral.name);
    _bluetoothFailState = BluetoothFailStateUnExit;
    _bluetoothState = BluetoothStateScanSuccess;
    [_buleTableView reloadData];
    
}

#pragma  mark 连接设备
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBPeripheral *peripheral = (CBPeripheral *)_bleViewPerArr[indexPath.row];
    _discoveredPeripheral = peripheral;
    _discoveredPeripheral.delegate = self;
    [_manager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
    
}

#pragma  mark 连接成功 读取该设备信息
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"%@",peripheral);
    // 设置设备代理
    peripheral.delegate = self;
    // 大概获取服务和特征
    [peripheral discoverServices:nil];
    //或许只获取你的设备蓝牙服务的uuid数组，一个或者多个
    //[peripheral discoverServices:@[[CBUUID UUIDWithString:@""],[CBUUID UUIDWithString:@""]]];
    
    
    NSLog(@"Peripheral Connected");
    
    [_manager stopScan];
    
    NSLog(@"Scanning stopped");
    
    _bluetoothState=BluetoothStateConnected;
    

    
    
    
    
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
