//
//  HKVideoPlayerException.h
//  iOS Video Player
//
//  Created by Hai Kieu on 11/23/14.
//  Copyright (c) 2014 haikieu2907@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET() [HKVideoPlayerException notImplementedYetExceptionAtFunction:__PRETTY_FUNCTION__]

#define HKPLAYER_THROWS_EXCEPTION_NOT_IMPLEMENTED_YET(message) [HKVideoPlayerException notImplementedYetExceptionAtFunction:__PRETTY_FUNCTION__]

@interface HKVideoPlayerException : NSException

+(void) notImplementedYetExceptionAtFunction:(const char*) function;
+(void) notImplementedYetExceptionAtFunction:(const char*) function withMessage:(NSString *)message;
@end
