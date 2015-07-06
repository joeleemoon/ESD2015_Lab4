//
//  drawing.m
//  Canvas
//
//  Created by Lee Joe on 4/2/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//

#import "drawing.h"

@implementation drawing

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
int first=1;
-(void)drawRect:(CGRect)rect
{

    self.rect = &(rect);

    
    for(int i=0;i < [self.strokeList count] ; i++)
    {
        CGContextRef ctx1 = UIGraphicsGetCurrentContext();
        ModStroke *now_stroke = (__bridge ModStroke *)((__bridge CGMutablePathRef)([self.strokeList objectAtIndex:i]));
        CGContextAddPath(ctx1, now_stroke.pen_path);
        CGContextSetStrokeColorWithColor(ctx1, now_stroke.pen_color.CGColor);
        CGContextSetLineWidth(ctx1, now_stroke.pen_size);
        CGContextDrawPath(ctx1, kCGPathStroke);
        
    }
    
    self.isUndo = false;
    self.now_stroke = NULL;
    //[self setNeedsDisplayInRect:rect];
    
    
}



@end
