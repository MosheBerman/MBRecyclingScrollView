//
//  RCRecyclableViewController.h
//  RecyclableCells
//
//  Created by Moshe Berman on 3/25/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>

//
//  These guys are modelled after UITableView, but support only single
//  indices, in liue of index paths.
//

#import "RCRecyclableViewDataSource.h"
#import "RCRecyclableViewDelegate.h"

@protocol RCRecyclingScrollViewDataSource;
@protocol RCRecyclingScrollViewDelegate;

@interface RCRecyclingScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) id<RCRecyclingScrollViewDelegate> recycleDelegate;
@property (nonatomic, assign) id<RCRecyclingScrollViewDataSource> dataSource;

//
//  A string, which adds bidirectional support
//  can be @"vertical" or @"horizontal"

//

@property (nonatomic, strong) NSString *direction;

- (UIView *)dequeueViewAtIndex:(NSInteger)index;
- (void) reloadData;

@end
