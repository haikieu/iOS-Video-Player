//
//  HKVideoPlayerDefaultTheme.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerDefaultTheme.h"
#import "HKVideoPlayerViewController.h"
#import "HKVideoPlayerCoreView.h"
#import "HKUtility.h"


@interface HKVideoPlayerDefaultTheme ()
{
    float _remainTime;
    float _currentTime;
    float _durationTime;
}


@property UILabel *title;
@property UIView *topBar;
@property UIView *bottomBar;
@property UISlider *progressBar;
@property UIButton *btnPlay;
@property UIButton *btnClose;
@property UIButton *btnRewind;
@property UIButton *btnForward;

@end

@implementation HKVideoPlayerDefaultTheme

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _remainTime = 0;
        _currentTime = 0;
        _durationTime = 0;
    }
    return self;
}

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

UIView *topBar;
UIView *bottomBar;
-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController *)playerVC
{
    [super renderThemeOnPlayerVC:playerVC];
    
    float _topOffset = 20;
    float _topBarHeight = 40;
    if(DEVICE_IS_IPAD()&&[[self class] themeViewShouldSupportIpad])
    {
        _topOffset = 00;
        _topBarHeight = 50;
    }
    
    _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _topBarHeight + _topOffset)];
    _topBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self addSubview:_topBar];
    
    _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnClose.frame = CGRectMake(self.bounds.size.width - _topBarHeight, _topOffset, _topBarHeight, _topBarHeight);
    [_btnClose setImage:[[self class] getAssetImageWithName:@"Image_Button_cross"] forState:UIControlStateNormal];
    [_btnClose addTarget:self.playerVC action:@selector(handleCloseView) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addSubview:_btnClose];
    
    _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 50, self.bounds.size.width, 50)];
    _bottomBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self addSubview:_bottomBar];
    
    
    
    _btnRewind = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnRewind.frame = CGRectMake(0, 0, 50, 50);
    [_btnRewind setImage:[[self class] getAssetImageWithName:@"Image_Button_rewind"] forState:UIControlStateNormal];
    [_btnRewind addTarget:self.playerVC action:@selector(handleRewind:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar addSubview:_btnRewind];
    
    _btnPlay = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnPlay.frame = CGRectMake(_btnRewind.frame.origin.x+_btnRewind.frame.size.width, 0, 50, 50);
    [_btnPlay setImage:[[self class] getAssetImageWithName:@"Image_Button_play"] forState:UIControlStateNormal];
    [_btnPlay addTarget:self.playerVC action:@selector(handlePlay) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar addSubview:_btnPlay];
    
    _btnForward = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnForward.frame = CGRectMake(_btnPlay.frame.origin.x+_btnPlay.frame.size.width, 0, 50, 50);
    [_btnForward setImage:[[self class] getAssetImageWithName:@"Image_Button_next"] forState:UIControlStateNormal];
    [_btnForward addTarget:self.playerVC action:@selector(handleFastforward:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar addSubview:_btnForward];
    
    _progressBar = [[UISlider alloc] initWithFrame:CGRectMake(_btnForward.frame.origin.x+_btnForward.frame.size.width, 0, self.bounds.size.width-150, 50)];
    [_progressBar addTarget:self.playerVC action:@selector(playbackBeginScrub) forControlEvents:UIControlEventTouchDown];
    [_progressBar addTarget:self action:@selector(onProgressChange:) forControlEvents:UIControlEventValueChanged];
    [_progressBar addTarget:self.playerVC action:@selector(playbackEndScrub) forControlEvents:UIControlEventTouchUpInside];
    [_progressBar addTarget:self.playerVC action:@selector(playbackEndScrub) forControlEvents:UIControlEventTouchUpOutside];
    [_progressBar addTarget:self.playerVC action:@selector(playbackEndScrub) forControlEvents:UIControlEventTouchCancel];
    [_progressBar addTarget:self.playerVC action:@selector(playbackEndScrub) forControlEvents:UIControlEventTouchDragExit];
    [_progressBar addTarget:self.playerVC action:@selector(playbackEndScrub) forControlEvents:UIControlEventEditingDidEnd];    _progressBar.enabled = false;
    [_bottomBar addSubview:_progressBar];
    
    
    
}

-(void)showThemeView:(BOOL)animated
{
        self.hidden = NO;
        _topBar.transform = CGAffineTransformTranslate(_topBar.transform, 0, -_topBar.bounds.size.height);
        _topBar.alpha=0;
        _bottomBar.transform = CGAffineTransformTranslate(_bottomBar.transform, 0, _bottomBar.bounds.size.height);
        _bottomBar.alpha=0;
        
        [UIView animateWithDuration:animated?1:0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            _topBar.alpha=1;
            _topBar.transform = CGAffineTransformIdentity;
            _bottomBar.alpha=1;
            _bottomBar.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
}

-(void)hideThemeView:(BOOL)animated
{
    
    _topBar.alpha=1;
    
    _bottomBar.alpha=1;
    _topBar.transform = CGAffineTransformIdentity;
    _bottomBar.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:animated?1:0 animations:^{
        _topBar.alpha=0;
        _topBar.transform = CGAffineTransformTranslate(_topBar.transform, 0, -_topBar.bounds.size.height);
        _bottomBar.alpha=0;
        _bottomBar.transform = CGAffineTransformTranslate(_bottomBar.transform, 0, _bottomBar.bounds.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(void)onProgressChange:(id)sender
{
    float seekTIme = _progressBar.value * _durationTime;
    [self.playerVC playbackScrub:seekTIme];
}

-(void)playerDidUpdateCurrentTime:(float)currentTime remainTime:(float)remainTime durationTime:(float)durationTime
{
    _progressBar.enabled = true;
    
    if(durationTime>=0)
    {
        _durationTime = durationTime;
        if(DEVICE_IS_IPAD())
            [_progressBar setMaximumValueImage:[[self class] imageFromText:[[self class] timeStringFromSeconds:durationTime]]];
    }
    else
    {
        _progressBar.enabled = false;
        return;
    }
    if(currentTime>=0)
    {
        _currentTime = currentTime;
        [_progressBar setMinimumValueImage:[[self class] imageFromText:[[self class] timeStringFromSeconds:currentTime]]];
    }
    else
    {
        _progressBar.enabled = false;
        return;
    }
    _remainTime = remainTime;
    [_progressBar setValue:(currentTime/durationTime) animated:YES];
}

-(BOOL)themeViewAllowDraggableAtPosition:(CGPoint)postion
{
    BOOL draggable = [super themeViewAllowDraggableAtPosition:postion];
    
    draggable = draggable && !_topBar.hidden && CGRectContainsPoint(_topBar.frame, postion);
    
    draggable = draggable && !CGRectContainsPoint(_bottomBar.frame, postion);
    
    return draggable;
}

-(void)playerDidPlay
{
    [_btnPlay setImage:[[self class] getAssetImageWithName:@"Image_Button_pause"] forState:UIControlStateNormal];
    [_btnPlay addTarget:self.playerVC action:@selector(handlePause) forControlEvents:UIControlEventTouchUpInside];
}

-(void)playerDidPause
{
    [_btnPlay setImage:[[self class] getAssetImageWithName:@"Image_Button_play"] forState:UIControlStateNormal];
    [_btnPlay addTarget:self.playerVC action:@selector(handlePlay) forControlEvents:UIControlEventTouchUpInside];
}

-(void)playerDidCloseView
{
    [self hideThemeView:YES];
}

-(UIEdgeInsets)playerGetConfigInsets
{
//    return UIEdgeInsetsMake(50, 0, 50, 0);
    return UIEdgeInsetsZero;
}

-(BOOL)themeViewRequireClipsToBounds
{
    return YES;
}

+(BOOL)themeViewRequireStatusBar
{
    return YES;
}

-(void)setEventHandler
{
    
}

+(BOOL)themeViewShouldAutorotate
{
    return NO;
}

+(BOOL)themeViewShouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == [[self class] themeViewSupportedInterfaceOrientations]);
    
}

+(NSUInteger)themeViewSupportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

@end
