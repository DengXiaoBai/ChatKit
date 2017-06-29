//
//  SKSDrawBubbleView.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSDrawBubbleView.h"

static inline double radians (double degrees) { return degrees * M_PI/180; }

@interface SKSDrawBubbleView()

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) BOOL isSendMessage;//判断是否是发送的消息

@end

@implementation SKSDrawBubbleView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)resetWidth:(CGFloat)width height:(CGFloat)height isSendMessage:(BOOL)isSendMessage {
    _width = width;
    _height = height;
    _isSendMessage = isSendMessage;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {//用于 UIMenuController 的显示
    return YES;
}

- (BOOL)canResignFirstResponder {
    return YES;
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat smallCircleRadius = 7.0f;//正常的小圆的半径
    CGFloat bubbleTurnCornerAngleRadius = 1.0f;//气泡视图的尖角的半径
    
    //气泡尖角中转角中的大圆
    CGFloat bubbleAngleMoreAngleRadius = 14;//气泡尖角中的转角的大圆
    CGFloat bubbleAngleMoreAngleDegree = 40;
    CGFloat bubbleAngleMoreAngleRadians = bubbleAngleMoreAngleDegree * (M_PI / 180);// radians = degrees * π / 180
    CGFloat bubbleAngleMoreWidth = bubbleAngleMoreAngleRadius *(1 - cosf(bubbleAngleMoreAngleRadians)) + bubbleTurnCornerAngleRadius;//计算上边气泡尖角比下边多出来的距离
    
    CGFloat xOffset = 0;//测试使用的 偏移量
    CGFloat yOffset = 0;
    
    
    //    中心点右侧 弧度为 0
    //    中心点下方 弧度为 M_PI_2
    //    中心点左侧 弧度为 M_PI
    //    中心点上方 弧度为 -M_PI_2
    if (_isSendMessage) {
        //从左下角开始绘画整个 bubble 视图
        [path moveToPoint:CGPointMake(xOffset, _height + yOffset - smallCircleRadius)];
        [path addLineToPoint:CGPointMake(xOffset, smallCircleRadius + yOffset)];
        
        [path addArcWithCenter:CGPointMake(smallCircleRadius + xOffset, smallCircleRadius + yOffset)
                        radius:smallCircleRadius
                    startAngle:M_PI
                      endAngle:-M_PI_2
                     clockwise:YES];
        
        [path addLineToPoint:CGPointMake(_width + xOffset - bubbleTurnCornerAngleRadius, yOffset)];//气泡尖角转角小圆的左边起点，这里算是180度的弧度
        [path addArcWithCenter:CGPointMake(_width + xOffset - bubbleTurnCornerAngleRadius, bubbleTurnCornerAngleRadius + yOffset)
                        radius:bubbleTurnCornerAngleRadius
                    startAngle:-M_PI_2
                      endAngle:M_PI_2
                     clockwise:YES];
        
        //添加气泡中大转角的弧度
        [path addArcWithCenter:CGPointMake(_width + xOffset - bubbleAngleMoreWidth + bubbleAngleMoreAngleRadius, 2 * bubbleTurnCornerAngleRadius + bubbleAngleMoreAngleRadius * sinf(bubbleAngleMoreAngleRadians) + yOffset)
                        radius:bubbleAngleMoreAngleRadius
                    startAngle:M_PI + radians(bubbleAngleMoreAngleDegree)
                      endAngle:M_PI
                     clockwise:NO];//注意这个是要逆时针绘画
        
        //开始右下方的小圆角的绘画
        [path addLineToPoint:CGPointMake(_width + xOffset - bubbleAngleMoreWidth, _height + yOffset - smallCircleRadius)];
        [path addArcWithCenter:CGPointMake(_width + xOffset - bubbleAngleMoreWidth - smallCircleRadius, _height + yOffset - smallCircleRadius)
                        radius:smallCircleRadius
                    startAngle:0
                      endAngle:M_PI_2
                     clockwise:YES];
        
        [path addLineToPoint:CGPointMake(smallCircleRadius + xOffset, _height + yOffset)];
        [path addArcWithCenter:CGPointMake(xOffset + smallCircleRadius, _height + yOffset - smallCircleRadius)
                        radius:smallCircleRadius
                    startAngle:M_PI_2
                      endAngle:M_PI
                     clockwise:YES];
    } else {
        //接受方的气泡绘制
        [path moveToPoint:CGPointMake(xOffset + bubbleAngleMoreWidth, _height + yOffset - smallCircleRadius )];
        [path addLineToPoint:CGPointMake(xOffset + bubbleAngleMoreWidth, 2 * bubbleTurnCornerAngleRadius + bubbleAngleMoreAngleRadius * sinf(bubbleAngleMoreAngleRadians) + yOffset)];
        
        //添加大转角的绘制
        [path addArcWithCenter:CGPointMake(xOffset + bubbleAngleMoreWidth - bubbleAngleMoreAngleRadius, yOffset + 2 * bubbleTurnCornerAngleRadius + bubbleAngleMoreAngleRadius * sinf(bubbleAngleMoreAngleRadians))
                        radius:bubbleAngleMoreAngleRadius
                    startAngle:0
                      endAngle:0 - radians(bubbleAngleMoreAngleDegree)
                     clockwise:NO];
        
        //添加小转角的绘制
        [path addArcWithCenter:CGPointMake(xOffset + bubbleTurnCornerAngleRadius, yOffset + bubbleTurnCornerAngleRadius)
                        radius:bubbleTurnCornerAngleRadius
                    startAngle:M_PI_2
                      endAngle:-M_PI_2
                     clockwise:YES];
        
        [path addLineToPoint:CGPointMake(xOffset + _width - smallCircleRadius, yOffset)];
        [path addArcWithCenter:CGPointMake(xOffset + _width - smallCircleRadius, yOffset + smallCircleRadius)
                        radius:smallCircleRadius
                    startAngle:-M_PI_2
                      endAngle:0
                     clockwise:YES];
        
        [path addLineToPoint:CGPointMake(xOffset + _width, yOffset + _height - smallCircleRadius)];
        [path addArcWithCenter:CGPointMake(xOffset + _width - smallCircleRadius, yOffset + _height - smallCircleRadius)
                        radius:smallCircleRadius
                    startAngle:0
                      endAngle:M_PI_2
                     clockwise:YES];
        
        [path addLineToPoint:CGPointMake(xOffset + bubbleAngleMoreWidth + smallCircleRadius, yOffset + _height)];
        [path addArcWithCenter:CGPointMake(xOffset + bubbleAngleMoreWidth + smallCircleRadius, yOffset + _height - smallCircleRadius)
                        radius:smallCircleRadius
                    startAngle:M_PI_2
                      endAngle:M_PI
                     clockwise:YES];
    }
    [path closePath];//连线
    path.lineWidth = 1;
    
    if (_isSendMessage) {
        [[UIColor whiteColor] setStroke];
        [[UIColor whiteColor] setFill];
    } else {
        [[UIColor whiteColor] setStroke];
        [[UIColor whiteColor] setFill];
    }
    
    //描边和填充
    [path stroke];//描边
    [path fill];//填充
    
}


@end
