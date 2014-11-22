//
//  HKVideoPlayerCore.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HKVideoPlayerCore <NSObject>

-(void)play;
-(void)stop;
-(void)pause;
-(void)rewind:(float)speed;
-(void)fastforward:(float)speed;
-(void)resumePosition:(float)position;

@end