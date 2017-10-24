//
//  ScienceViewController.m
//  testhd
//
//  Created by admin on 2017/10/19.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "ScienceViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ScienceViewController ()
@property(nonatomic,strong)MPMoviePlayerController *playerVC;
@end

@implementation ScienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
//    获得视频播放的URL
      NSString* moviePath=[[NSBundle mainBundle]pathForResource:@"logovideo" ofType:@"mp4"];
    NSURL *videoUrl = [NSURL fileURLWithPath:moviePath];
    self.playerVC = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
    self.playerVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetWidth(self.view.frame)*(9.0/16.0));
//    播放本地视频时需要这句
    self.playerVC.movieSourceType = MPMovieSourceTypeFile;
    self.playerVC.shouldAutoplay = YES;// 是否自动播放
    self.playerVC.scalingMode = MPMovieScalingModeAspectFill;
    self.playerVC.controlStyle = MPMovieControlStyleDefault;
    
//    self.playerVC.controlStyle=MPMovieSourceTypeStreaming;//直播
    
    [self.view addSubview:self.playerVC.view];
    [self.playerVC prepareToPlay]; // 缓存
    [self.playerVC play];// 可加 可不加
    
    //监听当前视频播放状态
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
 
    //监听视频播放结束
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //全屏播放
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterFullscreen) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    
    
    

    
    // Do any additional setup after loading the view.
}
-(void)endPlay
{
    NSLog(@"播放结束");
}

-(void)loadStateDidChange:(NSNotification*)sender
{
    switch (self.playerVC.loadState) {
        case MPMovieLoadStatePlayable:
        {
            NSLog(@"加载完成,可以播放");
        }
            break;
        case MPMovieLoadStatePlaythroughOK:
        {
            NSLog(@"缓冲完成，可以连续播放");
        }
            break;
        case MPMovieLoadStateStalled:
        {
            NSLog(@"缓冲中");
        }
            break;
        case MPMovieLoadStateUnknown:
        {
            NSLog(@"未知状态");
        }
            break;
        default:
            break;
    }
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
