//
//  HKVideoPlayerThemeView.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKVideoPlayerEvent.h"

@class HKVideoPlayerViewController;
@protocol HKVideoPlayerThemeView <HKVideoPlayerPreEvent,HKVideoPlayerPostEvent>

@property(nonatomic,weak,readonly)HKVideoPlayerViewController *playerVC;

-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController*)playerVC;
-(void)setEventHandler;

-(void)showThemeView;
-(void)hideThemeView;

-(void)showLoadingAnimation;
-(void)hideLoadingAnimation;

@end

@interface HKVideoPlayerThemeView : UIView <HKVideoPlayerThemeView>

+(HKVideoPlayerThemeView*) theme;

@end
