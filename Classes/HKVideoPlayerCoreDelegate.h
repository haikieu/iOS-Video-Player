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
-(void) playerDidPlay;
-(void) playerDidStop;
-(void) playerDidPause;
-(void) playerDidEnterFullscreen;
-(void) playerDidExitFullscreen;
-(void) playerDidRewind:(float)speed;
-(void) playerDidForward:(float)speed;
-(void) playerDidUpdatePosition:(float)position;
-(void) playerDidCloseView;

@end
