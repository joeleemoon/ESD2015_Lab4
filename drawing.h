//
//  drawing.h
//  Canvas
//
//  Created by Lee Joe on 4/2/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModStroke.h"

@interface drawing : UIView
@property (nonatomic,strong) NSMutableArray *strokes;
@property (nonatomic) CGRect *rect;
@property (nonatomic) CGRect frame;
@property (nonatomic,strong) NSMutableArray *strokeList;
@property (nonatomic) CGMutablePathRef now_path;
@property (nonatomic) ModStroke *now_stroke;
@property (nonatomic) bool isUndo;
@end
