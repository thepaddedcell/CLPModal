//
//  CLPAlertView.h
//  Clipp
//
//  Created by Craig Stanford on 25/02/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import "CLPModalView.h"

typedef void (^CLPVoidBlock)(void);

@interface CLPAlertView : CLPModalView

+ (CLPAlertView*)alertWithTitle:(NSString*)title message:(NSString*)message;

- (id)initWithTitle:(NSString *)title message:(NSString*)message;

- (void)setCancelButtonWithTitle:(NSString*)title block:(CLPVoidBlock)block;
- (void)setConfirmButtonWithTitle:(NSString*)title block:(CLPVoidBlock)block;

@end
