//
//  CLPModalView_Private.h
//  Clipp
//
//  Created by Craig Stanford on 30/01/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import "CLPModalView.h"

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
