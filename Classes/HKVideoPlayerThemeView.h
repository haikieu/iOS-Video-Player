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
@protocol HKVideoPlayerThemeView <HKVideoPlayerThemeViewRequirementDelegate,HKVideoPlayerPreEventDelegate,HKVideoPlayerPostEventDelegate>

@property(nonatomic,weak,readonly)HKVideoPlayerViewController *playerVC;

-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController*)playerVC;
-(void)setEventHandler;

-(void)showThemeView:(BOOL)animated;
-(void)hideThemeView:(BOOL)animated;

-(void)showLoadingAnimation;
-(void)hideLoadingAnimation;

@end

@interface HKVideoPlayerThemeView : UIView <HKVideoPlayerThemeView>

+(HKVideoPlayerThemeView*) theme;

@end


@interface HKVideoPlayerThemeView(Assets)

+(NSString*)specifyDefaultBundle;
+(UIImage*)getAssetImageWithName:(NSString*)fileName;
+(UIImage*)getAssetImageWithName:(NSString*)fileName bundle:(NSString*)bundleName;

+(NSString *)timeStringFromSeconds:(float)secondsValue;

+(UIImage *)imageFromText:(NSString *)text;

@end