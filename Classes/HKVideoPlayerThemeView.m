//
//  HKVideoPlayerThemeView.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerThemeView.h"
#import "HKVideoPlayerNotifications.h"
#import "HKVideoPlayerException.h"
#import "HKVideoPlayerViewController.h"

@implementation HKVideoPlayerThemeView

@synthesize playerVC=_playerVC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(HKVideoPlayerThemeView *)theme
{
    return [self new];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController*)playerVC
{
    _playerVC = playerVC;
    self.frame = playerVC.view.bounds;
}

-(void)setEventHandler
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)showThemeView
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)hideThemeView
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)showLoadingAnimation
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)hideLoadingAnimation
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillResizeWithFrame:(CGRect)frame
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillCloseView
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillLoad
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillRewind:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillPlay
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillUpdatePosition:(float)position
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillStop
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillPause
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillFastforward:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillExitFullscreen
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillEnterFullscreen
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidResizeWithFrame:(CGRect)frame
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidPlay
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidStop
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidPause
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidLoad
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidFailure
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidReady
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidExitFullscreen
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidEnterFullscreen
{
   HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidCloseView
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidUpdatePosition:(float)position
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidFastforward:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}
-(void)playerDidRewind:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

@end
