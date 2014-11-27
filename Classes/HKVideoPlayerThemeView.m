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

+(HKVideoPlayerThemeView *)theme
{
    return [self new];
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
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

-(void)hideLoadingAnimation
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
}

#pragma mark - HKVideoPlayerEvent Config

-(UIEdgeInsets)playerGetConfigInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - HKVideoPlayerEvent Pre

-(BOOL)themeViewAllowResizeWithFrame:(CGRect)frame
{
    return YES;
}

-(BOOL)themeViewAllowDraggableAtPosition:(CGPoint)postion
{
    return CGRectContainsPoint(self.frame, postion);
}

-(BOOL)themeViewNeedClipsToBounds
{
    return self.clipsToBounds;
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

#pragma mark - HKVideoPlayerEvent Post

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

-(void)playerDidRenderView
{
    HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET();
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
