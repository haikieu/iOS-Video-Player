//
//  HKVideoPlayerClassicalTheme.m
//  iOS Video Player
//
//  Created by HK on 11/27/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerClassicalTheme.h"
#import "HKUtility.h"


@implementation HKVideoPlayerClassicalTheme

+(BOOL)isNibBasedTheme
{
    return YES;
}

+(NSString *)nibName
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7"))
    {
        return @"HKVideoPlayerClassicalTheme_NonSizeClass";
    }

    return [[super class] nibName];
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


- (IBAction)onTapDoneButton:(UIButton *)sender {
}

- (IBAction)onTapPlayButton:(id)sender {
}
- (IBAction)onTapPreviousButton:(id)sender {
}

- (IBAction)onTapNextButton:(id)sender {
}

- (IBAction)onTouchDown:(id)sender {
}

- (IBAction)onTouchDragExit:(id)sender {
}

- (IBAction)onTouchUpOutside:(id)sender {
}

- (IBAction)onTouchUpInside:(id)sender {
}

- (IBAction)onTouchEditingDidEnd:(id)sender {
}

- (IBAction)onTouchCancem:(id)sender {
}

- (IBAction)onValueChanged:(id)sender {
}
@end
