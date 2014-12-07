//
//  RGView.m
//  Block
//
//  Created by ROBERA GELETA on 12/6/14.
//  Copyright (c) 2014 ROBERA GELETA. All rights reserved.
//

#define HANDLE 57
#define RADIUS 20
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

#import "RGView.h"

@implementation RGView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    //starting angle
    self.angle = 99;
    
    //add Gesutre Recognizer
    UIPanGestureRecognizer *tracker = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panning:)];
    
   
    [self addGestureRecognizer:tracker];
    return self;
}


- (void)drawRect:(CGRect)rect
{

//    if (self.angle < 0)
//    {
//        self.angle = 0;
//    }
    
    //TODO:
    CGPoint handlePosition = [self pointFromAngle:(int)self.angle];


    handlePosition = CGPointMake(10, 23);
    [self drawCanvas1WithAngle:self.angle];

}
- (void)drawCanvas1WithAngle: (CGFloat)angle
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.25 green: 0.756 blue: 0.381 alpha: 1];
    UIColor* color4 = [UIColor colorWithRed: 0.135 green: 0.118 blue: 0.118 alpha: 0.614];
    UIColor* color5 = [UIColor colorWithRed: 0.263 green: 0.545 blue: 0.302 alpha: 1];
    UIColor* color6 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Group 2
    {
        //// Group
        {
            //// BackgroundCircle Drawing
            UIBezierPath* backgroundCirclePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(3, 11, 300, 299)];
            [color4 setFill];
            [backgroundCirclePath fill];
            
            
            //// frontCircle Drawing
            CGRect frontCircleRect = CGRectMake(3, 12, 300, 299);
            UIBezierPath* frontCirclePath = UIBezierPath.bezierPath;
            [frontCirclePath addArcWithCenter: CGPointMake(0, 0) radius: CGRectGetWidth(frontCircleRect) / 2 startAngle: -(angle + 29) * M_PI/180 endAngle: 0 * M_PI/180 clockwise: YES];
            [frontCirclePath addLineToPoint: CGPointMake(0, 0)];
            [frontCirclePath closePath];
            
            CGAffineTransform frontCircleTransform = CGAffineTransformMakeTranslation(CGRectGetMidX(frontCircleRect), CGRectGetMidY(frontCircleRect));
            frontCircleTransform = CGAffineTransformScale(frontCircleTransform, 1, CGRectGetHeight(frontCircleRect) / CGRectGetWidth(frontCircleRect));
            [frontCirclePath applyTransform: frontCircleTransform];
            
            [color setFill];
            [frontCirclePath fill];
        }
        
        
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(63, 71, 180, 180)];
        [color5 setFill];
        [ovalPath fill];
        
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(136.5, 125.5)];
        [bezierPath addLineToPoint: CGPointMake(136.5, 195.5)];
        [bezierPath addLineToPoint: CGPointMake(199.5, 163.5)];
        [bezierPath addLineToPoint: CGPointMake(136.5, 125.5)];
        [UIColor.whiteColor setFill];
        [bezierPath fill];
        [color6 setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
    }
}

-(CGPoint)pointFromAngle:(int)angleInt{
    
    //Define the Circle center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - HANDLE/2, self.frame.size.height/2 - HANDLE/2);
    
    //Define The point position on the circumference
    CGPoint result;
    CGFloat rad = -angleInt * M_PI / 180.0;
    
    result.y = round(centerPoint.y + RADIUS * sin(rad)) ;
    result.x = round(centerPoint.x + RADIUS * cos(rad));
    
    return result;
}

- (void)panning:(UIPanGestureRecognizer *)sender
{
    
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
//    CGPoint translation = [pan translationInView:self];
    CGPoint currentTouch = [pan locationInView:self];
    self.angle =  - RADIANS_TO_DEGREES(pToA(currentTouch, self));
    NSLog(@"%d",self.angle);
    //Redraw
    [self setNeedsDisplay];
    
}

static CGFloat pToA (CGPoint loc, UIView* self) {

    CGPoint c = CGPointMake(CGRectGetMidX(self.bounds),
                            CGRectGetMidY(self.bounds));

    return atan2(loc.y - c.y, loc.x - c.x);
}

@end
