//
//  CLPModalView.h
//  Clipp
//
//  Created by Craig Stanford on 30/01/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CLPModalDirectionLeft,
    CLPModalDirectionRight,
    CLPModalDirectionBottom,
    CLPModalDirectionTop,
    CLPModalDirectionDefault = CLPModalDirectionTop
} CLPModalDirection;

@interface CLPModalView : UIViewController

@property (nonatomic, strong) UIView* animationView;
@property (nonatomic, strong) UIView* contentView;

- (void)show;
- (BOOL)isOnScreen;

@end
