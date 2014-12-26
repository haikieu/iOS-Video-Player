//
//  HKVideoPlayerThemeView.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/22/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "HKVideoPlayerThemeView.h"
#import "HKVideoPlayerNotifications.h"
#import "HKVideoPlayerException.h"
#import "HKVideoPlayerViewController.h"

@interface HKVideoPlayerThemeView ()

@property(nonatomic)UIActivityIndicatorView * indicator;

@end

@implementation HKVideoPlayerThemeView (NibLoading)

+(BOOL)isNibBasedTheme
{
    return NO;
}

+(NSString *)nibName
{
    if(![[self class] isNibBasedTheme])
        return nil;
    
    return NSStringFromClass([self class]);
}

+(NSBundle*)nibBundle
{
    if(![[self class] isNibBasedTheme])
        return nil;
    
    return [NSBundle mainBundle];
}

+(UIView*)nibView
{
    if(![[self class] isNibBasedTheme])
        return nil;
    
    return [UIView loadInstanceFromNibWithName:[[self class] nibName] owner:self bundle:[[self class] nibBundle]];
}

@end

@implementation HKVideoPlayerThemeView(Assets)

+(NSString *)specifyDefaultBundle
{
    return @"HKVideoPlayer.bundle";
}

+(UIImage *)getAssetImageWithName:(NSString *)fileName
{
    return [self getAssetImageWithName:fileName bundle:[self specifyDefaultBundle]];
}

+(UIImage *)getAssetImageWithName:(NSString *)fileName bundle:(NSString *)bundleName
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:[bundleName stringByDeletingPathExtension] ofType:[bundleName pathExtension]];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@/Assets/%@.png",bundlePath,fileName];
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

+(NSString *)timeStringFromSeconds:(float)secondsValue;
{
    NSInteger currentSeconds = ceilf(secondsValue);
    NSInteger seconds = currentSeconds % 60;
    NSInteger minutes = currentSeconds / 60;
    NSInteger hours = minutes / 60;
    
    NSString * currentTime = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    return currentTime;
}

+(UIImage *)imageFromText:(NSString *)text
{
    UIFont *font = [UIFont systemFontOfSize:20.0];
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:20.0f]}];
    if (UIGraphicsBeginImageContextWithOptions != NULL)
        UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    else
        UIGraphicsBeginImageContext(size);
    
    [text drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];
    //    [text drawAtPoint:CGPointMake(0.0, 0.0) forWidth:CGPointMake(0, 0) withFont:font fontSize:nil lineBreakMode:NSLineBreakByWordWrapping baselineAdjustment:NSTextAlignmentCenter];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation HKVideoPlayerThemeView


@synthesize playerVC=_playerVC;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(instancetype)theme
{
    if([[self class] isNibBasedTheme])
    {
        return [[self class] loadInstanceFromNibWithName:[[self class] nibName] owner:self bundle:[[self class] nibBundle]];
    }
    
    return [self new];
}

-(NSString *)playerTitle
{
    if(_playerTitle)
        return _playerTitle;
    else
        return @"HKVideoPlayer";
}

-(NSString *)playerSubTitle
{
    if(_playerSubTitle)
        return _playerSubTitle;
    else
        return @"There's no subtitle now";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)renderThemeOnPlayerVC:(HKVideoPlayerViewController*)playerVC
{
    _playerVC = playerVC;
    self.frame = playerVC.view.bounds;
    
    if([[self class] isNibBasedTheme])
    {
        [self awakeFromNib];
    }
}

-(void)renderLoadingOnPlayerVC:(HKVideoPlayerViewController *)playerVC
{
    _playerVC = playerVC;
    self.frame = playerVC.view.bounds;
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, _indicator.frame.size.width, _indicator.bounds.size.height);
    [self addSubview:_indicator];
    _indicator.hidden = YES;
}

-(void)setEventHandler
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}


-(void)showThemeView:(BOOL)animated
{
    float durationValue = animated ? 1 : 0;
    [self setHidden:NO];
    self.alpha = 0;
    self.playerVC.view.userInteractionEnabled=NO;
    [UIView animateWithDuration:durationValue delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        self.playerVC.view.userInteractionEnabled=YES;
    }];
}

-(void)hideThemeView:(BOOL)animated
{
    float durationValue = animated ? 1 : 0;
    self.alpha = 1;
    self.playerVC.view.userInteractionEnabled=NO;
    [UIView animateWithDuration:durationValue delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        self.playerVC.view.userInteractionEnabled=YES;
    }];
}

-(void)showLoadingAnimation
{
    if(!_indicator.hidden)
        return;
    
    _indicator.hidden=NO;
    _indicator.alpha=0;
    [_indicator startAnimating];
    [UIView animateWithDuration:1 animations:^{
        _indicator.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideLoadingAnimation
{
    if(_indicator.hidden)
        return;
    
    _indicator.hidden=NO;
    _indicator.alpha=1;
    [UIView animateWithDuration:1 animations:^{
        _indicator.alpha=0;
    } completion:^(BOOL finished) {
        _indicator.hidden=YES;
        [_indicator stopAnimating];
    }];
}

#pragma mark - HKVideoPlayerCoreEventDelegate

-(UIEdgeInsets)playerGetConfigInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - Support interface orientation

+(BOOL)themeViewShouldAutorotate
{
    return YES;
}

+(NSUInteger)themeViewSupportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

+(BOOL)themeViewShouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // You do not need this method if you are not supporting earlier iOS Versions
//    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
//        return YES;
//    if(interfaceOrientation|UIInterfaceOrientationPortraitUpsideDown)
//        return YES;
//    return NO;
    BOOL value = [self themeViewSupportedInterfaceOrientations] | interfaceOrientation;
    return value;
}

#pragma mark - HKVideoPlayerThemeViewRequirementDelegate

-(BOOL)themeViewAllowResizeWithFrame:(CGRect)frame
{
    return YES;
}

-(BOOL)themeViewAllowDraggableAtPosition:(CGPoint)postion
{
    return CGRectContainsPoint(self.frame, postion);
}

+(BOOL)themeViewRequireStatusBar
{
    return UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad;
}

-(BOOL)themeViewRequireClipsToBounds
{
    return self.clipsToBounds;
}

+(UIColor *)themeViewRequireCoreViewBackgroundColor
{
    return [UIColor blackColor];
}

+(UIColor *)themeViewRequireViewControllerBackgroundColor
{
    return [UIColor blackColor];
}

+(BOOL)themeViewShouldSupportIpadnIphone
{
    return [self themeViewShouldSupportIpad]&&[self themeViewShouldSupportIphone];
}

+(BOOL)themeViewShouldSupportIpad
{
    return YES;
}

+(BOOL)themeViewShouldSupportIphone
{
    return YES;
}

+(CGSize)themeViewPreferedSize
{
    return CGSizeZero;
}

#pragma mark - HKVideoPlayerPreEventDelegate

-(void)playerWillChangeOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillResizeWithFrame:(CGRect)frame
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillCloseView
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillLoad
{
    [self showLoadingAnimation];
}

-(void)playerWillRewind:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillPlay
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillUpdateTime:(float)position
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillStop
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillPause
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillFastforward:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillExitFullscreen
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerWillEnterFullscreen
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

#pragma mark - HKVideoPlayerPostEventDelegate

-(void)playerDidResizeWithFrame:(CGRect)frame
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidPlay
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidStop
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidPause
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidRenderLoadingAnimation
{
    self.hidden = NO;
    [self showLoadingAnimation];
}

-(void)playerDidRenderView
{
    self.hidden = YES;
}

-(void)playerDidUpdateCurrentTime:(float)currentTime remainTime:(float)remainTime durationTime:(float)durationTime
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidLoad
{
    [self hideLoadingAnimation];
    [self showThemeView:YES];
}

-(void)playerDidFailure
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidReady
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidExitFullscreen
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidEnterFullscreen
{
   HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidCloseView
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidUpdateTime:(float)position
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)playerDidBeginChangePlayback
{
    [self showLoadingAnimation];
}

-(void)playerDidEndChangePlayback
{
    [self hideLoadingAnimation];
}

-(void)playerDidFastforward:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}
-(void)playerDidRewind:(float)speed
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

#pragma mark - Handle touches
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerVC touchesBegan:touches withEvent:event];
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerVC touchesEnded:touches withEvent:event];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerVC touchesMoved:touches withEvent:event];
//}
//
//-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.playerVC touchesCancelled:touches withEvent:event];
//}
//
//#pragma mark - Handle motions
//
//-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    [self.playerVC motionBegan:motion withEvent:event];
//}
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    [self.playerVC motionEnded:motion withEvent:event];
//}
//-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    [self.playerVC motionCancelled:motion withEvent:event];
//}
//
//#pragma mark - Handle remote control
//
//-(void)remoteControlReceivedWithEvent:(UIEvent *)event
//{
//    [self.playerVC remoteControlReceivedWithEvent:event];
//}


@end
