//
//  CLPPickerView.m
//  Clipp
//
//  Created by Craig Stanford on 26/01/13.
//  Copyright (c) 2013 Clipp Pty Ltd. All rights reserved.
//

#import "CLPPickerView.h"
#import "CLPModalView_Private.h"
#import <QuartzCore/QuartzCore.h>

#define kHeaderViewHeight 44

@interface CLPPickerView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) CLPPickerBlock completion;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) NSInteger scrollIndex;
@property (nonatomic, strong) UITableView* tableView;


@end

@implementation CLPPickerView

- (id)initWithTitle:(NSString *)title items:(NSArray *)items selectedIndex:(NSInteger)selectedIndex scrollIndex:(NSInteger)scrollIndex completion:(CLPPickerBlock)completion
{
    self = [super initWithTitle:title];
    if (self) {
        self.title = title;
        self.completion = completion;
        self.items = items;
        self.selectedIndex = selectedIndex;
        self.scrollIndex = scrollIndex;
        
        CGFloat height = MIN(self.view.bounds.size.height - kGutterSize * 2, self.items.count * 44 + kHeaderViewHeight);
        CGRect tableFrame = CGRectMake(kGutterSize, -self.view.bounds.size.height, self.view.bounds.size.width - kGutterSize * 2, height);
        self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.layer.cornerRadius = 5.f;
        self.tableView.layer.masksToBounds = YES;
        self.tableView.clipsToBounds = YES;
        self.tableView.backgroundColor = kCLPBlueColour;
        self.animationView = self.tableView;
        [self.view addSubview:self.animationView];
    }
    return self;
}

- (void)show
{
    [super show];
    
    if (self.selectedIndex >= 0) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    } else if (self.scrollIndex >= 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.scrollIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - kGutterSize * 2, kHeaderViewHeight)];
    UILabel* label = [[UILabel alloc] initWithFrame:view.frame];
    label.text = self.title;
    label.font = [UIFont systemFontOfSize:18.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kCLPGreyColour;
    label.backgroundColor = [UIColor whiteColor];
    [view addSubview:label];
    UIView* keyLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.bounds.size.height - 1, view.bounds.size.width, 1)];
    keyLine.backgroundColor = kCLPYellowColour;
    [view addSubview:keyLine];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = @"CLPPickerCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.items[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18.f];
    cell.textLabel.textColor = kCLPGreyColour;
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = kCLPBlueColour;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.completion(self.items[indexPath.row], indexPath.row);
    self.animationSpeed = self.animationSpeed * 0.75f;
    [self hideInDirection:CLPModalDirectionLeft];
}

@end
