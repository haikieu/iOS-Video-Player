//
//  HKVideoPlayerCore.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HKVideoPlayerFuntionality <NSObject>

-(void)handleCloseView;

-(void)handlePlay;
-(void)handleStop;
-(void)handlePause;
-(void)handleRewind:(float)speed;
-(void)handleFastforward:(float)speed;
-(void)handleResumeTime:(float)second;

-(void)handleEnterFullscreen;
-(void)handleExitFullscreen;
-(void)handleResizeWithFrame:(CGRect)frame;


-(void)playbackBeginScrub;
-(void)playbackEndScrub;
-(void)playbackScrub:(float)scrubTime;
-(void)playbackSynScrub;

@end