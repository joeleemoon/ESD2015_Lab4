//
//  Stroke.h
//  Canvas
//
//  Created by Lee Joe on 4/7/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#ifndef Canvas_Stroke_h
#define Canvas_Stroke_h

@interface ModStroke : NSObject
@property (nonatomic) UIColor* pen_color;
@property (nonatomic) float pen_size;
@property (nonatomic) CGMutablePathRef pen_path;
@property (nonatomic,strong) NSMutableArray* pointArray;
@property (nonatomic) bool pen_isErase;
@end






#endif
