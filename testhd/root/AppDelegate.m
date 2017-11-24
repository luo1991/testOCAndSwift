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
#import "LoginViewController.h"


@interface AppDelegate ()
@property(nonatomic)BOOL allowRotation;
@property (strong, nonatomic) UIView *lunchView;
@end

@implementation AppDelegate
@synthesize lunchView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //关闭设置为NO, 默认值为NO.
    [IQKeyboardManager sharedManager].enable= YES;
   [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPVisionVideoEnterFullNotification:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPVisionVideoExitNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
//    self.window.rootViewController = [[LoginViewController alloc] init];

    self.window.rootViewController = [[HdTabBarController alloc] init];
 
    
    
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
