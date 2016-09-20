//
//  ViewController.m
//  LLDrawCircleTrack
//
//  Created by 李龙 on 16/9/20.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "ViewController.h"
#import "TBCircularSlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    
    //Create the Circular Slider
    TBCircularSlider *slider = [[TBCircularSlider alloc]initWithFrame:CGRectMake(0, 60, TB_SLIDER_SIZE, TB_SLIDER_SIZE)];
    
    
//    slider.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    //Define Target-Action behaviour
    [slider addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
}

/** This function is called when Circular slider value changes **/
-(void)newValue:(TBCircularSlider*)slider{
    //TBCircularSlider *slider = (TBCircularSlider*)sender;
    //    NSLog(@"Slider Value %d",slider.angle);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
