//
//  LogosViewController.m
//  Social avatars
//
//  Created by Vasyl.Savka on 2/16/15.
//  Copyright (c) 2015 Vasyl.Savka. All rights reserved.
//

#import "LogosViewController.h"

@implementation LogosViewController

@synthesize selectedItems;
@synthesize cacheFolder;
@synthesize viewFriendsLogos;

@synthesize toughtedView;
@synthesize subView;
@synthesize touchNum;

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self subviewOper];
    //[self ShowFriendsLogos];
    //[self addViewToRecognizer:self.view];
    self.touchNum=0;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)subviewOper{
    subView = [[LogosImageSubview alloc] init];
    subView.logosDelegate=self;
    [subView ShowFriendsLogos];
    [subView addViewToRecognizer:self.view];
}
- (UIView *)viewFromController
{
    return viewFriendsLogos;
}
- (void) SetSelectedItems: (NSMutableArray *)selItems : (NSString *) imPath
{
    selectedItems=selItems;
    cacheFolder = imPath;
}
- (void) ShowFriendsLogos
{
    for (int num = 0; num< selectedItems.count; num++)
    {
        UIImage * im = [UIImage imageWithContentsOfFile:[cacheFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", (NSNumber*)[selectedItems objectAtIndex:num], @"jpg"]]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage: im];
        imageView.frame = CGRectMake(imageView.frame.size.width*2+arc4random_uniform(viewFriendsLogos.frame.size.width-4*imageView.frame.size.width),
                                     imageView.frame.size.height*2+arc4random_uniform(viewFriendsLogos.frame.size.height-4*imageView.frame.size.height),
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
        
        [self.viewFriendsLogos addSubview: imageView];
    }
}
- (void) addViewToRecognizer:(UIView *) recView
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    
    [recView addGestureRecognizer:panRecognizer];
    [recView addGestureRecognizer:pinchRecognizer];
    [recView addGestureRecognizer:rotationRecognizer];

    tapRecognizer.numberOfTapsRequired = 2;
    [recView addGestureRecognizer:tapRecognizer];
    
    panRecognizer.delegate = self;
    pinchRecognizer.delegate = self;
    rotationRecognizer.delegate = self;
}

#pragma mark - Gesture Recognizers
- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    if (self.touchNum ==1){
    CGPoint translation = [panRecognizer translationInView:self.view];
    CGPoint imageViewPosition = self.toughtedView.center;
    imageViewPosition.x += translation.x;
    imageViewPosition.y += translation.y;
    
    self.toughtedView.center = imageViewPosition;
    [panRecognizer setTranslation:CGPointZero inView:self.view];
    }
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    if (self.touchNum > 0) {
    CGFloat scale = pinchRecognizer.scale;
    self.toughtedView.transform = CGAffineTransformScale(self.toughtedView.transform, scale, scale);
    pinchRecognizer.scale = 1.0;
    }
}
- (void)rotationDetected:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle = rotationRecognizer.rotation;
    self.toughtedView.transform = CGAffineTransformRotate(self.toughtedView.transform, angle);
    rotationRecognizer.rotation = 0.0;
}
- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        self.toughtedView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
        self.toughtedView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(IBAction)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //UITouchPhase
    
    if (touch.view != self.view)    {
        self.toughtedView=touch.view;
        self.touchNum=1;
    }
    else
    {
        if (self.touchNum == 1) {
            self.touchNum++;
        }
        else if (self.touchNum==2){
            self.touchNum=0;
        }
    }
}

@end
