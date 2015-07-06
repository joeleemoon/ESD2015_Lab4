//
//  GuessViewController.h
//  Canvas
//
//  Created by Lee Joe on 4/17/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModStroke.h"
#import "drawing.h"

@interface GuessViewController : UIViewController
@property (nonatomic,strong) NSString *answer;
@property (nonatomic,strong) ModStroke *stroke;
@property (nonatomic,strong) NSMutableArray *strokeList;
@property (nonatomic,strong) IBOutlet drawing *guessDraw;
@property (nonatomic,strong) IBOutlet UIView *AnswerView;
@property (nonatomic,strong) IBOutlet UILabel *answer_label;
@property (nonatomic,strong) UIButton *now_question_button;
@property (nonatomic,strong) UIButton *now_answer_button;
@property (nonatomic,strong) NSMutableArray *question_button_list;
@property (nonatomic,strong) NSMutableArray *answer_word;
@property (nonatomic,strong) NSMutableArray *answer_list;
@property (nonatomic,strong) NSNumber *needDraw;

@end
