//
//  HKVideoPlayerCore.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HKVideoPlayerCore <NSObject>

-(void)beginViewSessionWithUrl:(NSURL*) url;
-(void)clearViewSession;

-(void)handleCloseView;

-(void)handlePlay;
-(void)handleStop;
-(void)handlePause;
-(void)handleRewind:(float)speed;
-(void)handleFastforward:(float)speed;
-(void)handleResumePosition:(float)position;

-(void)handleEnterFullscreen;
-(void)handleExitFullscreen;
-(void)handleResizeWithFrame:(CGRect*)frame;

@end