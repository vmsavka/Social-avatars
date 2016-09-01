//
//  ViewController.h
//  Social avatars
//
//  Created by Vasyl.Savka on 2/6/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#include "FacebookFriends.h"
#include "ViewControllerProtocol.h"
#include "FriendsViewController.h"
@interface ViewController : UIViewController <ViewControllerProtocol>
{
    FBLoginView *loginView;
    FacebookFriends * facebookFriends;
    
}
@property (nonatomic, strong) FBLoginView * LOGINVIEW;
@property (nonatomic, strong) FacebookFriends *facebookFriends;
@end

