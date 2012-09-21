//
//  FlipGridView.m
//  FlipGrid
//
//  Created by B.H.Liu on 12-9-20.
//  Copyright (c) 2012年 B.H.Liu. All rights reserved.
//

#import "FlipGridView.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark -
#pragma mark UIView helpers


@interface UIView(Extended)

- (UIImage *) imageByRenderingView;

@end


@implementation UIView(Extended)


- (UIImage *) imageByRenderingView
{
    CGFloat oldAlpha = self.alpha;
    self.alpha = 1;
    UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    self.alpha = oldAlpha;
	return resultingImage;
}

@end

#pragma mark -
#pragma mark Private interface

@interface FlipGridView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@property (nonatomic,strong) UIView *currentView;
@property (nonatomic,strong) UIView *nextView;

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIColor *nextColor;

@end

@implementation FlipGridView

@synthesize currentView=_currentView;
@synthesize nextView=_nextView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:_tapRecognizer];
        
    }
    return self;
}

- (void)randomization:(UIView*)contentView
{
    UILabel *topicLabel;
    UILabel *tweetLabel;

    topicLabel = (UILabel*)[contentView viewWithTag:1000];
    tweetLabel = (UILabel*)[contentView viewWithTag:1001];
    
    
    BOOL direction = (((arc4random() % ((unsigned)RAND_MAX + 1))) %5 == 0);
    topicLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"label_%d.png",direction]]];
    topicLabel.frame = !direction? CGRectMake(0, 0, self.frame.size.width - 5, 30):CGRectMake(5, 0, self.frame.size.width - 5, 30);
    topicLabel.textAlignment = !direction?NSTextAlignmentRight:NSTextAlignmentLeft;
    topicLabel.textAlignment = NSTextAlignmentCenter;
    
    BOOL position = (((arc4random() % ((unsigned)RAND_MAX + 1))) %5 == 0);
    topicLabel.frame = position? CGRectMake(topicLabel.frame.origin.x, 10, topicLabel.frame.size.width, topicLabel.frame.size.height):CGRectMake(topicLabel.frame.origin.x, 80, topicLabel.frame.size.width, topicLabel.frame.size.height);
    tweetLabel.frame = position? CGRectMake(5, 45, tweetLabel.frame.size.width, tweetLabel.frame.size.height): CGRectMake(5, 5, tweetLabel.frame.size.width, tweetLabel.frame.size.height);
    
}

- (void)setCuttrentContent:(NSDictionary*)currentDict andBackgroundColor:(UIColor *)backgroudColor
{
    self.currentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.currentView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.currentView];
    
    UILabel *currentTopicLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 5, 30)];
    [self.currentView addSubview:currentTopicLabel];
    currentTopicLabel.backgroundColor = [UIColor clearColor];
    currentTopicLabel.tag = 1000;
    currentTopicLabel.textColor = backgroudColor;
    
    UILabel *currentTweetLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 45, self.frame.size.width - 10, self.frame.size.height - 50)];
    currentTweetLabel.backgroundColor = [UIColor clearColor];
    currentTweetLabel.tag = 1001;
    [self.currentView addSubview:currentTweetLabel];
    currentTweetLabel.font = [UIFont systemFontOfSize:12];
    currentTweetLabel.numberOfLines = 0;
    currentTweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    //random layout for top/bottom, left/right
    [self randomization:self.currentView];
    
    [(UILabel*)[self.currentView viewWithTag:1000] setText:@"CURRENT"];
    [(UILabel*)[self.currentView viewWithTag:1001] setText:@"tweet now"];
    
    self.currentView.backgroundColor = backgroudColor;
    self.currentView.layer.borderColor = [UIColor colorWithWhite:.6 alpha:.5].CGColor;
    self.currentView.layer.borderWidth = 1;
}
- (void)setNextContent:(NSDictionary*)nextDict andBackgroundColor:(UIColor *)backgroudColor
{
    self.nextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.nextView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.nextView];
    
    UILabel *nextTopicLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 5, 30)];
    nextTopicLabel.backgroundColor = [UIColor clearColor];
    [self.nextView addSubview:nextTopicLabel];
    nextTopicLabel.tag = 1000;
    nextTopicLabel.textColor = backgroudColor;
    
    UILabel *nextTweetLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 45, self.frame.size.width - 10, self.frame.size.height - 50)];
    nextTweetLabel.backgroundColor = [UIColor clearColor];
    nextTweetLabel.tag = 1001;
    [self.nextView addSubview:nextTweetLabel];
    nextTweetLabel.font = [UIFont systemFontOfSize:12];
    nextTweetLabel.numberOfLines = 0;
    nextTweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    //random layout for top/bottom, left/right
    [self randomization:self.nextView];
    
    [(UILabel*)[self.nextView viewWithTag:1000] setText:nextDict[@"topic"]];
    [(UILabel*)[self.nextView viewWithTag:1001] setText:nextDict[@"text"]];

    self.nextView.backgroundColor = backgroudColor;
    self.nextView.layer.borderColor = [UIColor colorWithWhite:.6 alpha:.5].CGColor;
    self.nextView.layer.borderWidth = 1;
    
    [self flipAnimation];
}

- (void)flipAnimation
{
    setNextViewOnCompletion = YES;
    animating = YES;
    
    [self initFlip];
    [self performSelector:@selector(flipPage) withObject:Nil afterDelay:0.001];
}

- (void) flipPage
{
	[self setFlipProgress:1.0 setDelegate:YES animate:YES];
}

- (void) initFlip
{
	
	// Create screenshots of view
	
	UIImage *currentImage = [self.currentView imageByRenderingView];
	UIImage *newImage = [self.nextView imageByRenderingView];
	
	// Hide existing views
	
	self.currentView.alpha = 0;
	self.nextView.alpha = 0;
	
	// Create representational layers
	
	CGRect rect = self.bounds;
	rect.size.height /= 2;
    
	backgroundAnimationLayer = [CALayer layer];
	backgroundAnimationLayer.frame = self.bounds;
	backgroundAnimationLayer.zPosition = -1;
    
    rect.origin.y = rect.size.height; 
    
	CALayer *topLayer = [CALayer layer];
	topLayer.frame = rect;
	topLayer.masksToBounds = YES;
	topLayer.contentsGravity = kCAGravityTop;
	
	[backgroundAnimationLayer addSublayer:topLayer];
	
	rect.origin.y = 0;
	
	CALayer *bottomLayer = [CALayer layer];
	bottomLayer.frame = rect;
	bottomLayer.masksToBounds = YES;
	bottomLayer.contentsGravity = kCAGravityBottom;
	
	[backgroundAnimationLayer addSublayer:bottomLayer];
	
    topLayer.contents = (id) [currentImage CGImage];
    bottomLayer.contents = (id) [newImage CGImage];
    
//    topLayer.backgroundColor = [UIColor greenColor].CGColor;
//    bottomLayer.backgroundColor = [UIColor redColor].CGColor;
    
	[self.layer addSublayer:backgroundAnimationLayer];
	
	rect.origin.y = 0;
	
	flipAnimationLayer = [CATransformLayer layer];
	flipAnimationLayer.anchorPoint = CGPointMake(0.5, 1.);
	flipAnimationLayer.frame = rect;
	
	[self.layer addSublayer:flipAnimationLayer];
    
    rect.origin.y = rect.size.height;
	
	CALayer *backLayer = [CALayer layer];
	backLayer.frame = flipAnimationLayer.bounds;
	backLayer.doubleSided = NO;
	backLayer.masksToBounds = YES;
    backLayer.contentsGravity = kCAGravityTop;
    backLayer.transform = CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0);
	
	[flipAnimationLayer addSublayer:backLayer];
	
	CALayer *frontLayer = [CALayer layer];
	frontLayer.frame = flipAnimationLayer.bounds;
	frontLayer.doubleSided = NO;
	frontLayer.masksToBounds = YES;
    frontLayer.contentsGravity = kCAGravityBottom;
	//frontLayer.transform = CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0);
	
	[flipAnimationLayer addSublayer:frontLayer];

    backLayer.contents = (id) [newImage CGImage];
    frontLayer.contents = (id) [currentImage CGImage];
    
//    frontLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    backLayer.backgroundColor = [UIColor purpleColor].CGColor;
    
    CATransform3D transform = CATransform3DMakeRotation(0.0, 1.0, 0.0, 0.0);
    transform.m34 = 1.0f / 2500.0f;
    
    flipAnimationLayer.transform = transform;
    
    currentAngle = startFlipAngle = 0;
    endFlipAngle = M_PI;
    
}

- (void) cleanupFlip
{
	[backgroundAnimationLayer removeFromSuperlayer];
	[flipAnimationLayer removeFromSuperlayer];
	
	backgroundAnimationLayer = nil;
	flipAnimationLayer = nil;
	
	animating = NO;
	
	if (setNextViewOnCompletion)
    {
		[self.currentView removeFromSuperview];
		self.currentView = self.nextView;
		self.nextView = nil;
	}
    else
    {
		[self.nextView removeFromSuperview];
		self.nextView = nil;
	}
    
	self.currentView.alpha = 1;

}


- (void) setFlipProgress:(float) progress setDelegate:(BOOL) setDelegate animate:(BOOL) animate
{
    if (animate) {
        animating = YES;
    }
    
	float newAngle = startFlipAngle + progress * (endFlipAngle - startFlipAngle);
	
	float duration = animate ? 2.0 * fabs((newAngle - currentAngle) / (endFlipAngle - startFlipAngle)) : 0;
	
	currentAngle = newAngle;
	
	CATransform3D endTransform = CATransform3DIdentity;
	endTransform.m34 = 1.0f / 2500.0f;
	endTransform = CATransform3DRotate(endTransform, newAngle, 1.0, 0.0, 0.0);
	
	[flipAnimationLayer removeAllAnimations];
    
	[CATransaction begin];
	[CATransaction setAnimationDuration:duration];
	
	flipAnimationLayer.transform = endTransform;
	
	[CATransaction commit];
    
	
	if (setDelegate) {
		[self performSelector:@selector(cleanupFlip) withObject:Nil afterDelay:duration];
	}
}

#pragma mark -
#pragma mark Touch management
- (void) tapped:(UITapGestureRecognizer *) recognizer
{
	NSLog(@"tapped on %@",((UILabel*)[self.currentView viewWithTag:1000]).text);
}



@end
