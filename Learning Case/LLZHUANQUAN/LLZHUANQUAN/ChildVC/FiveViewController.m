

//
//  FiveViewController.m
//  LLZHUANQUAN
//
//  Created by 李龙 on 16/9/20.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "FiveViewController.h"


@interface FiveViewController ()

@property (nonatomic,strong) CAShapeLayer *CurvedLineLayer;

@end


@implementation FiveViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self createCurvedLine];
    
    
}

//画一个弧线
- (void)createCurvedLine
{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    [aPath moveToPoint:CGPointMake(20, 100)];
    [aPath addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];

    self.CurvedLineLayer = [CAShapeLayer layer];
    self.CurvedLineLayer.path = aPath.CGPath;
    [self.view.layer addSublayer:self.CurvedLineLayer];
}

@end
