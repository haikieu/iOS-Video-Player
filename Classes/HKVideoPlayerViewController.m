//
//  HKVideoPlayerViewController.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "HKVideoPlayerViewController.h"
#import "HKVideoPlayerThemeView.h"
#import "HKVideoPlayerCoreView.h"
#import "HKVideoPlayerException.h"

@interface HKVideoPlayerViewController ()

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic) NSTimeInterval autoHideInterval;
@property(nonatomic,assign)BOOL autoHide;
@property(nonatomic)UITapGestureRecognizer * singleTapGestureRecognizer;
@property(nonatomic)UITapGestureRecognizer * doubleTapGestureRecognizer;

@end

@implementation HKVideoPlayerViewController

@synthesize themeView=_themeView;
@synthesize coreView=_coreView;
@synthesize delegate=_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _baseFrame = frame;
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame theme:(HKVideoPlayerThemeView *)themeView
{
    self = [self initWithFrame:frame];
    if(self)
    {
        self.themeView = themeView;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = _baseFrame;
    self.view.backgroundColor = [UIColor blackColor];
    
    _coreView = [[HKVideoPlayerCoreView alloc] initWithPlayerVC:self];
    [self.view addSubview:_coreView];
    
    self.view.clipsToBounds = [_themeView themeViewNeedClipsToBounds];
    [self.view addSubview:_themeView];
    [self.view bringSubviewToFront:_themeView];
    
    [_themeView renderLoadingOnPlayerVC:self];
    [_themeView showLoadingAnimation];
    
    _singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    _singleTapGestureRecognizer.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:_singleTapGestureRecognizer];
    
    [self enableZooming:YES];
    
    [self handleUIApplicationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIDeviceOrientationDidChangeNotification:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_timer fire];
    
    [_themeView renderThemeOnPlayerVC:self];
    [self playerDidRenderView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET(nil);
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // You do not need this method if you are not supporting earlier iOS Versions
    return [[_themeView class] themeViewShouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [[_themeView class] themeViewSupportedInterfaceOrientations];
}

-(BOOL)shouldAutorotate
{
    return [[_themeView class] themeViewShouldAutorotate];
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

-(void)loadUrl:(NSURL *)url autoPlay:(BOOL)autoPlay
{
    [_themeView performSelectorOnMainThread:@selector(playerWillLoad) withObject:nil waitUntilDone:YES];
    _enableAutoPlay = autoPlay;
    [_coreView beginViewSessionWithUrl:url];
}

-(void)setPlayerTitle:(NSString *)string subTitle:(NSString *)subTitle
{
    _themeView.playerTitle = string;
    _themeView.playerSubTitle = subTitle;
}

#pragma mark - HKVideoPlayerCoreDelegate

-(void)handlePlay
{
    [_themeView performSelectorOnMainThread:@selector(playerWillPlay) withObject:nil waitUntilDone:YES];
    
    [_coreView handlePlay];
}

-(void)handleStop
{
    [_themeView performSelectorOnMainThread:@selector(playerWillStop) withObject:nil waitUntilDone:YES];
    
    [_coreView handleStop];
}
-(void)handlePause
{
    [_themeView performSelectorOnMainThread:@selector(playerWillPause) withObject:nil waitUntilDone:YES];
    
    [_coreView handlePause];
}
-(void)handleRewind:(float)speed
{
    [_themeView performSelectorOnMainThread:@selector(playerWillRewind:) withObject:[NSNumber numberWithFloat:speed] waitUntilDone:YES];
    
    [_coreView handleRewind:--_currentSpeed];
}
-(void)handleFastforward:(float)speed
{
    [_themeView performSelectorOnMainThread:@selector(playerWillFastforward:) withObject:[NSNumber numberWithFloat:speed] waitUntilDone:YES];
    
    [_coreView handleFastforward:++_currentSpeed];
}

-(void)handleCloseView
{
    [_themeView performSelectorOnMainThread:@selector(playerWillCloseView) withObject:nil waitUntilDone:YES];
    
    [_coreView handleCloseView];
}

-(void)handleResumeTime:(float)second
{
    [_themeView performSelectorOnMainThread:@selector(playerWillUpdateTime:) withObject:[NSNumber numberWithFloat:second] waitUntilDone:YES];
    
    [_coreView handleResumeTime:second];
}

-(void)handleEnterFullscreen
{
    [_themeView performSelectorOnMainThread:@selector(handleEnterFullscreen) withObject:nil waitUntilDone:YES];
    
    [_coreView handleEnterFullscreen];
}

-(void)handleExitFullscreen
{
    [_themeView performSelectorOnMainThread:@selector(handleExitFullscreen) withObject:nil waitUntilDone:YES];
    
    [_coreView handleExitFullscreen];
}

-(void)handleResizeWithFrame:(CGRect)frame
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_themeView playerWillResizeWithFrame:frame];
    });
    [_coreView handleResizeWithFrame:frame];
}

-(void)playbackScrub:(float)scrubTime
{
    [_coreView playbackBeginScrub];
    [_coreView playbackScrub:scrubTime];
}

-(void)playbackBeginScrub
{
    [_coreView playbackBeginScrub];
}

-(void)playbackEndScrub
{
    [_coreView playbackEndScrub];
}

-(void)playerDidBeginChangePlayback
{
    [_themeView performSelectorOnMainThread:@selector(playerDidBeginChangePlayback) withObject:nil waitUntilDone:NO];
}

-(void)playerDidEndChangePlayback
{
    [_themeView performSelectorOnMainThread:@selector(playerDidEndChangePlayback) withObject:nil waitUntilDone:NO];
}

#pragma mark - HKVideoPlayerEvent - Config

-(UIEdgeInsets)playerGetConfigInsets
{
    return [_themeView playerGetConfigInsets];
}

#pragma mark - HKVideoPlayerEvent - Post

-(void)playerDidRenderLoadingAnimation
{
    [_themeView performSelectorOnMainThread:@selector(playerDidRenderLoadingAnimation) withObject:nil waitUntilDone:NO];
}

-(void)playerDidRenderView
{
    [_themeView performSelectorOnMainThread:@selector(playerDidRenderView) withObject:nil waitUntilDone:NO];
}

-(void)playerDidPlay
{   _isPlaying = YES;
    _currentSpeed = _coreView.avPlayer.rate;
    [self syncMediaToControlCenter];
    [_themeView performSelectorOnMainThread:@selector(playerDidPlay) withObject:nil waitUntilDone:NO];
}

-(void)playerDidStop
{   _isPlaying = NO;
    _currentSpeed = _coreView.avPlayer.rate;
    [self syncMediaToControlCenter];
    [_themeView performSelectorOnMainThread:@selector(playerDidStop) withObject:nil waitUntilDone:NO];
}

-(void)playerDidPause
{   _isPlaying = NO;
    _currentSpeed = _coreView.avPlayer.rate;
    [self syncMediaToControlCenter];
    [_themeView performSelectorOnMainThread:@selector(playerDidPause) withObject:nil waitUntilDone:NO];
}

-(void)playerDidFastforward:(float)speed
{
    _currentSpeed = _coreView.avPlayer.rate;
    [self syncMediaToControlCenter];
    [_themeView performSelectorOnMainThread:@selector(playerDidFastforward:) withObject:[NSNumber numberWithFloat:speed] waitUntilDone:YES];
}
-(void)playerDidRewind:(float)speed
{
    _currentSpeed = _coreView.avPlayer.rate;
    [self syncMediaToControlCenter];
    [_themeView performSelectorOnMainThread:@selector(playerDidRewind:) withObject:[NSNumber numberWithFloat:speed] waitUntilDone:YES];
}

-(void)playerDidLoad
{
    _currentSpeed = _coreView.avPlayer.rate;
    [_themeView performSelectorOnMainThread:@selector(playerDidLoad) withObject:nil waitUntilDone:NO];
    if(_enableAutoPlay)
    {
        [self handlePlay];
    }
    if(_enableSyncMedia)
    {
        [self syncMediaToControlCenter];
    }
}

-(void)playerDidFailure
{
    _currentSpeed = _coreView.avPlayer.rate;
    [_themeView performSelectorOnMainThread:@selector(playerDidFailure) withObject:nil waitUntilDone:NO];
}

-(void)playerDidReady
{
    _currentSpeed = _coreView.avPlayer.rate;
    [_themeView performSelectorOnMainThread:@selector(playerDidReady) withObject:nil waitUntilDone:NO];
}

-(void)playerDidExitFullscreen
{
    _currentSpeed = _coreView.avPlayer.rate;
    _enableFullScreen = NO;
    [_themeView performSelectorOnMainThread:@selector(playerDidExitFullscreen) withObject:nil waitUntilDone:NO];
}

-(void)playerDidEnterFullscreen
{
    _currentSpeed = _coreView.avPlayer.rate;
    _enableFullScreen = YES;
    [_themeView performSelectorOnMainThread:@selector(playerDidEnterFullscreen) withObject:nil waitUntilDone:NO];
}

-(void)playerDidCloseView
{
    _currentSpeed = _coreView.avPlayer.rate;
    [_themeView performSelectorOnMainThread:@selector(playerDidCloseView) withObject:nil waitUntilDone:NO];
    [_delegate videoPlayer:self didCloseView:self.view];
}

-(void)playerDidUpdateTime:(float)second
{
    _currentSpeed = _coreView.avPlayer.rate;
    [_themeView performSelectorOnMainThread:@selector(playerDidUpdateTime:) withObject:[NSNumber numberWithFloat:second] waitUntilDone:YES];
}

-(void)playerDidUpdateCurrentTime:(float)currentTime remainTime:(float)remainTime durationTime:(float)durationTime
{
    _currentSpeed = _coreView.avPlayer.rate;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_themeView playerDidUpdateCurrentTime:currentTime remainTime:remainTime durationTime:durationTime];
    });
}

-(void)playerDidResizeWithFrame:(CGRect)frame
{
    _currentSpeed = _coreView.avPlayer.rate;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_themeView playerDidResizeWithFrame:frame];
    });
}

#pragma mark - Handle draggable

-(void)enableDragging
{
    if(DEVICE_IS_IPHONE())
        return;
    [super enableDragging];
}

-(void)setDraggable:(BOOL)draggable
{
    if(DEVICE_IS_IPHONE())
        return;
    [super setDraggable:draggable];
}
BOOL firstTime=YES;
-(void)autoHideThemeView:(BOOL)enable afterTime:(float)second
{
    _autoHide = enable;
    _autoHideInterval = second;
    
    if(_autoHide)
    {
        [_timer invalidate];
        firstTime=YES;
        _timer = [NSTimer scheduledTimerWithTimeInterval:second target:self selector:@selector(autoHideTheme) userInfo:nil repeats:YES];
    }
    else
    {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)autoHideTheme
{
    if(firstTime)
    {
        firstTime = NO;
        return;
    }
    
    if(self.themeView.hidden)
        return;
    
    [_themeView hideThemeView:YES];
    [_timer invalidate];
}

#pragma mark - override draggable

-(void)handlePan:(UIPanGestureRecognizer*)sender
{
    [super handlePan:sender];
}

#pragma mark - Handle touches

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches objectEnumerator] nextObject];
    BOOL shouldDraggable = [_themeView themeViewAllowDraggableAtPosition:[touch locationInView:_themeView]];
    [self setDraggable:shouldDraggable];
    
//    if(_themeView.hidden)
//    {
//        [_themeView showThemeView:YES];
//        [self autoHideThemeView:_autoHide afterTime:_autoHideInterval];
//    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
 
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//    self.view.layer.anchorPoint = CGPointMake(0.5,0.5);
}

#pragma mark - Gesture implementation

-(void)enableZooming:(BOOL)enable
{
    _doubleTapGestureRecognizer.enabled = enable;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [self.view addGestureRecognizer:_doubleTapGestureRecognizer];
    });
    
    if(enable)
    {
        [_singleTapGestureRecognizer requireGestureRecognizerToFail:_doubleTapGestureRecognizer];
    }
    else
    {
        [_singleTapGestureRecognizer requireGestureRecognizerToFail:nil];
    }
}

-(void)handleSingleTap:(id)sender
{
    //    UITapGestureRecognizer * gesture = sender;
    //    BOOL shouldDraggable = [_themeView themeViewAllowDraggableAtPosition:[gesture locationInView:_themeView]];
    //    [self setDraggable:shouldDraggable];
    //
    if(_themeView.hidden)
    {
        [_themeView showThemeView:YES];
        [self autoHideThemeView:_autoHide afterTime:_autoHideInterval];
    }
}

-(void)handleDoubleTap:(id)sender
{
    if ([_coreView getVideoFillMode] == AVLayerVideoGravityResizeAspect)
        [_coreView setVideoFillMode:AVLayerVideoGravityResizeAspectFill];
    else
        [_coreView setVideoFillMode:AVLayerVideoGravityResizeAspect];
}


#pragma mark - Handle motions

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(_themeView.hidden)
    {
        [_themeView showThemeView:YES];
        [self autoHideThemeView:_autoHide afterTime:_autoHideInterval];
    }
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}
-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

#pragma mark - Handle remote control

-(void)syncMediaToControlCenter:(BOOL)enable
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _enableSyncMedia=enable;
        [self syncFunctionalityToControlCenter];
        [self syncMediaToControlCenter];
    });
}

-(void)syncFunctionalityToControlCenter
{
    if(_enableSyncMedia)
    {
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        if(![self isFirstResponder])
            [self becomeFirstResponder];
    }
    else
    {
        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    }

}

-(void)syncMediaToControlCenter
{
    if(_enableSyncMedia)
    {
            NSArray *keys = [NSArray arrayWithObjects:
                             MPMediaItemPropertyMediaType,
                             MPMediaItemPropertyTitle,
                             MPMediaItemPropertyArtist,
                             MPMediaItemPropertyPlaybackDuration,
                             MPNowPlayingInfoPropertyPlaybackRate,
                             MPNowPlayingInfoPropertyElapsedPlaybackTime,
                             nil];
            // NSInteger durationSeconds = ceilf(CMTimeGetSeconds(_coreView.avPlayer.currentItem.duration));
            NSArray *values = [NSArray arrayWithObjects:
                               [NSNumber numberWithInt:MPMediaTypeMovie],
                               _themeView.playerTitle,
                               _themeView.playerSubTitle,
                               [NSNumber numberWithDouble:[_coreView getDurationTime]],
                               [NSNumber numberWithDouble:_coreView.avPlayer.rate],
                               [NSNumber numberWithDouble:[_coreView getCurrentTime]],
                               nil];
            
            NSDictionary *mediaInfo = [NSDictionary dictionaryWithObjects:values forKeys:keys];
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:mediaInfo];

    }
    else
    {
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:[NSDictionary new]];
    }

}

- (void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlPlay:
                [self handlePlay];
                break;
            case UIEventSubtypeRemoteControlPause:
                [self handlePause];
                break;
            case UIEventSubtypeRemoteControlStop:
                [self handleStop];
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if(_isPlaying)
                   [self handlePause];
                else
                    [self handlePlay];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                    [self handleRewind:0];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                    [self handleFastforward:0];
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                
                break;
                
            default:
                break;
        }
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self syncMediaToControlCenter];
        });
        
    }
}


#pragma mark - Handle Device Orientation

-(void)UIDeviceOrientationDidChangeNotification:(NSNotification*)notification
{
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation interfaceOrientation =(UIInterfaceOrientation) deviceOrientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            //TODO - do any extra stuffs
            break;
        case UIDeviceOrientationFaceDown:
            //TODO - do any extra stuffs
            break;
        case UIDeviceOrientationUnknown:
            //TODO - do any extra stuffs
            break;
        case UIDeviceOrientationPortrait:
            //TODO - do any extra stuffs
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            //TODO - do any extra stuffs
            break;
        case UIDeviceOrientationLandscapeLeft:
            //TODO - do any extra stuffs
            break;
        case UIDeviceOrientationLandscapeRight:
            //TODO - do any extra stuffs
            break;
    }
    
    if([[_themeView class] themeViewShouldAutorotateToInterfaceOrientation:interfaceOrientation])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_themeView playerWillChangeOrientation:interfaceOrientation];
        });
    }
}

#pragma mark - UIApplication notification handlers

-(void)handleUIApplicationNotifications
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(UIApplicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    [center addObserver:self selector:@selector(UIApplicationWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    [center addObserver:self selector:@selector(UIApplicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
    [center addObserver:self selector:@selector(UIApplicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
}

-(void)UIApplicationDidEnterBackgroundNotification:(NSNotification*)notification
{
    
}

-(void)UIApplicationWillEnterForegroundNotification:(NSNotification*)notification
{
    [self syncFunctionalityToControlCenter];
}

-(void)UIApplicationDidBecomeActiveNotification:(NSNotification*)notification
{
    [self syncFunctionalityToControlCenter];
}

-(void)UIApplicationWillResignActiveNotification:(NSNotification*)notification
{
    
}

-(void)UIApplicationLaunchOptionsURLKey:(NSNotification*)notification
{
    
}

-(void)UIApplicationLaunchOptionsRemoteNotificationKey:(NSNotification*)notification
{
    
}

-(void)UIApplicationLaunchOptionsLocalNotificationKey:(NSNotification*)notification
{
    
}

-(void)UIApplicationLaunchOptionsBluetoothCentralsKey:(NSNotification*)notification
{
    
}

-(void)UIApplicationLaunchOptionsBluetoothPeripheralsKey:(NSNotification*)notification
{
    
}

-(void)UIApplicationUserDidTakeScreenshotNotification:(NSNotification*)notification
{
    
}

@end
