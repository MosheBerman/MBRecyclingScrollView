//
//  RCRecyclableViewController.m
//  RecyclableCells
//
//  Created by Moshe Berman on 3/25/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "RCRecyclingScrollView.h"

@interface RCRecyclingScrollView ()

//
//  We need a pair of sets for visible/recycled views
//
//  If you wanted to keep identifiers, you might add
//  one pair per identifier
//

@property (nonatomic, strong) NSMutableSet *recycledViews;
@property (nonatomic, strong) NSMutableSet *visibleViews;

//
//  Keep track of where we are - we use this top determine
//  which views or cells we need to load offscreen (the ones
//  just beyond the edge.
//

@property (nonatomic, assign) NSUInteger index;

@end

@implementation RCRecyclingScrollView

- (void) initWithFrame
{
    _visibleViews = [[NSMutableSet alloc] init];
    _recycledViews = [[NSMutableSet alloc] init];
    _direction = @"horizontal";
    _index = 0;
    
    //
    //  Some scroll view configuration stuff
    //
    
    [self setPagingEnabled:YES];
    [self setShowsHorizontalScrollIndicator: NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setScrollsToTop: NO];
    [super setDelegate:self];
    
}



- (UIView *) dequeueViewAtIndex:(NSInteger)index
{
    
    UIView *aView = [[self recycledViews] anyObject];
    
    if (aView) {
        [[self recycledViews] removeObject:aView];
    }
    else
    {    
        //
        //  TODO: If you want to copy iOS6, you might instantiate a new UIView here.
        //  if not, this will be nil.
        //
    }
    
    return aView;
}

//
//  Determine if a view with a tag equal
//  to the current index is being shown
//

- (BOOL)isDisplayingViewForIndex:(NSUInteger)index{
    for (UIView *view in [self visibleViews]){
        if (view.tag == index){
            return YES;
        }
    }
    return NO;
}


#pragma mark - Load Views Into Scroller

- (void)reloadData{
    
    //
    //  Figure out which views we are showing
    //
    
    NSUInteger numberOfCells = [[self dataSource] numberOfCells];
    
    int firstNeededViewIndex = [self index]-1;
    int lastNeededViewIndex = [self index]+1;
    firstNeededViewIndex= MAX(firstNeededViewIndex, 0);
    lastNeededViewIndex = MIN(lastNeededViewIndex, numberOfCells - 1);
    
    //
    // Recycle no-longer-visible pages
    //
    
    for (UIView *view in [self visibleViews]) {
        if ([view tag] < firstNeededViewIndex || [view tag] > lastNeededViewIndex) {
            [[self recycledViews] addObject:view];
            [view removeFromSuperview];
        }
    }
    
    [[self visibleViews] minusSet:[self recycledViews]];
    
    //
    //  Load the views which we need to show
    //
    
    for (int index = firstNeededViewIndex; index <= lastNeededViewIndex; index++) {
        if (![self isDisplayingViewForIndex:index]) {
            
            UIView *viewToShow = [[self dataSource] scrollView:self viewAtIndex:index];
            [viewToShow setTag:index];
            
            if ([[self direction] isEqualToString:@"horizontal"]) {
                viewToShow.frame =  CGRectMake(viewToShow.tag*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            }else{
                viewToShow.frame =  CGRectMake(0, viewToShow.tag*self.frame.size.height, self.frame.size.width, self.frame.size.height);
            }
            
            [self addSubview:viewToShow];
            
            [[self visibleViews] addObject:viewToShow];
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
	//Calculate the current cell index
	if ([[self direction] isEqualToString:@"horizontal"]) {
		[self setIndex:(self.contentOffset.x/self.frame.size.width)];
	}else if ([[self direction] isEqualToString:@"vertical"]) {
		[self setIndex:(self.contentOffset.y/self.frame.size.height)];
	}
    
    //reload the necessary views
	[self reloadData];
}

@end
