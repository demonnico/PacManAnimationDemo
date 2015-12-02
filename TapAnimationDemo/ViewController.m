//
//  ViewController.m
//  TapAnimationDemo
//
//  Created by Nicholas Tau on 12/2/15.
//  Copyright © 2015 EUMLab. All rights reserved.
//

#import "ViewController.h"
#import "UIView+PacManAnimation.h"

@interface ViewController ()
@property (nonatomic, weak) UIView * bottomView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    bottomView.layer.cornerRadius = 50;
    bottomView.layer.masksToBounds = YES;
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];
    
    bottomView.alpha = 0;
    bottomView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    self.bottomView = bottomView;

//    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
//    shapeLayer.frame = bottomView.bounds;
//    shapeLayer.fillRule = kCAFillRuleEvenOdd;
//    shapeLayer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
//    
//    UIBezierPath * bezierPathRect = [UIBezierPath bezierPathWithRect:bottomView.frame];
//    
//    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50)
//                                                               radius:50
//                                                           startAngle:0
//                                                             endAngle:M_PI*2
//                                                            clockwise:YES];
//    [bezierPathRect appendPath:bezierPath];
//    
//    shapeLayer.fillRule = kCAFillRuleEvenOdd;
//    shapeLayer.path = bezierPathRect.CGPath;
//    self.bottomView.layer.mask = shapeLayer;
    
    UIButton * animationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [animationButton setFrame:CGRectMake(100, 200, 100, 100)];
    animationButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:animationButton];
    [animationButton addTarget:self
                        action:@selector(startAnimation)
              forControlEvents:UIControlEventTouchUpInside];
}

-(void)startAnimation
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.bottomView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         self.bottomView.alpha = 0.8;
                     } completion:^(BOOL finished) {
                         [self.bottomView startPacAnimation];
                     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
