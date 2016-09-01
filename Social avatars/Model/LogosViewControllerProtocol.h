//
//  LogosViewControllerProtocol.h
//  Social avatars
//
//  Created by Vasyl.Savka on 2/16/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LogosViewControllerProtocol <NSObject>

@optional
- (void) SetSelectedItems: (NSMutableArray *)selItems : (NSString *) imPath;
- (UIView *)viewFromController;


@end
