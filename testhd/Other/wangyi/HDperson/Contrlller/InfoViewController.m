//
//  InfoViewController.m
//  testhd
//
//  Created by admin on 2017/10/23.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "InfoViewController.h"
#import "PersonTableViewCell.h"
@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITableView *infoTableView;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray= @[@"个人信息",@"通讯录",@"我的考勤",@"我的单据",@"我的审批",@"修改密码",@"考勤说明",];
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:self.infoTableView];
    
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.backgroundColor = [UIColor lightGrayColor];
    
    [self.infoTableView registerNib:[UINib nibWithNibName:@"PersonTableViewCell" bundle:nil] forCellReuseIdentifier:@"personCell"];
    
    self.infoTableView.tableHeaderView = [self setUPHeaderView];
    self.infoTableView.tableFooterView= [self setUpFooterView];
    
    
    // Do any additional setup after loading the view.
}

-(UIView *)setUPHeaderView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, HDValueFor6P6Default(130, 120, 100))];
    headView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.7];
    // 头像
    UIImageView *headImage = [[UIImageView alloc] init];
    [headView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.mas_equalTo(HDValueFor6P6Default(40, 30, 20));
    }];
    headImage.layer.cornerRadius= 30;
    headImage.layer.masksToBounds = YES;
    headImage.image = [UIImage imageNamed:@"3.jpg"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    [headImage addGestureRecognizer:tap];
    headImage.userInteractionEnabled = YES;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImage.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.top.mas_equalTo(headImage.mas_top);
    }];
    nameLabel.text=@"范晓磊";
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textColor= [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *companyLabel = [[UILabel alloc] init];
    [headView addSubview:companyLabel];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.top.equalTo(headImage.mas_top);
    }];
    companyLabel.text=@"欢动科技";
    companyLabel.textColor= [UIColor whiteColor];
    companyLabel.textAlignment = NSTextAlignmentLeft;


    UILabel *departmentLabel = [[UILabel alloc] init];
    [headView addSubview:departmentLabel];
    [departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headImage.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.top.equalTo(nameLabel.mas_bottom);
    }];
    departmentLabel.text=@"IT服务中心产品部";
    departmentLabel.textColor= [UIColor whiteColor];
    departmentLabel.textAlignment = NSTextAlignmentLeft;

    UILabel *postLabel = [[UILabel alloc] init];
    [headView addSubview:postLabel];
    [postLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(departmentLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.top.mas_equalTo(nameLabel.mas_bottom);
    }];
    postLabel.text=@"项目经理";
    postLabel.textColor= [UIColor whiteColor];
    postLabel.textAlignment = NSTextAlignmentLeft;
    
    
    return headView;
}

-(UIView *)setUpFooterView{
    UIView  *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, 80)];
    UIButton *logoutBtn = [[UIButton alloc] init];
    [footerView addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footerView);
        make.size.mas_equalTo(CGSizeMake(HDValueFor6P6Default(300, 280, 260), 40));
        make.bottom.mas_equalTo(footerView.mas_bottom).with.offset(-20);
    }];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutMethod) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.7];
    
   
    return footerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"personCell";
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.titleImage.image = [UIImage imageNamed:@"tabbar_person"];
    cell.titleLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tapMethod:(UITapGestureRecognizer *)tap{
    NSLog(@"更新头像");
    
    UIActionSheet* sheet;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }else{
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 100;
    [sheet showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag ==100) {
        NSUInteger sourceType;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    return;
            }
        }else{
            
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    break;
                default:
                    return;
            }
            
        }
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [self fixOrientation:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //   NSInteger headIcon = [user integerForKey:@"headIcon"];
    
    
    
    // 保存沙盒
    
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/flower.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    //写入plist文件
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        });
    }];
    
    
//    [MBProgressHUD showMessage:@"正在上传..." ];
  
    
    
    
    NSData* data = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"], 0.01);
    
    NSString *pictureDataString=[data base64Encoding];
    //    NSString *pictureDataString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir)
    {
        NSLog(@"Documents 目录未找到");
    }
    
    
    
    ////部门id ＝ 部门名
    NSString *filePath = [docDir stringByAppendingPathComponent:@"test.png"];
    [data writeToFile:filePath atomically:YES];
    NSLog(@"Documents 目录：%@",filePath);
    
    
    NSString *imageString = [data base64EncodedStringWithOptions:0];
    
    
    // portrait
    NSDictionary *dic = @{@"portrait":imageString};
    
    //    NSLog(@"头像请求的参数  %@",dic);
    NSLog(@"头像请求的参数  %@",data);
    
//    [HttpToolRequest postWithUrl:headerIconURL params:dic success:^(id responseObject) {
//        //        NSDictionary *dic = [responseObject firstObject];
//
//        if (DEBUG ) {
//            NSLog(@"信息：%@",responseObject);
//        }
//        [MBProgressHUD hideHUD];
//
//        if ([responseObject[@"response"] isEqualToString:@"success"]) {
//            [self showAlertWithMessage:@"头像上传成功"];
//            [user  setInteger:1 forKey:@"headIcon"];
//            [user synchronize];
//
//            _headerImage.image = image;
//        }else{
//            [self showAlertWithMessage:responseObject[@"message"]];
//        }
//
//
//
//    } fail:^(NSError *error) {
//
//        [MBProgressHUD hideHUDForView:self.view];
//
//
//    }];
//
}
//修正照片方向(手机转90度方向拍照)

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark  退出登录
-(void)logoutMethod{
    NSLog(@"退出登录");
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
