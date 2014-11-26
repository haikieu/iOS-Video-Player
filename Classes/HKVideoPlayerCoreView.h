//
//  HKVideoPlayerCoreView.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HKVideoPlayerFuntionality.h"

@class HKVideoPlayerViewController;

@protocol HKVideoPlayerCoreView <HKVideoPlayerFuntionality>

@property(nonatomic,weak,readonly) HKVideoPlayerViewController *playerViewController;
@property(nonatomic,strong)AVPlayer *avPlayer;
@property(nonatomic,strong)AVAsset *avAsset;

- (void)setPlayer:(AVPlayer*)player;
- (void)setVideoFillMode:(NSString *)fillMode;
- (void)beginViewSessionWithUrl:(NSURL *)url;
- (void)clearViewSession;

@end

@interface HKVideoPlayerCoreView : UIView <HKVideoPlayerCoreView>

@property(nonatomic,strong)AVCaptureSession *avCaptureSession;
@property(nonatomic,assign,readonly)AVKeyValueStatus avStatus;

-(instancetype)initWithPlayerVC:(HKVideoPlayerViewController*)playerVC;

-(NSString*)getDurationTime;
-(NSString*)getCurrentTime;
-(NSString*)getRemainTime;

@end
