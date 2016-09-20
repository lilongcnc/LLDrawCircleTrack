//
//  TBCircularSlider.m
//  TB_CircularSlider
//
//  Created by Yari Dareglia on 1/12/13.
//  Copyright (c) 2013 Yari Dareglia. All rights reserved.
//

#import "TBCircularSlider.h"
#import "Commons.h"

/** Helper Functions **/
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

/** Parameters **/
#define TB_SAFEAREA_PADDING 60


#pragma mark - Private -

@interface TBCircularSlider(){
    UITextField *_textField;
    int radius;
    int index;
    
    
    int lastRadius;
    
    int angleInt222;
    BOOL canAddFlag;
}

@property (nonatomic,strong) CAShapeLayer *progressLayer;
@property (nonatomic,strong) CAShapeLayer *trackLayer;

@property (nonatomic,strong) UIBezierPath *trackPath;
@property (nonatomic,strong) UIBezierPath *progressPath;


@property (nonatomic,assign) CGPoint movePoint1;
@property (nonatomic,assign) CGPoint movePoint2;
@property (nonatomic,assign) CGPoint centerPoint;
@property (nonatomic,assign) BOOL isLoopy;
@property (nonatomic,assign) int circlesCount;
@property (nonatomic,assign) BOOL isKa;
@property (nonatomic,assign) int currentValue;

@end


#pragma mark - Implementation -

@implementation TBCircularSlider

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.opaque = NO;
        
        //Define the circle radius taking into account the safe area
        radius = self.frame.size.width/2 - TB_SAFEAREA_PADDING;
        
        //Get the center
        self.centerPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);

        
        
        //Initialize the Angle at 0
        self.currentValue = 5;
        
        
        //Define the Font
        UIFont *font = [UIFont fontWithName:TB_FONTFAMILY size:TB_FONTSIZE];
        //Calculate font size needed to display 3 numbers
        NSString *str = @"000";
        CGSize fontSize = [str sizeWithFont:font];
        
        //Using a TextField area we can easily modify the control to get user input from this field
        _textField = [[UITextField alloc]initWithFrame:CGRectMake((frame.size.width  - fontSize.width) /2,
                                                                  (frame.size.height - fontSize.height) /2,
                                                                  fontSize.width*1.5,
                                                                  fontSize.height)];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = font;
        _textField.text = [NSString stringWithFormat:@"%d",self.currentValue];
        _textField.enabled = NO;
        
        [self addSubview:_textField];
    }
    
    return self;
}


#pragma mark - UIControl Override -

/** Tracking is started **/
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    //We need to track continuously
    return YES;
}

/** Track continuos touch event (like drag) **/
static int const circleNumber = 6;
- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    //Get touch location
    CGPoint lastPoint = [touch locationInView:self];
    self.movePoint2 = [touch locationInView:self];
    
    
    self.isLoopy = YES;
    NSLog(@"🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈🐈");
    NSLog(@"%s  %@",__FUNCTION__,NSStringFromCGPoint(lastPoint));
    //-------
//    NSLog(@"self.movePoint1.x=%f<---->self.centerPoint.x=%f<---->self.movePoint1.y:%f<---->self.centerPoint.y:%f",self.movePoint1.x,self.
//          centerPoint.x,self.movePoint1.y, self.centerPoint.y);
    NSLog(@"movePoint1:%@<---->centerPoint:%@",NSStringFromCGPoint(self.movePoint1),NSStringFromCGPoint(self.centerPoint));
    //第一象限
    if(((self.movePoint1.x >= self.centerPoint.x) && (self.movePoint1.y <= self.centerPoint.y)))
    {
        NSLog(@"movePoint2:%@<---->centerPoint:%@",NSStringFromCGPoint(self.movePoint2),NSStringFromCGPoint(self.centerPoint));
        //从第二象限过来的
        if ((self.movePoint2.x >= self.centerPoint.x) && (self.movePoint2.y > self.centerPoint.y)) {
            
            //增加度数 ++
            if (self.isLoopy) {
                NSLog(@"----------- 1-1");
                self.circlesCount++;
                
                if (self.circlesCount > circleNumber) {
                    NSLog(@"----------- 1-2");
                    
                    self.circlesCount = circleNumber;
                    self.isKa = YES;
                    //[self movehandle:[self pointFromAngle:356]];
                    self.currentValue = 1079;
                    
                }else
                {
                    NSLog(@"----------- 1-3");
                    [self movehandle:lastPoint];
                }
            }
            //否则从第三象限那边出来的
            else
            {
                NSLog(@"----------- 1-4");
                self.circlesCount = 0;
                self.isKa = YES;
                
                //[self movehandle:[self pointFromAngle:356]];
                self.currentValue = 179;
                
                
                // self.currentValue = self.currentValue + 1;
                
            }
        }
        else{
            NSLog(@"----------- 1-5");
            [self movehandle:lastPoint];
        }
        
        NSLog(@"--------------------------------------------------->1:self.circlesCount:%d",self.circlesCount);
        
    }
    
    //第二象限
    else if(((self.movePoint1.x >= self.centerPoint.x) && (self.movePoint1.y >= self.centerPoint.y)))
    {
        

        if(self.circlesCount == 3){
            NSLog(@"self.circlesCount = 2 vs  self.circlesCount:%d",self.circlesCount);
            NSLog(@"self.movePoint2.x=%f<---->self.centerPoint.x=%f<---->self.movePoint2.y:%f<---->self.centerPoint.y:%f",self.movePoint2.x,self.centerPoint.x,self.movePoint2.y, self.centerPoint.y);

        }
        
        //从第一象限过来
        if ((self.movePoint2.x >= self.centerPoint.x) && (self.movePoint2.y <= self.centerPoint.y)) {
            //减少度数 --
            
            if (self.isLoopy) {
                NSLog(@"----------- 2-1");

                //                if(self.circlesCount>0)
                //                {
                //                    self.circlesCount--;
                //                }
                self.circlesCount--;
                
                
                if (self.circlesCount < 0) {
                    NSLog(@"----------- 2-2");
                    self.circlesCount = 0;
                    
                    self.isKa = YES;
                    //[self movehandle:[self pointFromAngle:0]];
                    self.currentValue = 1;
                    
                }else
                {
                    NSLog(@"----------- 2-3");
                    [self movehandle:lastPoint];
                }
            }
            //从其他象限过来
            else
            {
                NSLog(@"----------- 2-4");
                self.circlesCount = 0;
                self.isKa = YES;
                //[self movehandle:[self pointFromAngle:0]];
                self.currentValue = 1;
                
            }
            
            
        }else
        {
            NSLog(@"----------- 2-5");
            [self movehandle:lastPoint];
        }
        
        
    }else
    {
        NSLog(@"----------- 2-6");
        //self.isKa = NO;
        [self movehandle:lastPoint];
    }
    
    
    
    NSLog(@"--------------------------------------------------->2:self.circlesCount:%d",self.circlesCount);

    
    //Control value has changed, let's notify that
    //    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}




/** Track is finished **/
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    
}


#pragma mark - Drawing Functions - 

BOOL isCreateCircleFlag;
//Use the draw rect to draw the Background, the Circle and the Handle
-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    

    if (!isCreateCircleFlag) {
        isCreateCircleFlag = YES;
        NSLog(@"%f---%f",ToRad(360),ToDeg(360));
        UIBezierPath* circlePath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint
                                                                  radius:radius
                                                              startAngle:0
                                                                endAngle:ToRad(360)
                                                               clockwise:YES];
        _progressLayer = [CAShapeLayer new];
        
        _progressLayer.frame = rect;
        _progressLayer.path = circlePath.CGPath;
        
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = TB_LINE_WIDTH-10;
        
        _progressLayer.strokeColor = [UIColor redColor].CGColor;
        _progressLayer.fillColor = nil;

        _progressLayer.strokeStart = 0.f;
        _progressLayer.strokeEnd = 0.f;

        [self.layer addSublayer:_progressLayer];
    }
    
    
    /** Draw the handle **/
    [self drawTheHandle];
    
}




/** Draw a white knob over the circle **/
-(void) drawTheHandle{

    //----------  1
//    CGContextSaveGState(ctx);
//    
//    //I Love shadows
//    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 3, [UIColor blackColor].CGColor);
//    
//    //Get the handle position
//    CGPoint handleCenter =  [self pointFromAngle: self.currentValue];
//    
//    
//    
//    //Draw It!
//    [[UIColor colorWithWhite:1.0 alpha:0.7]set];
//    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x, handleCenter.y, TB_LINE_WIDTH, TB_LINE_WIDTH));
//    
//    CGContextRestoreGState(ctx);
    
    
    //----------- 2
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //I Love shadows
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 3, [UIColor blackColor].CGColor);
    //Get the handle position
    CGPoint handleCenter =  [self pointFromAngle: self.currentValue];
    //Draw It!
    [[UIColor colorWithWhite:1.0 alpha:0.7]set];
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x, handleCenter.y, TB_LINE_WIDTH, TB_LINE_WIDTH));
    
}


#pragma mark - Math -

int previousAngleInt;

/** Move the Handle **/
int _maxValue = 270;
int _minValue = 20;
- (void)movehandle:(CGPoint)lastPoint
{
    
    //Calculate the direction from a center point and a arbitrary position.
    float currentAngle = AngleFromNorth(_centerPoint, lastPoint, NO);
    int angleInt = floor(currentAngle);
    
    //cal the new angle
    //self.currentValue = angleInt/360.f * (_maxValue-_minValue) + _minValue;
    //    self.currentValue = (angleInt)/360.f * (_maxValue-_minValue) + _minValue + self.circlesCount* 180;
    
    
    self.currentValue = 360 - angleInt+ self.circlesCount*360;
    
    
    NSLog(@"self.currentValue------------- 1 ---------->%d",self.currentValue);
    if (self.circlesCount == circleNumber) {
//        self.currentValue = (angleInt)/360.f * (_maxValue-_minValue) + _minValue + (self.circlesCount-1)* 180;
        self.currentValue = 360 - angleInt+ self.circlesCount*360;
//        self.currentValue = self.currentValue>circleNumber*360? circleNumber*360:self.currentValue;

    }
    
    
    NSLog(@"self.currentValue-------------- 2 --------->%d",self.currentValue);
    
//    if (self.currentValue>=circleNumber*360) return;
    _textField.text = [NSString stringWithFormat:@"%d",self.currentValue];
    
    self.movePoint1 = lastPoint;
    
    
    NSLog(@"📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱📱angleInt-------------- 2 --------->%d",angleInt);

    changeDeg = [self getStrokeEndVlaue:360-angleInt];
    [self modifyCircleWithNoAnimation];
    
    [self setNeedsDisplay];
}


- (CGFloat)getStrokeEndVlaue:(int)intVlaue{
    
    
    return (intVlaue)/360.f;
}


CGFloat changeDeg = 0;
CGFloat previousChangeDeg = 0;
//动画和非动画,这个例子主要体现在了对绘制完成时间的控制上
- (void)modifyCircleWithNoAnimation {
    
    _progressLayer.strokeStart = previousChangeDeg;
    _progressLayer.strokeEnd = changeDeg;
    
}







/** Given the angle, get the point position on circumference **/
-(CGPoint)pointFromAngle:(int)angleInt{
    
    //Circle center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - TB_LINE_WIDTH/2, self.frame.size.height/2 - TB_LINE_WIDTH/2);
    
    //The point position on the circumference
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin(ToRad(-angleInt))) ;
    result.x = round(centerPoint.x + radius * cos(ToRad(-angleInt)));
    
    return result;
}

//Sourcecode from Apple example clockControl 
//Calculate the direction in degrees from a center point to an arbitrary position.
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    
    NSLog(@"%s  result:%f",__FUNCTION__,result);
    return (result >=0  ? result : result + 360.0);
}

@end


