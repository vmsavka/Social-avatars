//
//  FacebookFriendsProtocol.h
//  Social avatars
//
//  Created by Vasyl.Savka on 2/11/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FriendsViewController.h"
#import "ViewControllerProtocol.h"

@protocol FacebookFriendsProtocol <NSObject>

@optional
- (void) showFriends;
- (NSMutableArray *) GetallFriends;
- (void) SetFacebookFriends:(NSMutableArray *)friends;
- (void) downloadLogo:(NSString *)pathCache :(int) numberLog;
- (void) addFriendsDelegate: (id<ViewControllerProtocol>) fwc;
- (NSString *)getCacheFolder;
@end
