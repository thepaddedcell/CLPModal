//
//  CLPPickerView.h
//  Clipp
//
//  Created by Craig Stanford on 26/01/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLPModalView.h"

typedef void (^CLPPickerBlock)(NSString* value, NSInteger index);

@interface CLPPickerView : CLPModalView

- (id)initWithTitle:(NSString*)title items:(NSArray*)items selectedIndex:(NSInteger)selectedIndex scrollIndex:(NSInteger)scrollIndex completion:(CLPPickerBlock)completion;
//- (void)show;

@end
