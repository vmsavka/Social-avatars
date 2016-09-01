//
//  FacebookFriends.m
//  Facebook avatars
//
//  Created by Vasyl.Savka on 2/5/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import "FacebookFriends.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"


@implementation FacebookFriends

@synthesize allFriends;
@synthesize delegate;
@synthesize cache;
@synthesize isDownloaded;

- (void) getMineFriends
{
    self.isDownloaded=FALSE;
    [FBRequestConnection startWithGraphPath:@"/me/taggable_friends"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              NSArray *friendList = [result objectForKey:@"data"];
                              self.allFriends = [NSMutableArray new];
                              [self.allFriends addObjectsFromArray: friendList];
                              [self showFriends];
                              
                              cache = [self createCacheFolder];
                              [self downloadLogos:self.cache];
                          }];
}
- (void) showFriends
{
    /*FriendsViewController * friends_view =[FriendsViewController new];
    friends_view.allFacebookFriends = allFriends;
    friends_view.delegate=self;
    [friends_view setDataToViewController];
    [[(UIViewController* )self.delegate navigationController] pushViewController:friends_view animated:YES];*/
    [(UIViewController* )self.delegate performSegueWithIdentifier:@"first_to_second" sender:nil];
}
- (NSMutableArray *) GetallFriends
{
    return allFriends;
}
- (void) SetFacebookFriends:(NSMutableArray *)friends
{
    allFriends=friends;
}
- (NSString *) createCacheFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    cachePath =[cachePath  stringByAppendingString:@"/Social_Avatars"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath])
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
    
    return cachePath;
}
- (void) downloadLogos:(NSString *)pathCache
{
    NSURLRequest *requestURL;
    NSURL * URL;
    FBGraphObject *friendName = [[FBGraphObject alloc] init];
    for (int i=0; i<allFriends.count; i++)
    {
        friendName = [self.allFriends objectAtIndex:i];
        URL = [NSURL URLWithString:[[(FBGraphObject *)[[(FBGraphObject *)[[friendName allValues] objectAtIndex:2] allValues] objectAtIndex:0] allValues] objectAtIndex:0]];
        requestURL = [NSURLRequest requestWithURL:URL];
        
        [NSURLConnection sendAsynchronousRequest:requestURL
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 //When Json request complite then call this block
                 UIImage* image = [[UIImage alloc] initWithData:data];
                 [self saveImage:image withFileName:[NSString stringWithFormat:@"%d", i] ofType:@"jpg" inDirectory:cache];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self.delegate refreshImage:i];

                 });
             });
         }];
    }
    self.isDownloaded=TRUE;
}
- (void) refreshLogos
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    for (int i=0; i<allFriends.count; i++)
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.delegate refreshImage:i];
        });
    }
    });
}
- (void) downloadLogo:(NSString *)pathCache :(int) numberLog
{
    NSURLRequest *requestURL;
    NSURL * URL;
    FBGraphObject *friendName = [[FBGraphObject alloc] init];
        friendName = [self.allFriends objectAtIndex:numberLog];
        URL = [NSURL URLWithString:[[(FBGraphObject *)[[(FBGraphObject *)[[friendName allValues] objectAtIndex:2] allValues] objectAtIndex:0] allValues] objectAtIndex:0]];
        requestURL = [NSURLRequest requestWithURL:URL];
        
        [NSURLConnection sendAsynchronousRequest:requestURL
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             //When Json request complite then call this block
             UIImage* image = [[UIImage alloc] initWithData:data];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self saveImage:image withFileName:[NSString stringWithFormat:@"%d", numberLog] ofType:@"jpg" inDirectory:cache];
                 [self.delegate refreshImage:numberLog];
             });

             
         }];
}
- (NSString *)getCacheFolder
{
    return cache;
}
-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}
- (void) addFriendsDelegate: (FriendsViewController *) fwc
{
    delegate=(FriendsViewController *)fwc;
}
@end
