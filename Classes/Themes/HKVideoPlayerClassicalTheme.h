//
//  HKVideoPlayerClassicalTheme.h
//  iOS Video Player
//
//  Created by HK on 11/27/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerThemeView.h"

@interface HKVideoPlayerClassicalTheme : HKVideoPlayerThemeView

@property (strong, nonatomic) IBOutlet UIView *vwTopBar;
@property (strong, nonatomic) IBOutlet UIView *vwBottomBar;

@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic) IBOutlet UIButton *btnFullScreen;
@property (strong, nonatomic) IBOutlet UIButton *btnPlay;
@property (strong, nonatomic) IBOutlet UIButton *btnPrevious;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;


@property (strong, nonatomic) IBOutlet UISlider *slProgressBar;
@property (strong, nonatomic) IBOutlet UISlider *slVolumeBar;


- (IBAction)onTapDoneButton:(UIButton *)sender;
- (IBAction)onTapPlayButton:(id)sender;

- (IBAction)onTapPreviousButton:(id)sender;
- (IBAction)onTapNextButton:(id)sender;
- (IBAction)onTouchDown:(id)sender;

- (IBAction)onTouchDragExit:(id)sender;
- (IBAction)onTouchUpOutside:(id)sender;
- (IBAction)onTouchUpInside:(id)sender;
- (IBAction)onTouchEditingDidEnd:(id)sender;

- (IBAction)onTouchCancel:(id)sender;
- (IBAction)onValueChanged:(id)sender;

@end
