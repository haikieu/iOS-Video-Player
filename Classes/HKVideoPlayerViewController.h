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
#import "UIViewController+Draggable.h"

//https://developer.apple.com/streaming/
#define URL_BASIC_STREAMING @"https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"
#define URL_ADVANCED_STREAMING @"https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8"

#define URL_UTUBE_hd720 @"http://r2---sn-42u-nbok.googlevideo.com/videoplayback?fexp=900242,907259,927622,930821,932404,934926,943909,945092,945125,947209,947215,948124,948703,952302,952605,952901,953103,953912,955404,957103,957105,957201&initcwndbps=1243750&key=yt5&upn=1350QzrWR54&sparams=id,initcwndbps,ip,ipbits,itag,mm,ms,mv,ratebypass,source,upn,expire&expire=1416734251&itag=22&ratebypass=yes&ipbits=0&ip=58.186.118.145&mm=31&source=youtube&ms=au&id=o-ACmK1fEhWlxfTPt9MUEqrwx3Qy7nmGrakQD4sc-EpRIR&mv=m&mt=1416712557&sver=3&signature=E106F06173B38F54AEC3FF2095F4BDCC34E68292.4E8CFA7B56D5184B6F1B687A5917D9C68F3A7F25&signature=(null)"
#define URL_UTUBE_MEDIUM @"http://r2---sn-42u-nbok.googlevideo.com/videoplayback?fexp=900242,907259,927622,930821,932404,934926,943909,945092,945125,947209,947215,948124,948703,952302,952605,952901,953103,953912,955404,957103,957105,957201&initcwndbps=1243750&key=yt5&upn=1350QzrWR54&sparams=id,initcwndbps,ip,ipbits,itag,mm,ms,mv,ratebypass,source,upn,expire&expire=1416734251&itag=18&ratebypass=yes&ipbits=0&ip=58.186.118.145&mm=31&source=youtube&ms=au&id=o-ACmK1fEhWlxfTPt9MUEqrwx3Qy7nmGrakQD4sc-EpRIR&mv=m&mt=1416712557&sver=3&signature=13A46F499155AC20FAC19D9A8B466CFE1E07EE12.D8237FB2E46E027034531D88A604641B62252A60&signature=(null)"
#define URL_UTUBE_SMALL @"http://r2---sn-42u-nbok.googlevideo.com/videoplayback?fexp=900242,907259,927622,930821,932404,934926,943909,945092,945125,947209,947215,948124,948703,952302,952605,952901,953103,953912,955404,957103,957105,957201&initcwndbps=1243750&key=yt5&upn=1350QzrWR54&sparams=id,initcwndbps,ip,ipbits,itag,mm,ms,mv,source,upn,expire&expire=1416734251&itag=17&ipbits=0&ip=58.186.118.145&mm=31&source=youtube&ms=au&id=o-ACmK1fEhWlxfTPt9MUEqrwx3Qy7nmGrakQD4sc-EpRIR&mv=m&mt=1416712557&sver=3&signature=6E651303B67AB41A28BC99134A51F232AF125890.48C0EA4F59D2F43E7EE64E7E3A6B7E1A48C8F137&signature=(null)"


#define DEVICE_IS_IPHONE() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
#define DEVICE_IS_IPAD() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)

@class HKVideoPlayerThemeView;
@class HKVideoPlayerCoreView;

@protocol HKVideoPlayerViewController <HKVideoPlayerFuntionality,HKVideoPlayerPostEventDelegate>

@property(nonatomic,strong)HKVideoPlayerThemeView *themeView;
@property(nonatomic,strong)HKVideoPlayerCoreView *coreView;
@property(nonatomic,weak) id<HKVideoPlayerViewControllerDelegate> delegate;

-(void)loadUrl:(NSURL*)url autoPlay:(BOOL)autoPlay;

@end

@interface HKVideoPlayerViewController : UIViewController <HKVideoPlayerViewController>

@property(nonatomic,strong,readonly) NSURL *videoUrl;
@property(nonatomic,readonly)BOOL isPlay;
@property(nonatomic,assign) BOOL repeat;
@property(nonatomic,assign,readonly) BOOL autoPlay;
@property(nonatomic,assign,readonly) BOOL fullScreen;
@property(nonatomic,assign) CGRect baseFrame;

-(instancetype)initWithFrame:(CGRect)frame theme:(HKVideoPlayerThemeView*) themeView;
-(void)setPlayerTitle:(NSString*)string subTitle:(NSString*)subTitle;
-(void)autoHideThemeView:(BOOL)enable afterTime:(float) second;

@end
