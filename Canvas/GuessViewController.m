//
//  GuessViewController.m
//  Canvas
//
//  Created by Lee Joe on 4/17/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//

#import "GuessViewController.h"

@implementation GuessViewController

int point_idx = 0;
int stroke_idx = 0;
NSTimer *timer;
NSTimer *timer2;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.guessDraw.strokeList = self.strokeList;
    
    self.guessDraw.strokeList = [[NSMutableArray alloc]init];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(slowDraw) userInfo:NULL repeats:YES];
    timer2 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkAnswer) userInfo:NULL repeats:YES];
    self.answer_label.text = self.answer;
    self.answer_word = [[NSMutableArray alloc]init];
    [self answerPrepare];
    self.question_button_list = [[NSMutableArray alloc]init];
    self.answer_list = [[NSMutableArray alloc]initWithArray:self.answer_word copyItems:YES];
    [self answerListInit];
    [self answerButtonInit];
    
    
}

-(void) answerListInit
{
    NSString* s = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for(int i=0; i<20-[self.answer length];i++)
    {
        unichar c = [s characterAtIndex:(arc4random() % 36)];
        NSString *s = [[NSString alloc] initWithCharacters:&c length:1];
        [self.answer_list addObject:s];
    }
    [self shuffle];
    
}

-(void)shuffle
{
    NSUInteger count = [self.answer_list count];
    for(NSUInteger i =0; i< count;i++)
    {
        int nElement = count - i;
        int n = (arc4random() % nElement)+i;
        [self.answer_list exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}
    
-(void) slowDraw
{
    
    ModStroke *now_stroke = (__bridge ModStroke *)((__bridge CGMutablePathRef)([self.strokeList objectAtIndex:stroke_idx]));
    NSValue *val = [now_stroke.pointArray objectAtIndex:point_idx];
    CGPoint p = [val CGPointValue];
    if(point_idx == 0)
    {
        self.stroke = [[ModStroke alloc]init];
        self.stroke.pen_path = CGPathCreateMutable();
        CGPathMoveToPoint(self.stroke.pen_path, NULL, p.x  , p.y);
        self.stroke.pen_color = now_stroke.pen_color;
        self.stroke.pen_size = now_stroke.pen_size;
        
        [self.guessDraw.strokeList addObject:self.stroke];
    }
    else
    {
        CGPathAddLineToPoint(self.stroke.pen_path, NULL, p.x, p.y);
        [self.guessDraw.strokeList replaceObjectAtIndex:stroke_idx withObject:self.stroke];
    }
    
    
    if(point_idx < [now_stroke.pointArray count]-1)
    {
        point_idx++;
    }
    else
    {
        point_idx = 0;
        if(stroke_idx < [self.strokeList count]-1)
        {
            stroke_idx ++;
            
        }
        else
        {
            stroke_idx =0;
            self.guessDraw.strokeList = [[NSMutableArray alloc]init];
        }
        
    }
    
    [self.guessDraw setNeedsDisplay];
}

-(void)answerPrepare
{
    for(int i=0; i<[self.answer length];i++)
    {
        unichar c = [[self.answer uppercaseString] characterAtIndex:i];
        NSString *s = [[NSString alloc] initWithCharacters:&c length:1];
        [self.answer_word addObject:s];
    }
                   
}

-(void)answerButtonInit
{
    
    for(int i=0; i< [self.answer length]; i++ )
    {
        float inv = 375.0/[self.answer length];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake( 0 + (inv*i), 0, inv-5, 30);
        button.titleLabel.font = [UIFont systemFontOfSize:26.0];
        [button setTitle:[NSString stringWithFormat:@""] forState:normal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.layer.cornerRadius = 3.0;
        button.layer.borderWidth = 1.5;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        [button addTarget:self action: @selector(questionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.question_button_list addObject:button];
        [self.AnswerView addSubview:button];
    }
    NSUInteger count =0;
    for(int k = 0;k < 2 ; k++ )
    {
        for(int i = 0;i < 10; i++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(375.0*i/10.0, 40*(k+1), 375.0/10.0, 30);
            button.titleLabel.font = [UIFont systemFontOfSize:24.0];
            [button setTitle:[NSString stringWithString:[self.answer_list objectAtIndex:count]] forState:normal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button addTarget:self action: @selector(answerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.AnswerView addSubview:button];
            count ++;
        }
    }
}

-(IBAction)giveupClick
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Give Up?" message:@"Really want to give up?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self guessViewReset];
        [self.navigationController popViewControllerAnimated:YES];
    } ];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    } ];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void) checkAnswer
{
    int true_times=0;
    for(int i=0;i<[self.question_button_list count];i++)
    {
        NSString *s = [[[self.question_button_list objectAtIndex:i] titleLabel ]text];
        if([s isEqualToString: [self.answer_word objectAtIndex:i]])
        {
            true_times++;
        }
    }
    if(true_times == [self.question_button_list count])
    {
        [self guessViewReset];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Well done!!" message:@"Right answer~" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self.needDraw = [[NSNumber alloc]initWithBool:YES];
            
            [self.navigationController popViewControllerAnimated:YES];
        } ];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



-(void) questionButtonClick : (UIButton*)sender
{
    self.now_question_button = sender;
}

-(void) answerButtonClick : (UIButton*)sender
{
    if(self.now_question_button != NULL)
    {
        [self.now_question_button setTitle:NULL forState:normal];
        [self.now_question_button setTitle:sender.titleLabel.text forState:normal];
        self.now_question_button = NULL;
        
        [self checkAnswer];
    }
}

-(void) guessViewReset
{
    stroke_idx=0;
    point_idx =0;
    [timer invalidate];
    [timer2 invalidate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
