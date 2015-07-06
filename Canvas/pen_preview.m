//
//  pen_preview.m
//  Canvas
//
//  Created by Lee Joe on 4/10/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//

#import "pen_preview.h"

@implementation pen_preview

float CENTER_x=30.0;
float CENTER_y=30.0;


-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    float offset = (self.now_stroke.pen_size/2.0);
    CGMutablePathRef path =CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CENTER_x-offset, CENTER_y);
    CGPathAddLineToPoint(path, NULL, CENTER_x+offset, CENTER_y);
    CGContextSetStrokeColorWithColor(ctx, self.now_stroke.pen_color.CGColor);
    CGContextSetLineWidth(ctx, self.now_stroke.pen_size);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
}

@end
