//
//  HKVideoPlayerViewController.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerViewController.h"
#import "HKVideoPlayerThemeView.h"
#import "HKVideoPlayerCoreView.h"
@interface HKVideoPlayerViewController ()

@end

@implementation HKVideoPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_themeView];
    [self.view bringSubviewToFront:_themeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - HKVideoPlayerCoreDelegate

-(void)handlePlay
{
    [_coreView handlePlay];
}

-(void)handleStop
{
    [_coreView handleStop];
}
-(void)handlePause
{
    [_coreView handlePause];
}
-(void)handleRewind:(float)speed
{
    [_coreView handleRewind:speed];
}
-(void)handleFastforward:(float)speed
{
    [_coreView handleFastforward:speed];
}

-(void)handleCloseView
{
    [_coreView handleCloseView];
}

-(void)handleResumePosition:(float)position
{
    [_coreView handleResumePosition:position];
}

#pragma mark - HKVideoPlayerCore

-(void)playerDidPlay
{
    [_themeView playerDidPlay];
}

-(void)playerDidStop
{
    [_themeView playerDidStop];
}

-(void)playerDidPause
{
    [_themeView playerDidPause];
}

-(void)playerDidFailure
{
    [_themeView playerDidFailure];
}

-(void)playerDidReady
{
    [_themeView playerDidReady];
}

-(void)playerDidExitFullscreen
{
    [_themeView playerDidExitFullscreen];
}

-(void)playerDidEnterFullscreen
{
    [_themeView playerDidEnterFullscreen];
}

-(void)playerDidCloseView
{
    [_themeView playerDidCloseView];
    
    [_delegate videoPlayer:self didCloseView:self.view];
}


@end
