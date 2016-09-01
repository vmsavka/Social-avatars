//
//  ViewControllerProtocol.h
//  Social avatars
//
//  Created by Vasyl.Savka on 2/11/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerProtocol <NSObject>

@optional
- (bool) isActive;
- (void) refreshImage:(int) num;
@end
