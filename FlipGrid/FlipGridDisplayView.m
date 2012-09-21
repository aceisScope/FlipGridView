//
//  FlipGridDisplayView.m
//  FlipGrid
//
//  Created by B.H.Liu on 12-9-21.
//  Copyright (c) 2012年 B.H.Liu. All rights reserved.
//

#import "FlipGridDisplayView.h"
#import "FlipGridView.h"
#import "NSMutableArray+Shuffling.h"

#define GRID_WIDTH  145
#define GRID_HEIGHT 120
#define LEFT_MARGIN  10
#define HORIZONAL_PADDING  10

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface FlipGridDisplayView ()

@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation FlipGridDisplayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        self.flipViews = [NSMutableArray array];
        self.colors = [NSMutableArray arrayWithObjects:RGBA(233, 33, 33, 1.), RGBA(250, 216, 51, 1.),RGBA(32, 166, 243, 1.),RGBA(167, 18, 189, 1.),RGBA(68, 192, 19, 1.),RGBA(255, 115, 2, 1.),RGBA(236, 3, 211, 1.),RGBA(21, 63, 245, 1.),RGBA(103, 6, 202, 1.),nil];
        
        float VERTICAL_PADDING = 25;
        
        for (int i =0; i < 6; i ++)
        {
            FlipGridView *flipgrid = [[FlipGridView alloc]initWithFrame:CGRectMake(LEFT_MARGIN + i%2*(GRID_WIDTH+HORIZONAL_PADDING), i/2*(VERTICAL_PADDING+GRID_HEIGHT) + VERTICAL_PADDING, GRID_WIDTH, GRID_HEIGHT)];
            [self addSubview:flipgrid];
            [self.flipViews addObject:flipgrid];
        }
    }
    return self;
}

- (void)shuffelColors
{
    [self.colors shuffle];
}

- (void)setCurrentContentForGrids:(NSArray*)array
{
    for (int i=0; i< self.flipViews.count ; i++)
    {
        [(FlipGridView*)self.flipViews[i] setCuttrentContent:array[i] andBackgroundColor:self.colors[i]];
        
    }
}

- (void)updateContentAtIndex:(NSInteger)index withContent:(NSDictionary*)content
{
    [self.flipViews[index] setNextContent:content andBackgroundColor:self.colors[index]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
