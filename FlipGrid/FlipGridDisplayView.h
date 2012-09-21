//
//  FlipGridDisplayView.h
//  FlipGrid
//
//  Created by B.H.Liu on 12-9-21.
//  Copyright (c) 2012年 B.H.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipGridView.h"

@interface FlipGridDisplayView : UIView

@property (nonatomic, strong) NSMutableArray *flipViews;

- (void)shuffelColors;
- (void)setCurrentContentForGrids:(NSArray*)array;
- (void)updateContentAtIndex:(NSInteger)index withContent:(NSDictionary*)content;

@end
