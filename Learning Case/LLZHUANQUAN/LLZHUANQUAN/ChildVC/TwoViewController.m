//
//  TwoViewController.m
//  LLZHUANQUAN
//
//  Created by 李龙 on 16/9/20.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()


@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic,strong) CAShapeLayer *trackLayer;

@property (nonatomic,strong) UIBezierPath *trackPath;
@property (nonatomic,strong) UIBezierPath *progressPath;


#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )


@end

@implementation TwoViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 150, 50)];
    [button  setTitle:@"改变圆环进度" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self createBezierPath:CGRectMake(20, 100, 100, 100)];
    
}


//画两个圆形
-(void)createBezierPath:(CGRect)mybound
{
    //外圆
    _trackPath = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                radius:(mybound.size.width - 0.7)/ 2
                                            startAngle:0
                                              endAngle:M_PI * 2
                                             clockwise:YES
                  ];
    
    _trackLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.strokeColor=[UIColor grayColor].CGColor;
    _trackLayer.path = _trackPath.CGPath;
    _trackLayer.lineWidth=5;
    _trackLayer.frame = mybound;
    
    //内圆
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.view.center
                                                   radius:(mybound.size.width - 0.7)/ 2
                                               startAngle:0
                                                 endAngle:ToRad(360)
                                                clockwise:YES
                     ];
    
    
    
    _progressLayer = [CAShapeLayer new];
    _progressLayer.fillColor = nil;
    _progressLayer.strokeColor=[UIColor redColor].CGColor;
    _progressLayer.path = _progressPath.CGPath;
    _progressLayer.lineWidth=5;
    _progressLayer.frame = mybound;
    _progressLayer.lineCap = kCALineCapRound;
    
    _progressLayer.strokeStart = 0.0f;
    _progressLayer.strokeEnd = 0.0f;
    

    [self.view.layer addSublayer:_progressLayer];

    
}


CGFloat changeDeg = 0;
CGFloat previousChangeDeg = 0;

- (void)btnOnClick:(id)sender {
    
    changeDeg += 0.1f;
    
    [self modifyCircleWithNoAnimation];
}


//动画和非动画,这个例子主要体现在了对绘制完成时间的控制上
- (void)modifyCircleWithNoAnimation {
    
    _progressLayer.strokeStart = previousChangeDeg;
    _progressLayer.strokeEnd = changeDeg;
}


- (void)modifyCircleWithAnimation {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    [animation setDuration:0.5f];
    //[animation setSpeed:animationSpeed];
    animation.fromValue = @(previousChangeDeg);
    animation.toValue   = @(changeDeg);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [_progressLayer addAnimation:animation forKey:@"strokeEnd"];
    
    previousChangeDeg = changeDeg;
}


@end
