//
//  RCRecyclableViewDataSource.h
//  RecyclableCells
//
//  Created by Moshe Berman on 3/25/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCRecyclingScrollView;

@protocol RCRecyclingScrollViewDataSource <NSObject>

- (NSInteger)numberOfCells;
- (UIView *)scrollView:(RCRecyclingScrollView *)scrollView viewAtIndex:(NSUInteger)index;

@end