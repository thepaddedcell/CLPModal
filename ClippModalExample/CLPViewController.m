//
//  CLPViewController.m
//  ClippModalExample
//
//  Created by Craig Stanford on 4/04/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "CLPViewController.h"
#import "CLPAlertView.h"
#import "CLPPickerView.h"

@interface CLPViewController ()

- (IBAction)alertViewPressed:(id)sender;
- (IBAction)pickerViewPressed:(id)sender;

@end

@implementation CLPViewController

- (void)alertViewPressed:(id)sender
{
    //If you're using a CLPAlertView, I'd recommend Appearance Proxying the UINavigationBar class
    CLPAlertView* alert = [CLPAlertView alertWithTitle:@"Alert!" message:@"This is an alert view"];
    [alert setConfirmButtonWithTitle:@"Confirm" block:^{
        //Go do stuff
    }];
    [alert setCancelButtonWithTitle:@"Cancel" block:^{
        //maybe don't do stuff
    }];
    [alert show];
}

- (void)pickerViewPressed:(id)sender
{
    CLPPickerView* picker = [[CLPPickerView alloc] initWithTitle:@"Picker View" items:@[@"One", @"Two", @"Three", @"Four"] selectedIndex:-1 scrollIndex:0 completion:^(NSString *value, NSInteger index) {
       //This is what happens when an item is picked
    }];
    [picker show];
}

@end
