//
//  CLPModalView.m
//  Clipp
//
//  Created by Craig Stanford on 30/01/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import "CLPModalView.h"
#import "CLPModalView_Private.h"
#import <QuartzCore/QuartzCore.h>

@interface CLPModalView ()

@property (nonatomic) BOOL onScreen;

@end

@implementation CLPModalView

- (id)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        self.title = title;
        self.animationSpeed = 0.4f;
    }
    return self;
}

- (void)loadView
{
    //We need to be in the Window, so we're above modally presented view controllers 
    CGRect frame = [[[UIApplication sharedApplication] keyWindow] bounds];
    //Adjust for the statusbar - this seems like a hack
    frame.size.height -= 20;
    frame.origin.y += 20;
    
    self.view = [[UIView alloc] initWithFrame:frame];
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.4f];
    self.backgroundView.alpha = 0.f;
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    tapGesture.cancelsTouchesInView = NO;
    [self.backgroundView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.backgroundView];
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(kGutterSize, -self.view.bounds.size.height, self.view.bounds.size.width - kGutterSize * 2, self.view.bounds.size.height - kGutterSize * 2)];
    [self.view addSubview:self.animationView];
    
    self.contentView = [[UIView alloc] initWithFrame:self.animationView.bounds];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    self.contentView.layer.cornerRadius = 5.f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.clipsToBounds = YES;
    
    [self.animationView addSubview:self.contentView];
    
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 44)];
    [self.navigationBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:self.title] animated:NO];
    [self.contentView addSubview:self.navigationBar];
    
}

- (void)show
{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] addChildViewController:self];
    [self moveOnScreenFromDirection:CLPModalDirectionTop];
}

- (void)moveOnScreenFromDirection:(CLPModalDirection)direction
{
    self.view.hidden = NO;
    CGRect animationFrame = self.animationView.frame;
    CGFloat targetY = MAX(kGutterSize, self.view.bounds.size.height / 2 - animationFrame.size.height / 2);
    CGFloat targetX = kGutterSize;
    CGFloat overshootY = kGutterSize;
    CGFloat overshootX = kGutterSize;
    //set the start frame
    switch (direction) {
        case CLPModalDirectionTop:
            animationFrame.origin.y = -self.view.frame.size.height;
            animationFrame.origin.x = kGutterSize;
            overshootY = targetY + kGutterSize;
            break;
        case CLPModalDirectionBottom:
            animationFrame.origin.y = self.view.frame.size.height;
            animationFrame.origin.x = kGutterSize;
            overshootY = targetY - kGutterSize;
            break;
        case CLPModalDirectionLeft:
            animationFrame.origin.y = kGutterSize;
            animationFrame.origin.x = -self.view.frame.size.width;
            overshootX = targetX + kGutterSize;
            break;
        case CLPModalDirectionRight:
            animationFrame.origin.y = kGutterSize;
            animationFrame.origin.x = self.view.frame.size.width;
            overshootX = targetX - kGutterSize;
            break;
        default:
            break;
    }
    self.animationView.frame = animationFrame;
    
    //set up the target frame to overshoot
    animationFrame.origin.y = overshootY;
    animationFrame.origin.x = overshootX;
    
    [UIView animateWithDuration:self.animationSpeed animations:^{
        self.backgroundView.alpha = 1.f;
        self.animationView.frame = animationFrame;
    } completion:^(BOOL finished) {
        CGRect finalAnimationFrame = self.animationView.frame;
        finalAnimationFrame.origin.y = targetY;
        finalAnimationFrame.origin.x = targetX;
        [UIView animateWithDuration:self.animationSpeed - 2.f animations:^{
            self.animationView.frame = finalAnimationFrame;
            self.onScreen = YES;
        }];
    }];
}

- (void)hide
{
    [self hideInDirection:CLPModalDirectionTop];
}

- (void)hideInDirection:(CLPModalDirection)direction
{
    [self moveOffScreenInDirection:direction
                        completion:^(BOOL finished) {
                            [self.view removeFromSuperview];
                            [self removeFromParentViewController];
                        }];
}

- (void)moveOffScreenInDirection:(CLPModalDirection)direction completion:(void (^)(BOOL))completion
{
    CGRect contentFrame = self.animationView.frame;
    switch (direction) {
        case CLPModalDirectionTop:
            contentFrame.origin.y = -self.view.bounds.size.height;
            break;
        case CLPModalDirectionBottom:
            contentFrame.origin.y = self.view.bounds.size.height;
            break;
        case CLPModalDirectionLeft:
            contentFrame.origin.x = -self.view.bounds.size.width;
            break;
        case CLPModalDirectionRight:
            contentFrame.origin.x = self.view.bounds.size.width;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:self.animationSpeed animations:^{
        self.backgroundView.alpha = 0.f;
        self.animationView.frame = contentFrame;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
        self.view.hidden = YES;
        self.onScreen = NO;
    }];
}

- (BOOL)isOnScreen
{
    if (self.onScreen && self.view.frame.origin.y < 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Gesture Recogniser

- (void)backgroundTapped:(UITapGestureRecognizer*)tapGesture
{
    [self hide];
}

@end
