//
//  HKVideoPlayerClassicalTheme.m
//  iOS Video Player
//
//  Created by HK on 11/27/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerClassicalTheme.h"

@implementation HKVideoPlayerClassicalTheme

+(BOOL)isNibBasedTheme
{
    return YES;
}

-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController *)playerVC
{
    [super renderThemeOnPlayerVC:playerVC];
    UIView * nibView = [[self class] nibView];
    [self awakeFromNib];
//    [self addSubview:nibView];
}

-(void)renderLoadingOnPlayerVC:(HKVideoPlayerViewController *)playerVC
{
    [super renderLoadingOnPlayerVC:playerVC];
}


@end
