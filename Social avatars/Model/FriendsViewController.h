//
//  FriendsViewController.h
//  Social avatars
//
//  Created by Vasyl.Savka on 2/9/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "ViewControllerProtocol.h"
#import "LogosViewControllerProtocol.h"
#import "FacebookFriendsProtocol.h"
#import "FacebookFriends.h"

@interface FriendsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ViewControllerProtocol>
{
}
@property (nonatomic) NSArray *timeZoneNames;
@property (strong, nonatomic) IBOutlet UITableView *friendsTableView;
@property (strong, nonatomic) NSMutableArray * allFacebookFriends;
@property (strong, nonatomic) id<FacebookFriendsProtocol> delegate;

- (void) SetFacebookFriends:(NSMutableArray *)friends;
- (void) setImageToCell: (UIImage *)img : (int)row;
- (void) refreshImage:(int) num;

@end
