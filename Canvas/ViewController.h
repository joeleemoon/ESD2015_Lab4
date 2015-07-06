//
//  ViewController.h
//  Canvas
//
//  Created by Lee Joe on 4/2/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawing.h"
#import "GuessViewController.h"
#import "pen_preview.h"

@interface ViewController : UIViewController
@property (nonatomic) ModStroke* stroke;
@property (nonatomic,strong) NSMutableArray *strokeList;
@property (nonatomic,strong) IBOutlet drawing* mydraw;
@property (nonatomic,strong) IBOutlet pen_preview* myPen_preview;
@property (nonatomic,strong) IBOutlet UIButton *undo;
@property (nonatomic,strong) IBOutlet UIButton *erase;
@property (nonatomic,strong) IBOutlet UIButton *white_button;
@property (nonatomic,strong) IBOutlet UIButton *black_button;
@property (nonatomic,strong) IBOutlet UIButton *yellow_button;
@property (nonatomic,strong) IBOutlet UIButton *brown_button;
@property (nonatomic,strong) IBOutlet UIButton *blue_button;
@property (nonatomic,strong) IBOutlet UIButton *purple_button;
@property (nonatomic,strong) IBOutlet UIButton *green_button;
@property (nonatomic,strong) IBOutlet UIButton *red_button;
@property (nonatomic,strong) IBOutlet UIButton *next_button;
@property (nonatomic,strong) IBOutlet UITextField *name_field;
@property (nonatomic,strong) NSString *graph_title;
@property (nonatomic,strong) NSNumber *needDraw;



@end

