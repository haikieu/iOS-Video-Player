//
//  HKVideoPlayerCoreView.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerCoreView.h"
#import "HKVideoPlayerViewController.h"

#define DEFAULT_COLOR_BACKGROUND [UIColor blackColor]

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
    }
    return self;
}

-(void)initCore
{
    self.backgroundColor = DEFAULT_COLOR_BACKGROUND;
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
	[(AVPlayerLayer*)[self layer] setPlayer:player];
}

/* Specifies how the video is displayed within a player layer’s bounds.
 (AVLayerVideoGravityResizeAspect is default) */
- (void)setVideoFillMode:(NSString *)fillMode
{
	AVPlayerLayer *playerLayer = (AVPlayerLayer*)[self layer];
	playerLayer.videoGravity = fillMode;
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
                
                [_playerViewController playerDidLoad];
                
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

-(void)setupObservingPlayer
{
    AVPlayer *avPlayer = _avPlayer;
    
    [avPlayer addObserver:self forKeyPath:kPlayerStatus options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerError options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerRate options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerCurrentTime options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerVolume options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    [avPlayer addObserver:self forKeyPath:kPlayerMuted options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:@selector(setupObservingPlayer)];
    
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
   }
}

-(void)clearViewSession
{
    [_avAsset cancelLoading];
}

-(void)handlePlay
{
    [_avPlayer play];
    
    [_playerViewController playerDidPlay];
}

-(void)handlePause
{
    [_avPlayer pause];
    
    [_playerViewController playerDidPause];
}

-(void)handleRewind:(float)speed
{
    [_avPlayer setRate:speed];
    
    [_playerViewController playerDidRewind:speed];
}

-(void)handleFastforward:(float)speed
{
    [_avPlayer setRate:speed];
    
    [_playerViewController playerDidFastforward:speed];
}
-(void)handleStop
{
    [_avPlayer pause];
    [_avPlayer seekToTime:kCMTimeZero];
    
    [_playerViewController playerDidStop];
}

@end
