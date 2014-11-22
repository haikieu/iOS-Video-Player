//
//  HKVideoPlayerCoreDelegate.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HKVideoPlayerCoreDelegate <NSObject>

-(void) playerWillLoad;
-(void) playerDidLoad;
-(void) playerDidFailure;
-(void) playerDidReady;

-(void) playerWillPlay;
-(void) playerDidPlay;

-(void) playerWillStop;
-(void) playerDidStop;

-(void) playerWillPause;
-(void) playerDidPause;

-(void) playerWillEnterFullscreen;
-(void) playerDidEnterFullscreen;

-(void) playerWillExitFullscreen;
-(void) playerDidExitFullscreen;

-(void) playerWillRewind:(float)speed;
-(void) playerDidRewind:(float)speed;

-(void) playerWillFastforward:(float)speed;
-(void) playerDidFastforward:(float)speed;

-(void) playerWillUpdatePosition:(float)position;
-(void) playerDidUpdatePosition:(float)position;

-(void) playerWillCloseView;
-(void) playerDidCloseView;

@end
