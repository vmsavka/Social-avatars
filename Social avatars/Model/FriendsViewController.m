//
//  FriendsViewController.m
//  Social avatars
//
//  Created by Vasyl.Savka on 2/9/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import "FriendsViewController.h"

@implementation FriendsViewController

@synthesize timeZoneNames;
@synthesize allFacebookFriends;
@synthesize friendsTableView;
@synthesize delegate;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (delegate != nil) {
        self.allFacebookFriends=[delegate GetallFriends];
    }
    if ([delegate respondsToSelector:@selector(addFriendsDelegate:)]) {
        [delegate performSelector:@selector(addFriendsDelegate:)
                                              withObject:self];
    }
}

- (void) setImageToCell: (UIImage *)img : (int)row
{
    UITableViewCell *cell = [self.friendsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    [cell.imageView stopAnimating];
    cell.imageView.image = img;
}
- (void) refreshImage:(int) num
{
    UIImage * im = [UIImage imageWithContentsOfFile:[[delegate getCacheFolder] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.%@", num, @"jpg"]]];
    [self setImageToCell:im :num];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of time zone names.
    if (self.allFacebookFriends != nil) {
        return [self.allFacebookFriends count];}
    else {
        return 1;
    }
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    self.friendsTableView.allowsMultipleSelectionDuringEditing = editing;
    [super setEditing:editing animated:animated];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
NSLog(@"Table row %d has been tapped", indexPath.row);

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
if (!cell) {
cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
reuseIdentifier:MyIdentifier]; }
    
FBGraphObject *friendName = [((FacebookFriends* )self.delegate).allFriends objectAtIndex:indexPath.row];
cell.textLabel.text = [[friendName allValues] objectAtIndex:1];
   
    UIImage* loadGif = [UIImage animatedImageWithImages:[self getAnime] duration:1.0f];
    cell.imageView.image = loadGif;
cell.accessoryType = UITableViewCellAccessoryNone;
    
//[self.delegate downloadLogo:[self.delegate getCacheFolder] :indexPath.row];
return cell;
}

- (void) SetFacebookFriends:(FacebookFriends *)friends
{
    friends.delegate=self;
    self.delegate=friends;
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"second_to_third"])
    {
        if ([segue.destinationViewController respondsToSelector:@selector(SetSelectedItems::)]) {
                [segue.destinationViewController performSelector:@selector(SetSelectedItems::)
                                                      withObject:[self SelectedAvatars] withObject:[delegate getCacheFolder]];
            }

    }else if([segue.identifier isEqualToString:@"second_to_first"]){
        
    }
}
- (NSMutableArray *) SelectedAvatars
{
    NSMutableArray * selectedItems = [NSMutableArray new];
    for (int i=0; i<self.friendsTableView.indexPathsForVisibleRows.count; i++)
    {
        if ([[self.friendsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] accessoryType] == UITableViewCellAccessoryCheckmark)
        {
            [selectedItems addObject:[NSNumber numberWithInteger:i]];
        }
    }
    return selectedItems;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UIImageView*)getLoadAnimation {
    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    animatedImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"loading-gif-animation-1.tiff"],
                                         [UIImage imageNamed:@"loading-gif-animation-2.tiff"],
                                         [UIImage imageNamed:@"loading-gif-animation-3.tiff"],
                                         [UIImage imageNamed:@"loading-gif-animation-4.tiff"],
                                         [UIImage imageNamed:@"loading-gif-animation-5.tiff"],
                                         [UIImage imageNamed:@"loading-gif-animation-6.tiff"],
                                         [UIImage imageNamed:@"loading-gif-animation-7.tiff"],
                                         [UIImage imageNamed:@"loading-gif-animation-8.tiff"], nil];
    animatedImageView.animationDuration = 1.0f;
    animatedImageView.animationRepeatCount = 0;
    return animatedImageView;
}
- (NSArray *)getAnime
{
    NSArray * ar = [NSArray arrayWithObjects:
                    [UIImage imageNamed:@"loading-gif-animation-1.tiff"],
                    [UIImage imageNamed:@"loading-gif-animation-2.tiff"],
                    [UIImage imageNamed:@"loading-gif-animation-3.tiff"],
                    [UIImage imageNamed:@"loading-gif-animation-4.tiff"],
                    [UIImage imageNamed:@"loading-gif-animation-5.tiff"],
                    [UIImage imageNamed:@"loading-gif-animation-6.tiff"],
                    [UIImage imageNamed:@"loading-gif-animation-7.tiff"],
                    [UIImage imageNamed:@"loading-gif-animation-8.tiff"], nil];
    return ar;
}
@end