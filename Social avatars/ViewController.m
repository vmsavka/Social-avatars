//
//  ViewController.m
//  Social avatars
//
//  Created by Vasyl.Savka on 2/6/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

NSArray *tableData;
@synthesize LOGINVIEW;
@synthesize facebookFriends;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NSCache funew;
    LOGINVIEW =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];
    LOGINVIEW.center = self.view.center;
    LOGINVIEW.frame = CGRectMake(0, self.view.center.y/2, self.view.frame.size.width, self.view.frame.size.height/3);
    [self.view addSubview:LOGINVIEW];
    //[self.view addConstraints:[NSLayoutConstraint
    //                           constraintsWithVisualFormat:@"V:|-[LOGINVIEW(<=100)]-|"
    //                           options:NSLayoutFormatDirectionLeadingToTrailing
    //                           metrics:nil
    //                           views:NSDictionaryOfVariableBindings(LOGINVIEW)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"first_to_second"])
    {
        if (facebookFriends != nil)
        {
            if (facebookFriends.isDownloaded==TRUE){
                [facebookFriends refreshLogos];
            }
            if ([segue.destinationViewController respondsToSelector:@selector(SetFacebookFriends:)]) {
                [segue.destinationViewController performSelector:@selector(SetFacebookFriends:)
                                                      withObject:facebookFriends];
            }
        }

        //Retrieve the array of known time zone names, then sort the array and pass it to the root view controller.
    }else if([segue.identifier isEqualToString:@"second_to_first"]){
        
    }
    else if ([segue.destinationViewController isEqualToString:@"third"])//@"second_to_third"])
    {
        NSLog(@"/n second_to_third");
    }
}
- (IBAction)toughtFriens {
    facebookFriends = [FacebookFriends new];
    facebookFriends.delegate=self;
    [facebookFriends getMineFriends];
}
@end
