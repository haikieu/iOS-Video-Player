//
//  HKUtility.h
//  iOS Video Player
//
//  Created by Hai Kieu on 12/27/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEVICE_IS_IPHONE() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
#define DEVICE_IS_IPAD() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)

#define SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface HKUtility : NSObject

+(NSString*) iOSVersion;
+(UIDeviceOrientation) currentOrientation;

@end
