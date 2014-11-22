//
//  HKVideoPlayerCoreView.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HKVideoPlayerCore.h"

@class HKVideoPlayerViewController;

@interface HKVideoPlayerCoreView : UIView <HKVideoPlayerCore>

@property(nonatomic,strong)AVPlayer *avPlayer;
@property(nonatomic,strong)AVAsset *avAsset;
@property(nonatomic,strong)AVCaptureSession *avCaptureSession;

- (void)setPlayer:(AVPlayer*)player;
- (void)setVideoFillMode:(NSString *)fillMode;

@property(nonatomic,weak) HKVideoPlayerViewController *playerViewController;

@end
