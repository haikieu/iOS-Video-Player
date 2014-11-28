//
//  HKVideoPlayerCoreDelegate.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Implemented by HKVideoPlayerThemeView abstract class
 Flow: CoreView ->[invoke]-> ViewController ->[invoke]-> ThemeView
*/
@protocol HKVideoPlayerThemeViewRequirementDelegate <NSObject>

-(BOOL) themeViewAllowDraggableAtPosition:(CGPoint)postion;
-(BOOL) themeViewAllowResizeWithFrame:(CGRect)frame;

-(BOOL) themeViewNeedClipsToBounds;
+(BOOL) themeViewShouldSupportIpadnIphone;
+(BOOL) themeViewShouldSupportIpad;
+(BOOL) themeViewShouldSupportIphone;

#pragma mark - Support interview orientation

+(NSUInteger) themeViewSupportedInterfaceOrientations;
+(BOOL) themeViewShouldAutorotate;
// You do not need this method if you are not supporting earlier iOS Versions
+(BOOL) themeViewShouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;


+(CGSize) themeViewPreferedSize;

@end

/**
 Implemented by HKVideoPlayerThemeView abstract class as well as HKVideoPlayerViewController
 Flow: CoreView ->[invoke]-> ViewController ->[invoke]-> ThemeView
 */
@protocol HKVideoPlayerCoreEventDelegate <NSObject>

-(UIEdgeInsets)playerGetConfigInsets;

@end

/**
 Implemented by HKVideoPlayerThemeView abstract class
 Flow: ViewController ->[invoke]-> ThemeView
*/
@protocol HKVideoPlayerPreEventDelegate <HKVideoPlayerCoreEventDelegate>

-(void) playerWillLoad;
-(void) playerWillPlay;
-(void) playerWillStop;
-(void) playerWillPause;
-(void) playerWillEnterFullscreen;
-(void) playerWillExitFullscreen;
-(void) playerWillRewind:(float)speed DEPRECATED_MSG_ATTRIBUTE("Deprecated now");
-(void) playerWillFastforward:(float)speed DEPRECATED_MSG_ATTRIBUTE("Deprecated now");
-(void) playerWillUpdateTime:(float)second DEPRECATED_MSG_ATTRIBUTE("Deprecated now");
-(void) playerWillCloseView;

-(void) playerWillResizeWithFrame:(CGRect)frame;
-(void) playerWillChangeOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end

/**
  Implemented by HKVideoPlayerThemeView abstract class as well as HKVideoPlayerViewController
  Flow: CoreView ->[invoke]-> ViewController ->[invoke]-> ThemeView
*/
@protocol HKVideoPlayerPostEventDelegate <HKVideoPlayerCoreEventDelegate>

-(void) playerDidRenderLoadingAnimation;
-(void) playerDidRenderView;
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
-(void) playerDidUpdateTime:(float)second DEPRECATED_MSG_ATTRIBUTE("Deprecated now, please use playerDidUpdateCurrentTime:remainTime:durationTime: instead");

-(void) playerDidUpdateCurrentTime:(float)currentTime remainTime:(float)remainTime durationTime:(float)durationTime;
-(void) playerDidCloseView;
-(void) playerDidResizeWithFrame:(CGRect)frame;
-(void) playerDidBeginChangePlayback;
-(void) playerDidEndChangePlayback;

@end