//
//  HKVideoPlayerViewController.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKVideoPlayerFuntionality.h"
#import "HKVideoPlayerEvent.h"
#import "HKVideoPlayerViewControllerDelegate.h"


//https://developer.apple.com/streaming/
#define URL_BASIC_STREAMING @"https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"
#define URL_ADVANCED_STREAMING @"https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8"

@class HKVideoPlayerThemeView;
@class HKVideoPlayerCoreView;

@protocol HKVideoPlayerViewController <HKVideoPlayerFuntionality,HKVideoPlayerPostEvent>

@property(nonatomic,strong)HKVideoPlayerThemeView *themeView;
@property(nonatomic,strong)HKVideoPlayerCoreView *coreView;
@property(nonatomic,weak) id<HKVideoPlayerViewControllerDelegate> delegate;

-(void)loadUrl:(NSURL*)url autoPlay:(BOOL)autoPlay;

@end

@interface HKVideoPlayerViewController : UIViewController <HKVideoPlayerViewController>

@property(nonatomic,assign) BOOL repeat;

@property(nonatomic,assign,readonly) BOOL autoPlay;
@property(nonatomic,strong,readonly) NSURL *videoUrl;

@property(nonatomic,assign) CGRect baseFrame;

-(instancetype)initWithFrame:(CGRect)frame theme:(HKVideoPlayerThemeView*) themeView;


@end
