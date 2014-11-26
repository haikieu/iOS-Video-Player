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

@implementation HKVideoPlayerDefaultTheme

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    topBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self addSubview:topBar];
    
    bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
    bottomBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [self addSubview:bottomBar];
}

-(void)showThemeView:(BOOL)animated
{
        self.hidden = NO;
        topBar.transform = CGAffineTransformTranslate(topBar.transform, 0, -topBar.bounds.size.height);
        topBar.alpha=0;
        bottomBar.transform = CGAffineTransformTranslate(bottomBar.transform, 0, bottomBar.bounds.size.height);
        bottomBar.alpha=0;
        
        [UIView animateWithDuration:animated?1:0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            topBar.alpha=1;
            topBar.transform = CGAffineTransformIdentity;
            bottomBar.alpha=1;
            bottomBar.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
}

-(void)hideThemeView:(BOOL)animated
{
    
    topBar.alpha=1;
    
    bottomBar.alpha=1;
    topBar.transform = CGAffineTransformIdentity;
    bottomBar.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:animated?1:0 animations:^{
        topBar.alpha=0;
        topBar.transform = CGAffineTransformTranslate(topBar.transform, 0, -topBar.bounds.size.height);
        bottomBar.alpha=0;
        bottomBar.transform = CGAffineTransformTranslate(bottomBar.transform, 0, bottomBar.bounds.size.height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(BOOL)playerShouldDraggableAtPosition:(CGPoint)postion
{
    return !topBar.hidden && CGRectContainsPoint(topBar.frame, postion);
}
-(void)playerDidPlay
{
  
}

-(UIEdgeInsets)playerGetConfigInsets
{
    return UIEdgeInsetsMake(50, 0, 50, 0);
}

-(void)setEventHandler
{
    
}

@end
