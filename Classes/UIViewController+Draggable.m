//
//  UIViewController+Draggable.m
//  iOS Video Player
//
//  Created by Hai Kieu on 11/25/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import "UIViewController+Draggable.h"
#import <objc/runtime.h>



@implementation UIViewController (Draggable)

BOOL _enableOutOfBoundary;
BOOL _enableAutoReverse;
HKAutoReverseMode _reverseMode;

-(void)enableOutOfBoundary:(BOOL)enable
{
    _enableOutOfBoundary = enable;
}

-(void)enableAutoReversePostion:(BOOL)enable reserveMode:(HKAutoReverseMode)reverseMode
{
    _enableAutoReverse = enable;
    _reverseMode = reverseMode;
}

- (void)setPanGesture:(UIPanGestureRecognizer*)panGesture
{
	objc_setAssociatedObject(self, @selector(panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer*)panGesture
{
	return objc_getAssociatedObject(self, @selector(panGesture));
}

- (void)handlePan:(UIPanGestureRecognizer*)sender
{
	[self adjustAnchorPointForGestureRecognizer:sender];
	CGFloat topMargin = [UIApplication sharedApplication].isStatusBarHidden?0:20.;
	CGPoint translation = [sender translationInView:[self.view superview]];
    
    CGPoint currentLocation = self.view.center;
    CGPoint newLocation = CGPointMake([self.view center].x + translation.x, [self.view center].y + translation.y);
    
    CGPoint newRightDownBounadaryLocation = CGPointMake(CGRectGetMaxX(self.view.frame)+translation.x, CGRectGetMaxY(self.view.frame)+translation.y);
    CGPoint newTopLeftBounadaryLocation = CGPointMake(CGRectGetMinX(self.view.frame)+translation.x, CGRectGetMinY(self.view.frame)+translation.y-topMargin);
    
    if(CGRectContainsPoint(self.view.superview.frame, newRightDownBounadaryLocation)&&CGRectContainsPoint(self.view.superview.frame, newTopLeftBounadaryLocation))
    {
        [self.view setCenter:newLocation];
    }
    
	[sender setTranslation:(CGPoint){0, 0} inView:[self.view superview]];
    
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = self.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)setDraggable:(BOOL)draggable
{
	[self.panGesture setEnabled:draggable];
}

- (void)enableDragging
{
	self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.panGesture setMaximumNumberOfTouches:1];
	[self.panGesture setMinimumNumberOfTouches:1];
	[self.panGesture setCancelsTouchesInView:NO];
	[self.view addGestureRecognizer:self.panGesture];
}


@end
