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


-(void)beginViewSessionWithUrl:(NSURL *)url
{
    self.avAsset = [AVAsset assetWithURL:url];
    [_avAsset loadValuesAsynchronouslyForKeys:@[@"tracks",@"lyrics",@"creationDate",@"commonMetadata",@"availableMetadataFormats"] completionHandler:^{
        
        _avPlayer = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:_avAsset automaticallyLoadedAssetKeys:@[@"tracks",@"lyrics",@"creationDate",@"commonMetadata",@"availableMetadataFormats"]]];
        [self setPlayer:_avPlayer];
        
        [_playerViewController playerDidLoad];
        
    }];
    
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
