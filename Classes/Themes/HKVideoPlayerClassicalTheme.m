//
//  HKVideoPlayerClassicalTheme.m
//  iOS Video Player
//
//  Created by HK on 11/27/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerClassicalTheme.h"
#import "HKUtility.h"
#import "HKVideoPlayerViewController.h"


@interface HKVideoPlayerClassicalTheme ()
{
    float _remainTime;
    float _currentTime;
    float _durationTime;
}
@end

@implementation HKVideoPlayerClassicalTheme

- (instancetype)init
{
    self = [super init];
    if (self) {
        _remainTime = 0;
        _currentTime = 0;
        _durationTime = 0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _remainTime = 0;
        _currentTime = 0;
        _durationTime = 0;
    }
    return self;
}

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

-(void)renderThemeAssetOnPlayerVC:(HKVideoPlayerViewController *)playerVC
{
    [_btnNext setTitle:nil forState:UIControlStateNormal];
    [_btnPrevious setTitle:nil forState:UIControlStateNormal];
    [_btnPlay setTitle:nil forState:UIControlStateNormal];
    
    [_btnPrevious setImage:[[self class] getAssetImageWithName:@"Image_Button_rewind"] forState:UIControlStateNormal];
    [_btnPlay setImage:[[self class] getAssetImageWithName:@"Image_Button_play"] forState:UIControlStateNormal];
    [_btnNext setImage:[[self class] getAssetImageWithName:@"Image_Button_next"] forState:UIControlStateNormal];
}


- (IBAction)onTapDoneButton:(UIButton *)sender {
    [self.playerVC handleCloseView];
}

- (IBAction)onTapPlayButton:(id)sender {
    [self.playerVC handlePlay];
}

- (IBAction)onTapPauseButton:(id)sender {
    [self.playerVC handlePause];
}


-(void)playerDidPlay
{
    [_btnPlay setImage:[[self class] getAssetImageWithName:@"Image_Button_pause"] forState:UIControlStateNormal];
    [_btnPlay addTarget:self action:@selector(onTapPauseButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)playerDidPause
{
    [_btnPlay setImage:[[self class] getAssetImageWithName:@"Image_Button_play"] forState:UIControlStateNormal];
    [_btnPlay addTarget:self action:@selector(onTapPlayButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)onTapPreviousButton:(id)sender {
    [self.playerVC handleRewind:1];
}

- (IBAction)onTapNextButton:(id)sender {
    [self.playerVC handleFastforward:1];
}

- (IBAction)onTouchDown:(id)sender {
    if(sender==_slProgressBar)
    {
        [self.playerVC playbackBeginScrub];
    }
}

- (IBAction)onTouchDragExit:(id)sender {
    if(sender==_slProgressBar)
    {
        [self.playerVC playbackEndScrub];
    }
}

- (IBAction)onTouchUpOutside:(id)sender {
    if(sender==_slProgressBar)
    {
        [self.playerVC playbackEndScrub];
    }
}

- (IBAction)onTouchUpInside:(id)sender {
    if(sender==_slProgressBar)
    {
        [self.playerVC playbackEndScrub];
    }
}

- (IBAction)onTouchEditingDidEnd:(id)sender {
    if(sender==_slProgressBar)
    {
        [self.playerVC playbackEndScrub];
    }
}

- (IBAction)onTouchCancel:(id)sender {
    if(sender==_slProgressBar)
    {
        [self.playerVC playbackEndScrub];
    }
}

- (IBAction)onValueChanged:(id)sender {
    if(sender==_slProgressBar)
    {
        float seekTIme = _slProgressBar.value * _durationTime;
        [self.playerVC playbackScrub:seekTIme];
    }
    else if(sender == _slVolumeBar)
    {
        [self.playerVC volumeScrub:_slVolumeBar.value];
    }
}

-(void)playerDidChangeVolume:(float)volume
{
    _slVolumeBar.value = volume;
}

-(void)playerWillChangeOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(DEVICE_IS_IPAD()||UIDeviceOrientationIsLandscape([HKUtility currentOrientation]))
    {
        [_slProgressBar setMaximumValueImage:[[self class] imageFromText:[[self class] timeStringFromSeconds:_durationTime]]];
    }
    else
    {
        [_slProgressBar setMaximumValueImage:nil];
    }
}

-(void)playerDidUpdateCurrentTime:(float)currentTime remainTime:(float)remainTime durationTime:(float)durationTime
{
    _slProgressBar.enabled = true;
    
    if(durationTime>=0)
    {
        _durationTime = durationTime;
        if(DEVICE_IS_IPAD()||UIDeviceOrientationIsLandscape([HKUtility currentOrientation]))
        {
            [_slProgressBar setMaximumValueImage:[[self class] imageFromText:[[self class] timeStringFromSeconds:durationTime]]];
        }
        else
        {
            [_slProgressBar setMaximumValueImage:nil];
        }
    }
    else
    {
        _slProgressBar.enabled = false;
        return;
    }
    if(currentTime>=0)
    {
        _currentTime = currentTime;
        [_slProgressBar setMinimumValueImage:[[self class] imageFromText:[[self class] timeStringFromSeconds:currentTime]]];
    }
    else
    {
        _slProgressBar.enabled = false;
        return;
    }
    _remainTime = remainTime;
    [_slProgressBar setValue:(currentTime/durationTime) animated:YES];
}

@end
