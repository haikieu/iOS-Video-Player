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
- (NSString*)getVideoFillMode;
- (void)setVideoFillMode:(NSString *)fillMode;
- (void)beginViewSessionWithUrl:(NSURL *)url;
- (void)clearViewSession;

@end

@interface HKVideoPlayerCoreView : UIView <HKVideoPlayerCoreView>


@property(nonatomic,assign,readonly)AVKeyValueStatus avStatus;

-(instancetype)initWithPlayerVC:(HKVideoPlayerViewController*)playerVC;

-(NSString*)getDurationTimeString;
-(NSString*)getCurrentTimeString;
-(NSString*)getRemainTimeString;

@end

@interface HKVideoPlayerCoreView(CaptureFeature)

-(void)captureVideo;
-(void)captureVideoDoneWithFilePath:(NSURL*)filePath;
-(void)captureAudio;
-(void)captureAudioDoneWithFilePath:(NSURL*)filepath;

@end

@interface HKVideoPlayerCoreView(DetectiveFeature)

-(void)autoDectectFaceWithIntervalTime:(NSTimeInterval)intervalTime activate:(BOOL)activated;

@end
