//
//  ViewController.m
//  FlipGrid
//
//  Created by B.H.Liu on 12-9-20.
//  Copyright (c) 2012年 B.H.Liu. All rights reserved.
//

#import "ViewController.h"
#import "FlipGridView.h"
#import "FlipGridDisplayView.h"

@interface ViewController ()

@property (nonatomic, strong) FlipGridDisplayView * flipGridDisplay;

@end

@implementation ViewController
{
    int currentGridIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.    
    self.flipGridDisplay = [[FlipGridDisplayView alloc] initWithFrame:self.view.frame];
    self.flipGridDisplay.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.flipGridDisplay];
    
    [self.flipGridDisplay shuffelColors];
    [self.flipGridDisplay setCurrentContentForGrids:nil];
    
    [self.flipGridDisplay shuffelColors];
    currentGridIndex = 0;
    for (int i = 0; i< 6; i++)
    {
        currentGridIndex = i;
        [self performSelector:@selector(updateGrid:) withObject:@(currentGridIndex) afterDelay:((int)(log(1.+i)/log(2.)))*1.5 + (1.*arc4random()/INT_MAX)*0.3 + i*0.1];
    }
}

- (void)updateGrid:(NSNumber*)index
{
    [self.flipGridDisplay updateContentAtIndex:[index intValue] withContent:[NSDictionary dictionaryWithObjectsAndKeys:@"Schlange",@"topic",@"@JrdnChase Keine Ahnung, was die Karten angeht, ich stehe selbst nicht. Bin auf dem Weg zum Büro an der Schlange vorbei gekommen.",@"text", nil]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
