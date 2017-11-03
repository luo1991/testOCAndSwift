//
//  AppDelegate.m
//  testhd
//
//  Created by admin on 17/9/18.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "AppDelegate.h"
#import "HdTabBarController.h"
#import "TestViewController.h"
@interface AppDelegate ()
@property(nonatomic)BOOL allowRotation;
@property (strong, nonatomic) UIView *lunchView;
@end

@implementation AppDelegate
@synthesize lunchView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    //add two Notification
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPVisionVideoEnterFullNotification:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPVisionVideoExitNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
    
    //    UINavigationController *navLogin = [[UINavigationController alloc] initWithRootViewController:];
    self.window.rootViewController = [[HdTabBarController alloc] init];
    //     self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[TestViewController alloc] init]];
    // Override point for customization after application launch.
    
    
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil ];
    //    lunchView = [storyboard instantiateViewControllerWithIdentifier:@"LaunchScreen"].view;
    //
    //    lunchView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
    //    [self.window addSubview:lunchView];
    //
    //    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    //    NSString *str = @"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=gif&step_word=&hs=2&pn=7&spn=0&di=8164921270&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=1129793834%2C3521576633&os=586678652%2C2505380938&simid=0%2C0&adpicid=0&lpn=0&ln=1979&fr=&fmq=1508812788947_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01fa64586d0e5fa801219c77e03671.gif&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bzv55s_z%26e3Bv54_z%26e3BvgAzdH3Fo56hAzdH3FZMThnNzIzNDQ%3D_z%26e3Bip4s%3FfotpviPw2j%3D5g&gsm=0&rpstart=0&rpnum=0";
    //    [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"3.jpg"]];
    //
    ////    imageV.image = [UIImage imageNamed:@"3.jpg"];
    //
    //    [lunchView addSubview:imageV];
    //
    //    [self.window bringSubviewToFront:lunchView];
    //
    //    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    //
    
    
    return YES;
}

-(void)removeLun
{
    [lunchView removeFromSuperview];
}

- (void)MPVisionVideoEnterFullNotification:(NSNotification*)notification {
    self.allowRotation = YES;
}

- (void)MPVisionVideoExitNotification:(NSNotification*)notification {
    self.allowRotation = NO;
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        
        return UIInterfaceOrientationMaskLandscapeRight ;
    }
    return UIInterfaceOrientationMaskPortrait;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
