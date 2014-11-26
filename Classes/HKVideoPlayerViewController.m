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
#import "HKVideoPlayerException.h"

@interface HKVideoPlayerViewController ()

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic) NSTimeInterval autoHideInterval;
@property(nonatomic,assign)BOOL autoHide;

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
    
    [_themeView renderThemeOnPlayerVC:self];
    [self.view addSubview:_themeView];
    [self.view bringSubviewToFront:_themeView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIDeviceOrientationDidChangeNotification:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    self.view.clipsToBounds = [_themeView playerShouldClipsToBounds];
    [self playerDidRenderView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    if(![self isFirstResponder])
        [self becomeFirstResponder];
    
    [_timer fire];
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
    _autoPlay = autoPlay;
    [_coreView beginViewSessionWithUrl:url];
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
    
    [_coreView handleRewind:speed];
}
-(void)handleFastforward:(float)speed
{
    [_themeView performSelectorOnMainThread:@selector(playerWillFastforward:) withObject:[NSNumber numberWithFloat:speed] waitUntilDone:YES];
    
    [_coreView handleFastforward:speed];
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

#pragma mark - HKVideoPlayerEvent - Config

-(UIEdgeInsets)playerGetConfigInsets
{
    return [_themeView playerGetConfigInsets];
}

#pragma mark - HKVideoPlayerEvent - Post

-(void)playerDidRenderView
{
    _themeView.hidden = YES;
    [_themeView performSelectorOnMainThread:@selector(playerDidRenderView) withObject:nil waitUntilDone:NO];
}

-(void)playerDidPlay
{   _isPlay = YES;
    [_themeView performSelectorOnMainThread:@selector(playerDidPlay) withObject:nil waitUntilDone:NO];
}

-(void)playerDidStop
{   _isPlay = NO;
    [_themeView performSelectorOnMainThread:@selector(playerDidStop) withObject:nil waitUntilDone:NO];
}

-(void)playerDidPause
{   _isPlay = NO;
    [_themeView performSelectorOnMainThread:@selector(playerDidPause) withObject:nil waitUntilDone:NO];
}

-(void)playerDidLoad
{
    [_themeView performSelectorOnMainThread:@selector(playerDidLoad) withObject:nil waitUntilDone:NO];
    if(_autoPlay)
    {
        [self handlePlay];
    }
}

-(void)playerDidFailure
{
    [_themeView performSelectorOnMainThread:@selector(playerDidFailure) withObject:nil waitUntilDone:NO];
}

-(void)playerDidReady
{
    [_themeView performSelectorOnMainThread:@selector(playerDidReady) withObject:nil waitUntilDone:NO];
}

-(void)playerDidExitFullscreen
{
    _fullScreen = NO;
    [_themeView performSelectorOnMainThread:@selector(playerDidExitFullscreen) withObject:nil waitUntilDone:NO];
}

-(void)playerDidEnterFullscreen
{
    _fullScreen = YES;
    [_themeView performSelectorOnMainThread:@selector(playerDidEnterFullscreen) withObject:nil waitUntilDone:NO];
}

-(void)playerDidCloseView
{
    [_themeView performSelectorOnMainThread:@selector(playerDidCloseView) withObject:nil waitUntilDone:NO];
    [_delegate videoPlayer:self didCloseView:self.view];
}

-(void)playerDidUpdateTime:(float)second
{
    [_themeView performSelectorOnMainThread:@selector(playerDidUpdateTime:) withObject:[NSNumber numberWithFloat:second] waitUntilDone:YES];
}

-(void)playerDidUpdateCurrentTime:(float)currentTime remainTime:(float)remainTime durationTime:(float)durationTime
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_themeView playerDidUpdateCurrentTime:currentTime remainTime:remainTime durationTime:durationTime];
    });
}

-(void)playerDidFastforward:(float)speed
{
    [_themeView performSelectorOnMainThread:@selector(playerDidFastforward:) withObject:[NSNumber numberWithFloat:speed] waitUntilDone:YES];
}
-(void)playerDidRewind:(float)speed
{
    [_themeView performSelectorOnMainThread:@selector(playerDidRewind:) withObject:[NSNumber numberWithFloat:speed] waitUntilDone:YES];
}

-(void)playerDidResizeWithFrame:(CGRect)frame
{
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

-(void)handlePan:(UIPanGestureRecognizer *)sender
{
    [super handlePan:sender];
}

#pragma mark - Handle touches

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[touches objectEnumerator] nextObject];
    BOOL shouldDraggable = [_themeView playerShouldDraggableAtPosition:[touch locationInView:_themeView]];
    [self setDraggable:shouldDraggable];
    
    if(_themeView.hidden)
    {
        [_themeView showThemeView:YES];
        [self autoHideThemeView:_autoHide afterTime:_autoHideInterval];
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
 
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.layer.anchorPoint = CGPointMake(0.5,0.5);
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
                if(_isPlay)
                   [self handlePause];
                else
                    [self handlePlay];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - Handle Device Orientation

-(void)UIDeviceOrientationDidChangeNotification:(NSNotification*)notification
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    switch (orientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
            
            //TODO
            
            break;
        case UIDeviceOrientationPortrait:
            
            HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
            
            break;
        case UIDeviceOrientationPortraitUpsideDown:

            HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
            
            break;
        case UIDeviceOrientationLandscapeLeft:

            HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
            
            break;
        case UIDeviceOrientationLandscapeRight:

            HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
            
            break;
    }

}

@end
