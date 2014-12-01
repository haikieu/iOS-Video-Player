//
//  HKVideoPlayerThemeView.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKVideoPlayerEvent.h"
#import "UIView+MHNibLoading.h"

@class HKVideoPlayerViewController;
@class HKVideoPlayerThemeView;
@protocol HKVideoPlayerThemeView <HKVideoPlayerThemeViewRequirementDelegate,HKVideoPlayerPreEventDelegate,HKVideoPlayerPostEventDelegate>

@property(nonatomic,weak,readonly)HKVideoPlayerViewController *playerVC;

-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController*)playerVC;
-(void)renderLoadingOnPlayerVC:(HKVideoPlayerViewController*)playerVC;
-(void)setEventHandler __deprecated_msg("This is deprecated now");
-(void)showThemeView:(BOOL)animated;
-(void)hideThemeView:(BOOL)animated;
-(void)showLoadingAnimation;
-(void)hideLoadingAnimation;

+(HKVideoPlayerThemeView*) theme;

@end

@interface HKVideoPlayerThemeView : UIView <HKVideoPlayerThemeView>

@property(nonatomic,strong)NSString * playerTitle;
@property(nonatomic,strong)NSString * playerSubTitle;

@end


@interface HKVideoPlayerThemeView(Assets)

+(NSString*)specifyDefaultBundle;
+(UIImage*)getAssetImageWithName:(NSString*)fileName;
+(UIImage*)getAssetImageWithName:(NSString*)fileName bundle:(NSString*)bundleName;

+(NSString *)timeStringFromSeconds:(float)secondsValue;

+(UIImage *)imageFromText:(NSString *)text;

@end