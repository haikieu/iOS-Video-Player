//
//  HKVideoPlayerCoreDelegate.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HKVideoPlayerPreEvent <NSObject>

-(void) playerWillLoad;
-(void) playerWillPlay;
-(void) playerWillStop;
-(void) playerWillPause;
-(void) playerWillEnterFullscreen;
-(void) playerWillExitFullscreen;
-(void) playerWillRewind:(float)speed;
-(void) playerWillFastforward:(float)speed;
-(void) playerWillUpdateTime:(float)second;
-(void) playerWillCloseView;
-(void) playerWillResizeWithFrame:(CGRect)frame;

@end


@protocol HKVideoPlayerPostEvent <NSObject>

-(void) playerDidLoad;
-(void) playerDidFailure;
-(void) playerDidReady;
-(void) playerDidPlay;
-(void) playerDidStop;
-(void) playerDidPause;
-(void) playerDidEnterFullscreen;
-(void) playerDidExitFullscreen;
-(void) playerDidRewind:(float)speed;
-(void) playerDidFastforward:(float)speed;
-(void) playerDidUpdateTime:(float)second;
-(void) playerDidCloseView;
-(void) playerDidResizeWithFrame:(CGRect)frame;

@end