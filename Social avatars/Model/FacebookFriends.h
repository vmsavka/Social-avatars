//
//  FacebookFriends.h
//  Facebook avatars
//
//  Created by Vasyl.Savka on 2/5/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerProtocol.h"
#import "FriendsViewController.h"
#import "FacebookFriendsProtocol.h"

@interface FacebookFriends : NSObject<FacebookFriendsProtocol>
{
    NSMutableArray * allFriends;
}

@property (strong, nonatomic) NSMutableArray *allFriends;
@property (strong, nonatomic) id<ViewControllerProtocol> delegate;
@property (strong, nonatomic) NSString * cache;
@property (nonatomic) BOOL isDownloaded;

- (void) getMineFriends;
- (void) showFriends;
- (NSMutableArray *) GetallFriends;
- (void) SetFacebookFriends:(NSMutableArray *)friends;
- (void) downloadLogo:(NSString *)pathCache :(int) numberLog;
- (NSString *)getCacheFolder;
- (void) refreshLogos;

@end
