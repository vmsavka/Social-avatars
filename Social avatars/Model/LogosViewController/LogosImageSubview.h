//
//  LogosImageSubview.h
//  Social avatars
//
//  Created by Vasyl.Savka on 2/17/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogosViewControllerProtocol.h"

@interface LogosImageSubview : UIImageView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView * logoView;
@property (strong, nonatomic) id<LogosViewControllerProtocol> logosDelegate;
@property (nonatomic) Point * position;


-(void)setImageFromPath:(NSString* )cacheFold withNumb: (int )imPath;
- (void) addViewToRecognizer:(UIView *) recView;
- (void) ShowFriendsLogos;
@end
