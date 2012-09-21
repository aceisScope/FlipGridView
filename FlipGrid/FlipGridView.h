//
//  FlipGridView.h
//  FlipGrid
//
//  Created by B.H.Liu on 12-9-20.
//  Copyright (c) 2012年 B.H.Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipGridView : UIView
{
    UIView *currentView;
	UIView *nextView;
	
	CALayer *backgroundAnimationLayer;
	CALayer *flipAnimationLayer;
    
    float startFlipAngle;
	float endFlipAngle;
	float currentAngle;
    
	BOOL setNextViewOnCompletion;
	BOOL animating;
	
	BOOL disabled;
}

- (void)setCuttrentContent:(NSDictionary*)currentDict andBackgroundColor:(UIColor*)backgroudColor;
- (void)setNextContent:(NSDictionary*)nextDict andBackgroundColor:(UIColor*)backgroudColor;

@end
