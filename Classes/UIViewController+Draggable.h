//
//  UIViewController+Draggable.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/25/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HKAutoReverseMode) {
    HKAutoReverseToOriginalPosition,
    HKAutoReverseToBoundaryPosition
};

@interface UIViewController (Draggable)

/**-----------------------------------------------------------------------------
 * @name UIView+draggable Properties
 * -----------------------------------------------------------------------------
 */

/** The pan gestures that handles the view dragging
 *
 * @param panGesture The tint color of the blurred view. Set to nil to reset.
 */
@property (nonatomic) UIPanGestureRecognizer *panGesture;

/**-----------------------------------------------------------------------------
 * @name UIView+draggable Methods
 * -----------------------------------------------------------------------------
 */

/** Enables the dragging
 *
 * Enables the dragging state of the view
 */

- (void)enableDragging;

/** Disable or enable the view dragging
 *
 * @param draggable The boolean that enables or disables the draggable state
 */
- (void)setDraggable:(BOOL)draggable;

-(void)enableOutOfBoundary:(BOOL)enable;
-(void)enableAutoReversePostion:(BOOL) enable reserveMode:(HKAutoReverseMode) reverseMode;

@end
