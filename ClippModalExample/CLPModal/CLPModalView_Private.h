//
//  CLPModalView_Private.h
//  Clipp
//
//  Created by Craig Stanford on 30/01/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import "CLPModalView.h"
#define kCLPYellowColour [UIColor colorWithRed:250.f/255.f green:187.f/255.f blue:67.f/255.f alpha:1.f]
#define kCLPBlueColour [UIColor colorWithRed:38.f/255.f green:136.f/255.f blue:181.f/255.f alpha:1.f]
#define kCLPDarkBlueColour [UIColor colorWithRed:20.f/255.f green:117.f/255.f blue:161.f/255.f alpha:1.f]

#define kGutterSize 20

@interface CLPModalView ()

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UIView* backgroundView;
@property (nonatomic, strong) UINavigationBar* navigationBar;
@property (nonatomic) CGFloat animationSpeed;

- (void)hide;
- (void)hideInDirection:(CLPModalDirection)direction;
- (void)moveOffScreenInDirection:(CLPModalDirection)direction completion:(void (^)(BOOL))completion;
- (void)moveOnScreenFromDirection:(CLPModalDirection)direction;
- (id)initWithTitle:(NSString*)title;

@end
