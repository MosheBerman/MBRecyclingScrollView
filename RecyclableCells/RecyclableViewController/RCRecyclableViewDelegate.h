//
//  RCRecyclableViewDelegate.h
//  RecyclableCells
//
//  Created by Moshe Berman on 3/25/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCRecyclingScrollView;

@protocol RCRecyclingScrollViewDelegate <NSObject>
- (void)scrollView:(RCRecyclingScrollView *)tableView didSelectCellAtIndex:(NSUInteger)integer;
@end
