//
//  CLPAlertView.m
//  Clipp
//
//  Created by Craig Stanford on 25/02/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import "CLPAlertView.h"
#import "CLPModalView_Private.h"
#import <QuartzCore/QuartzCore.h>

#define kGutter 10
#define kButtonHeight 44
#define kMessageFont [UIFont systemFontOfSize:18.f]
#define kButtonFont [UIFont systemFontOfSize:18.f]

@interface CLPAlertView ()

@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) UILabel* messageLabel;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) CLPVoidBlock cancelBlock;
@property (nonatomic, strong) UIButton* confirmButton;
@property (nonatomic, strong) CLPVoidBlock confirmBlock;


@end

@implementation CLPAlertView

+ (CLPAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message
{
    return [[CLPAlertView alloc] initWithTitle:title message:message];
}

- (id)initWithTitle:(NSString *)title message:(NSString*)message
{
    self = [super initWithTitle:title];
    if (self) {
        self.message = message;
    }
    return self;
}

- (CGFloat)messageHeight
{
    CGFloat height = [self.message sizeWithFont:kMessageFont constrainedToSize:CGSizeMake(self.contentView.frame.size.width - kGutter * 2, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height;
    return height;
}

- (void)loadView
{
    [super loadView];
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kGutter, ceilf(kGutter * 2 + self.navigationBar.frame.size.height), self.contentView.frame.size.width - kGutter * 2, [self messageHeight])];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.text = self.message;
    self.messageLabel.font = kMessageFont;
    self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.textColor = kCLPGreyColour;
    [self.contentView addSubview:self.messageLabel];
    
    CGFloat height = self.view.frame.size.height;
    CGRect frame = self.contentView.frame;
    frame.size.height = kGutter + self.messageLabel.frame.origin.y + self.messageLabel.frame.size.height + kGutter + kButtonHeight;
    frame.origin.y = height / 2 - frame.size.height / 2;
    self.contentView.frame = frame;
    
    self.contentView.layer.borderColor = [kCLPYellowColour CGColor];
    self.contentView.layer.borderWidth = 1.f;
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(CLPVoidBlock)block
{
    [self view];    
    [self.cancelButton removeFromSuperview];
    
    self.cancelBlock = block;
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(kGutter, [self messageHeight] + self.navigationBar.frame.size.height + kGutter * 3, self.contentView.frame.size.width - kGutter * 2, 44)];
    [self.cancelButton setTitle:title forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:kCLPBlueColour forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:kCLPDarkBlueColour forState:UIControlStateHighlighted];
    self.cancelButton.titleLabel.font = kButtonFont;
    self.cancelButton.backgroundColor = [UIColor clearColor];
    [self.cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.cancelButton];
}

- (void)cancelPressed:(id)sender
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self hide];
}

- (void)setConfirmButtonWithTitle:(NSString *)title block:(CLPVoidBlock)block
{
    [self view];
    [self.confirmButton removeFromSuperview];
    
    self.confirmBlock = block;

    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(kGutter, [self messageHeight] + self.navigationBar.frame.size.height + kGutter * 3, self.contentView.frame.size.width - kGutter * 2, 44)];
    [self.confirmButton setTitle:title forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:kCLPBlueColour forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:kCLPDarkBlueColour forState:UIControlStateHighlighted];
    self.confirmButton.titleLabel.font = kButtonFont;
    self.confirmButton.backgroundColor = [UIColor clearColor];
    [self.confirmButton addTarget:self action:@selector(confirmPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.confirmButton];
}

- (void)confirmPressed:(id)sender
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    [self hide];
}

- (void)show
{
    if (self.confirmButton && self.cancelButton) {
        CGFloat width = (self.contentView.frame.size.width - kGutter * 3) / 2;
        CGFloat confirmX = width + kGutter * 2;
        
        CGRect confirmFrame = self.confirmButton.frame;
        confirmFrame.size.width = width;
        confirmFrame.origin.x = confirmX;
        self.confirmButton.frame = confirmFrame;
        
        CGRect cancelFrame = self.cancelButton.frame;
        cancelFrame.size.width = width;
        self.cancelButton.frame = cancelFrame;
    }
    
    [super show];
}

@end
