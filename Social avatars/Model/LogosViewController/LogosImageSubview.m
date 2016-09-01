//
//  LogosImageSubview.m
//  Social avatars
//
//  Created by Vasyl.Savka on 2/17/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import "LogosImageSubview.h"
#import "LogosViewController.h"

@implementation LogosImageSubview

@synthesize logoView;
@synthesize logosDelegate;
@synthesize position;

-(void)viewDidLoad{
    
    logoView=[UIImageView new];
    //[self addViewToRecognizer:((LogosViewController *)logosDelegate).view];
}

-(void)setImageFromPath:(NSString* )cacheFold withNumb: (int )imPath;
{
     UIImage* image = [UIImage imageWithContentsOfFile:[cacheFold stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.%@", imPath, @"jpg"]]];
    logoView = [[UIImageView alloc] initWithImage:image];

    [self setImage:image];
    self.frame = CGRectMake(logoView.frame.size.width*2+arc4random_uniform([logosDelegate viewFromController].frame.size.width-4*logoView.frame.size.width),
                                 logoView.frame.size.height*2+arc4random_uniform([logosDelegate viewFromController].frame.size.height-4*logoView.frame.size.height),
                                 logoView.frame.size.width*2,
                                 logoView.frame.size.height*2);
    logoView.frame=self.frame;

    [self.layer setCornerRadius:self.frame.size.height/2];
    self.layer.masksToBounds=YES;
    [((LogosViewController *)logosDelegate).viewFriendsLogos addSubview:self];
}
//copied
- (void) ShowFriendsLogos
{
    for (int num = 0; num< ((LogosViewController *)logosDelegate).selectedItems.count; num++)
    {
        UIImage * im = [UIImage imageWithContentsOfFile:[((LogosViewController *)logosDelegate).cacheFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", (NSNumber*)[((LogosViewController *)logosDelegate).selectedItems objectAtIndex:num], @"jpg"]]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage: im];
        imageView.frame = CGRectMake(imageView.frame.size.width*2+arc4random_uniform(((LogosViewController *)logosDelegate).viewFriendsLogos.frame.size.width-4*imageView.frame.size.width),
                                     imageView.frame.size.height*2+arc4random_uniform(((LogosViewController *)logosDelegate).viewFriendsLogos.frame.size.height-4*imageView.frame.size.height),
                                     imageView.frame.size.width*2,
                                     imageView.frame.size.height*2);
        // border radius
        float b=imageView.frame.size.height/2;
        [imageView.layer setCornerRadius:b];
        imageView.layer.masksToBounds=YES;
        
        // border
        //[imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        //[imageView.layer setBorderWidth:1.5f];
        
        // drop shadow
        [imageView.layer setShadowColor:[UIColor blackColor].CGColor];
        [imageView.layer setShadowOpacity:0.8];
        [imageView.layer setShadowRadius:1.0];
        [imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        imageView.userInteractionEnabled=YES;
        [imageView setMultipleTouchEnabled:YES];
        
        [((LogosViewController *)logosDelegate).viewFriendsLogos addSubview: imageView];
    }
}
- (void) addViewToRecognizer:(UIView *) recView
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:((LogosViewController *)logosDelegate) action:@selector(panDetected:)];
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:((LogosViewController *)logosDelegate) action:@selector(pinchDetected:)];
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:((LogosViewController *)logosDelegate) action:@selector(rotationDetected:)];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:((LogosViewController *)logosDelegate) action:@selector(tapDetected:)];
    
    [recView addGestureRecognizer:panRecognizer];
    [recView addGestureRecognizer:pinchRecognizer];
    [recView addGestureRecognizer:rotationRecognizer];
    
    tapRecognizer.numberOfTapsRequired = 2;
    [recView addGestureRecognizer:tapRecognizer];
    
    panRecognizer.delegate = ((LogosViewController *)logosDelegate);
    pinchRecognizer.delegate = ((LogosViewController *)logosDelegate);
    rotationRecognizer.delegate = ((LogosViewController *)logosDelegate);
}
#pragma mark - Gesture Recognizers
- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    if (((LogosViewController *)logosDelegate).touchNum ==1){
        CGPoint translation = [panRecognizer translationInView:((LogosViewController *)logosDelegate).view];
        CGPoint imageViewPosition = ((LogosViewController *)logosDelegate).toughtedView.center;
        imageViewPosition.x += translation.x;
        imageViewPosition.y += translation.y;
        
        ((LogosViewController *)logosDelegate).toughtedView.center = imageViewPosition;
        [panRecognizer setTranslation:CGPointZero inView:((LogosViewController *)logosDelegate).view];
    }
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    if (((LogosViewController *)logosDelegate).touchNum > 0) {
        CGFloat scale = pinchRecognizer.scale;
        ((LogosViewController *)logosDelegate).toughtedView.transform = CGAffineTransformScale(((LogosViewController *)logosDelegate).toughtedView.transform, scale, scale);
        pinchRecognizer.scale = 1.0;
    }
}
- (void)rotationDetected:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle = rotationRecognizer.rotation;
    ((LogosViewController *)logosDelegate).toughtedView.transform = CGAffineTransformRotate(((LogosViewController *)logosDelegate).toughtedView.transform, angle);
    rotationRecognizer.rotation = 0.0;
}
- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        ((LogosViewController *)logosDelegate).toughtedView.center = CGPointMake(CGRectGetMidX(((LogosViewController *)logosDelegate).view.bounds),
                                                                                 CGRectGetMidY(((LogosViewController *)logosDelegate).view.bounds));
        ((LogosViewController *)logosDelegate).toughtedView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
@end
