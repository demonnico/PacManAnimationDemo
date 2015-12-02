//
//  UIView+PacManAnimation.m
//  TapAnimationDemo
//
//  Created by Nicholas Tau on 12/2/15.
//  Copyright © 2015 EUMLab. All rights reserved.
//

#import "UIView+PacManAnimation.h"
#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic, strong) NSTimer * pacAnimationTimer;
@property (nonatomic, assign) CGFloat pacAnimationProgress;
@end

static const char *kPacManAnimationTimer = "kPacManAnimationTimer";
static const char *kPacManAnimationProgress = "kPacManAnimationProgress";

@implementation UIView (PacManAnimation)
-(void)startPacAnimation
{
    if (!self.pacAnimationTimer) {
        NSTimer * timerPac = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                              target:self
                                                            selector:@selector(animationTick)
                                                            userInfo:nil
                                                             repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timerPac
                                 forMode:NSRunLoopCommonModes];
        self.pacAnimationTimer = timerPac;
    }
}

-(void)animationTick
{
    if (self.pacAnimationProgress<=1) {
        self.pacAnimationProgress+=0.02;
        UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRect:self.bounds];
        
        CGFloat radius = self.frame.size.width/2;
        UIBezierPath * bezierPathInner =
        [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius,radius)
                                       radius:radius*self.pacAnimationProgress
                                   startAngle:0
                                     endAngle:M_PI*2
                                    clockwise:YES];
        [bezierPath appendPath:bezierPathInner];
        
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.fillRule = kCAFillRuleEvenOdd;
        shapeLayer.path = bezierPath.CGPath;
        self.layer.mask = shapeLayer;
    }else{
        [self stopPacAnimation];
    }
}

-(void)setPacAnimationTimer:(NSTimer *)pacAnimationTimer
{
    objc_setAssociatedObject(self, kPacManAnimationTimer, pacAnimationTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimer *)pacAnimationTimer
{
    return objc_getAssociatedObject(self, kPacManAnimationTimer);
}

-(void)setPacAnimationProgress:(CGFloat)pacAnimationProgress
{
    objc_setAssociatedObject(self, kPacManAnimationProgress, @(pacAnimationProgress), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CGFloat)pacAnimationProgress
{
    return  [objc_getAssociatedObject(self, kPacManAnimationProgress) floatValue];
}

-(void)stopPacAnimation
{
    [self.pacAnimationTimer invalidate];
    self.pacAnimationTimer = nil;
}
@end
