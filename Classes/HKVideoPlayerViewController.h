//
//  HKVideoPlayerViewController.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKVideoPlayerCore.h"
#import "HKVideoPlayerCoreDelegate.h"

@class HKVideoPlayerThemeView;
@class HKVideoPlayerCoreView;

@interface HKVideoPlayerViewController : UIViewController <HKVideoPlayerCore,HKVideoPlayerCoreDelegate>

@property(nonatomic,strong)HKVideoPlayerThemeView *themeView;
@property(nonatomic,strong)HKVideoPlayerCoreView *coreView;

@end
