//
//  UIView+NibLoading.h
//
//
//  Created by Matthew Hupman on 5/16/12.
//  Copyright (c) 2012 Citrrus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibLoading)

+ (UINib *)loadNib;
+ (UINib *)loadNibNamed:(NSString*)nibName;
+ (UINib *)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;
+ (instancetype)loadInstanceFromNib;
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

@end
