//
//  HKVideoPlayerCoreView.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerCoreView.h"
#import "HKVideoPlayerViewController.h"
#import "HKVideoPlayerException.h"

#define DEFAULT_COLOR_BACKGROUND [UIColor blackColor]

@interface HKVideoPlayerCoreView ()

@property(nonatomic) id playerTimeObserver;
// Scrubbing
@property (nonatomic, assign, getter = isScrubbing) BOOL scrubbing;
@property (nonatomic, assign) float restoreAfterScrubbingRate;

@end

@implementation HKVideoPlayerCoreView

@synthesize avAsset=_avAsset;
@synthesize avPlayer=_avPlayer;
@synthesize playerViewController=_playerViewController;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCore];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initCore];
    }
    return self;
}

-(instancetype)initWithPlayerVC:(HKVideoPlayerViewController *)playerVC
{
    self = [self initWithFrame:playerVC.view.bounds];
    if (self) {
        // Initialization code
        _playerViewController = playerVC;
        [self applyPlayerEdgeInsets:[playerVC playerGetConfigInsets]];
    }
    return self;
}

-(void)applyPlayerEdgeInsets:(UIEdgeInsets)insets
{
    if(!UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero))
    {
        CGSize newSize  =CGSizeMake(self.bounds.size.width-insets.left-insets.right, self.bounds.size.height-insets.top-insets.bottom);
        self.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
        //            self.center = playerVC.view.center;
        CGFloat adjustVerticalInset = insets.top-insets.bottom;
        if(adjustVerticalInset>0)
        {
            self.center = CGPointMake(self.center.x,self.center.y + fabs(adjustVerticalInset/2));
        }
        else if(adjustVerticalInset<0)
        {
            self.center = CGPointMake(self.center.x,self.center.y - fabs(adjustVerticalInset/2));
        }
        
        CGFloat adjustHorizontalInset = insets.left-insets.right;
        if(adjustHorizontalInset>0)
        {
            self.center = CGPointMake(self.center.x + fabs(adjustHorizontalInset/2),self.center.y);
        }
        else if(adjustHorizontalInset<0)
        {
            self.center = CGPointMake(self.center.x - fabs(adjustHorizontalInset/2),self.center.y);
        }
    }else
    {
//        self.center=_playerViewController.view.center;
//        self.bounds=_playerViewController.view.bounds;
    }
}

-(void)initCore
{
//    self.backgroundColor = DEFAULT_COLOR_BACKGROUND;
    
    
}

#pragma mark - Scrubb

-(double)getDurationTime
{
    double durationSeconds = ceil(CMTimeGetSeconds(self.player.currentItem.duration));
    return durationSeconds;
}

-(NSString *)getDurationTimeString
{
    NSInteger durationSeconds = ceilf(CMTimeGetSeconds(self.player.currentItem.duration));
    NSInteger seconds = durationSeconds % 60;
    NSInteger minutes = durationSeconds / 60;
    NSInteger hours = minutes / 60;
    
    NSString * durationTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    return durationTime;
}

-(double) getRemainTime
{
    return [self getDurationTime] - [self getCurrentTime];
}

-(NSString *)getRemainTimeString
{
    NSInteger currentSeconds = ceilf(CMTimeGetSeconds(self.avPlayer.currentTime));

    NSInteger duration = ceilf(CMTimeGetSeconds(self.avPlayer.currentItem.duration));
    NSInteger remainSeconds = duration-currentSeconds;
    NSInteger durationSeconds = remainSeconds % 60;
    NSInteger durationMinutes = remainSeconds / 60;
    NSInteger durationHours = durationMinutes / 60;
    
    NSString *remainTime = [NSString stringWithFormat:@"-%02ld:%02ld:%02ld", (long)durationHours, (long)durationMinutes, (long)durationSeconds];
    return remainTime;
}

-(double)getCurrentTime
{
    return ceil(CMTimeGetSeconds(self.avPlayer.currentTime));
}

-(NSString *)getCurrentTimeString
{
    NSInteger currentSeconds = ceilf(CMTimeGetSeconds(self.avPlayer.currentTime));
    NSInteger seconds = currentSeconds % 60;
    NSInteger minutes = currentSeconds / 60;
    NSInteger hours = minutes / 60;
    
    NSString * currentTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    return currentTime;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (Class)layerClass
{
	return [AVPlayerLayer class];
}

- (AVPlayer*)player
{
	return [(AVPlayerLayer*)[self layer] player];
}

- (void)setPlayer:(AVPlayer*)player
{
    _avPlayer = player;
	[(AVPlayerLayer*)[self layer] setPlayer:_avPlayer];
}

/* Specifies how the video is displayed within a player layer’s bounds.
 (AVLayerVideoGravityResizeAspect is default) */
- (void)setVideoFillMode:(NSString *)fillMode
{
    [UIView animateWithDuration:0 animations:^{
        //TODO
    } completion:^(BOOL finished) {
        AVPlayerLayer *playerLayer = (AVPlayerLayer*)[self layer];
        playerLayer.videoGravity = fillMode;
    }];
}
- (NSString * )getVideoFillMode
{
    AVPlayerLayer *playerLayer = (AVPlayerLayer*)[self layer];
    return playerLayer.videoGravity;
}

NSTimer *avStatusTimer;

-(void)monitoringAVStatus
{
    NSError *error = nil;
    AVKeyValueStatus avStatus = [_avAsset statusOfValueForKey:@"tracks" error:&error];
    switch (avStatus) {
        case AVKeyValueStatusUnknown:
            
            //TODO
            
            break;
        case AVKeyValueStatusLoading:
            
            //TODO
            _avStatus = avStatus;
            
            break;
            
        case AVKeyValueStatusFailed:
        case AVKeyValueStatusCancelled:
        case AVKeyValueStatusLoaded:
            
            //TODO - do nothing
            
            break;
    }
}

-(void)clearViewSession
{
    [_avAsset cancelLoading];
    //TODO - remove other obersevers of player, playerItem, playerAsset
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)beginViewSessionWithUrl:(NSURL *)url
{
    self.avAsset = [AVAsset assetWithURL:url];
    
    avStatusTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(monitoringAVStatus) userInfo:nil repeats:YES];
    [avStatusTimer fire];
    
    [_avAsset loadValuesAsynchronouslyForKeys:@[@"tracks",@"lyrics",@"creationDate",@"commonMetadata",@"availableMetadataFormats"] completionHandler:^{
        
        [avStatusTimer invalidate];
        
        NSError *error = nil;
        _avStatus = [_avAsset statusOfValueForKey:@"tracks" error:&error];
        
        if(error)
        {
            [_playerViewController playerDidFailure];
            return;
        }

        switch (_avStatus) {
                
            case AVKeyValueStatusUnknown:
                
                //TODO - do nothing
                
                break;
            case AVKeyValueStatusLoading:
                
                //TODO - do nothing
                
                break;
                
            case AVKeyValueStatusFailed:
                
                [_playerViewController playerDidFailure];
                
                break;
            case AVKeyValueStatusCancelled:
                
                //TODO
                
                break;
            
            case AVKeyValueStatusLoaded:
                
                _avPlayer = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:_avAsset]];
                [self setupObservingPlayer];
                [self setPlayer:_avPlayer];
                [_playerViewController setCurrentSpeed:self.avPlayer.rate];
                [_playerViewController playerDidLoad];
                [self syncScrobber];
                
                break;
        }
        
    }];
    
}

static NSString * kPlayerStatus = @"status";
static NSString * kPlayerError = @"error";
static NSString * kPlayerRate = @"rate";
static NSString * kPlayerCurrentTime = @"currentTime";
static NSString * kPlayerVolume = @"volume";
static NSString * kPlayerMuted = @"muted";
static NSString * kPlayerCurrentTIme = @"currentTime";

-(void)setupObservingPlayer
{
    AVPlayer *avPlayer = _avPlayer;
    [avPlayer addObserver:self forKeyPath:kPlayerStatus options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerError options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerRate options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerCurrentTime options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerVolume options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerMuted options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerCurrentTIme options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    
}

static NSString * kItemStatus = @"status";
static NSString * kItemError = @"error";
static NSString * kItemDuration = @"duration";
static NSString * kItemTracks = @"tracks";
static NSString * kItemAsset = @"asset";


-(void)setupObservingPlayerItem
{
    AVPlayerItem *avItem = _avPlayer.currentItem;
}

-(void)setupObservingPlayerAsset
{
    AVAsset *avAsset = _avPlayer.currentItem.asset;
}

-(void)setupNotificationOfPlayerItem
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemTimeJumpedNotification:) name:AVPlayerItemTimeJumpedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemDidPlayToEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemFailedToPlayToEndTimeNotification:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemPlaybackStalledNotification:) name:AVPlayerItemPlaybackStalledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemNewAccessLogEntryNotification:) name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemNewErrorLogEntryNotification:) name:AVPlayerItemNewErrorLogEntryNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemFailedToPlayToEndTimeErrorKey:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:nil];
}
//    AVPlayerItemTimeJumpedNotification
-(void)AVPlayerItemTimeJumpedNotification:(NSNotification*) notification
{
    
}
//    AVPlayerItemDidPlayToEndTimeNotification
-(void)AVPlayerItemDidPlayToEndTimeNotification:(NSNotification*) notification
{
    
}
//    AVPlayerItemFailedToPlayToEndTimeNotification
-(void)AVPlayerItemFailedToPlayToEndTimeNotification:(NSNotification*) notification
{
    
}
//    // media did not arrive in time to continue playback
-(void)AVPlayerItemPlaybackStalledNotification:(NSNotification*) notification
{
    
}
//    // a new access log entry has been added
-(void)AVPlayerItemNewAccessLogEntryNotification:(NSNotification*) notification
{
    
}
//    // a new error log entry has been added
-(void)AVPlayerItemNewErrorLogEntryNotification:(NSNotification*) notification
{
    
}
//    // notification userInfo key    type
//    // NSError
-(void)AVPlayerItemFailedToPlayToEndTimeErrorKey:(NSNotification*) notification
{
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    id oldObj = [change valueForKeyPath:NSKeyValueChangeOldKey];
    id newObj = [change valueForKeyPath:NSKeyValueChangeNewKey];
    
   if(object==_avPlayer)
   {
        if([keyPath isEqualToString:kPlayerRate])
        {
            NSNumber * newValue = newObj;
            NSNumber * oldValue = oldObj;
        }
        else if([keyPath isEqualToString:kPlayerMuted])
        {
           
        }
        else if([keyPath isEqualToString:kPlayerVolume])
        {
           
        }
        else if([keyPath isEqualToString:kPlayerCurrentTIme])
        {
            
        }
   }
}

-(void)handlePlay
{
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [self addPlayerTimeObserver];
    [_avPlayer play];
    [_playerViewController playerDidPlay];
}

-(void)handlePause
{
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [self removePlayerTimeObserver];
    [_avPlayer pause];
    [_playerViewController playerDidPause];
}

-(void)handleRewind:(float)speed
{
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [_avPlayer setRate:speed];
    
    [_playerViewController playerDidRewind:speed];
}

-(void)handleFastforward:(float)speed
{
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [_avPlayer setRate:speed];
    
    [_playerViewController playerDidFastforward:speed];
}
-(void)handleStop
{
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [_avPlayer pause];
    [_avPlayer seekToTime:kCMTimeZero];
    [self removePlayerTimeObserver];
    [_playerViewController playerDidStop];
}

-(void)handleCloseView
{
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [_avPlayer pause];
    [self removePlayerTimeObserver];
    // Remove all observers.
    
    
    NSArray *oserverPaths = @[kPlayerRate,kPlayerError,kPlayerMuted,kPlayerStatus,kPlayerVolume,kPlayerCurrentTIme,kPlayerCurrentTime];
    
    for (NSString *path in oserverPaths) {
        [_avPlayer removeObserver:self
                  forKeyPath:path];
        
    }
    
//    NSArray *observerPaths = @[kItemAsset,kItemError,kItemStatus,kItemTracks,kItemDuration];
//    
//    for (NSString *path in observerPaths) {
//        [_avPlayer removeObserver:self
//                       forKeyPath:path];
//    }

    
    [_playerViewController playerDidCloseView];
}

-(void)handleResumeTime:(float)second
{
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [self playbackEndScrub];
    [self playbackScrub:second];
    [self playbackBeginScrub];
}

- (void)addPlayerTimeObserver {
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    if (!_playerTimeObserver) {
        __unsafe_unretained HKVideoPlayerCoreView *weakSelf = self;
        id observer = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(.5, NSEC_PER_SEC)
                                                                queue:dispatch_get_main_queue()
                                                           usingBlock:^(CMTime time) {
                                                               
                                                               HKVideoPlayerCoreView *strongSelf = weakSelf;
                                                               if (CMTIME_IS_VALID(strongSelf.avPlayer.currentTime) && CMTIME_IS_VALID(strongSelf.avPlayer.currentItem.duration))
                                                                   [strongSelf syncScrobber];
                                                           }];
        
        [self setPlayerTimeObserver:observer];
    }
}

- (void)removePlayerTimeObserver {
    NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    if (_playerTimeObserver) {
        [self.avPlayer removeTimeObserver:self.playerTimeObserver];
        [self setPlayerTimeObserver:nil];
    }
}

- (void)playbackBeginScrub {
    if(_scrubbing)
        return;
     NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [self removePlayerTimeObserver];
    [self setScrubbing:YES];
    [self setRestoreAfterScrubbingRate:self.avPlayer.rate];
    [self.avPlayer pause];
}
BOOL didSeek=YES;
- (void)playbackScrub:(float)scrubTime {
    if(!CMTIME_IS_VALID(CMTimeMakeWithSeconds(scrubTime, NSEC_PER_SEC)))
        return;
    if(!didSeek)
        return;
//    didSeek = NO;
     NSLog(@"HK >>> %s scrubTime:%f",__PRETTY_FUNCTION__,scrubTime);
    [_playerViewController playerDidBeginChangePlayback];
    CMTime time = CMTimeMakeWithSeconds(scrubTime, NSEC_PER_SEC);
    [_avPlayer seekToTime:time completionHandler:^(BOOL finished) {
//        didSeek=YES;
        [_playerViewController playerDidEndChangePlayback];
    }];
}

- (void)playbackEndScrub {
    if(!_scrubbing)
        return;
     NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    [self.avPlayer setRate:self.restoreAfterScrubbingRate];
    [self setScrubbing:NO];
    [self addPlayerTimeObserver];
}

- (void)syncScrobber {
     NSLog(@"HK >>> %s",__PRETTY_FUNCTION__);
    NSInteger current = ceilf(CMTimeGetSeconds(self.avPlayer.currentTime));
    NSInteger duration = ceilf(CMTimeGetSeconds(self.avPlayer.currentItem.duration));
    NSInteger remain = duration-current;
    
    [_playerViewController playerDidUpdateCurrentTime:current remainTime:remain durationTime:duration];
    
    NSLog(@"%@", self.player.currentItem.seekableTimeRanges);
}

#pragma mark - Handle touches
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerViewController touchesBegan:touches withEvent:event];
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerViewController touchesEnded:touches withEvent:event];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerViewController touchesMoved:touches withEvent:event];
//}
//
//-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerViewController touchesCancelled:touches withEvent:event];
//}
//
//#pragma mark - Handle motions
//
//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    [self.playerViewController motionBegan:motion withEvent:event];
//}
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    [self.playerViewController motionEnded:motion withEvent:event];
//}
//-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    [self.playerViewController motionCancelled:motion withEvent:event];
//}
//
//#pragma mark - Handle remote control
//
//-(void)remoteControlReceivedWithEvent:(UIEvent *)event
//{
//    [self.playerViewController remoteControlReceivedWithEvent:event];
//}
//

@end

@implementation HKVideoPlayerCoreView (CaptureFeature)

AVCaptureSession *_captureSession;
AVCaptureDeviceInput *_captureDeviceInput;

-(void)captureVideo
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
    
    NSError *error = nil;
    _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:@"AVMediaTypeMuxed"] error:&error];
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession startRunning];
}
-(void)captureVideoDoneWithFilePath:(NSURL *)filePath
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
    [_captureSession stopRunning];
}

-(void)captureAudio
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}
-(void)captureAudioDoneWithFilePath:(NSURL *)filepath
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

@end
