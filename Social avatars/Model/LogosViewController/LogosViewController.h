//
//  LogosViewController.h
//  Social avatars
//
//  Created by Vasyl.Savka on 2/16/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogosViewControllerProtocol.h"
#import "LogosImageSubview.h"

@interface LogosViewController : UIViewController <LogosViewControllerProtocol, UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableArray * selectedItems;
@property (strong, nonatomic) NSString * cacheFolder;
@property (strong, nonatomic) IBOutlet UIView *viewFriendsLogos;

@property (strong, nonatomic) LogosImageSubview * subView;
@property (strong, nonatomic) UIView *toughtedView;
@property (nonatomic) float touchNum;

- (void) SetSelectedItems: (NSMutableArray *)selItems : (NSString *)imPath;
- (UIView *)viewFromController;

@end
