//
//  ViewController.m
//  Canvas
//
//  Created by Lee Joe on 4/2/15.
//  Copyright (c) 2015 Lee Joe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

unsigned int pathCount=0;
UIColor *now_color;
UIColor *background_color;
float now_penSize = 10.0f;
bool now_isErase = false;
bool empty_touch = false;


@implementation ViewController

@synthesize yellow_button = _yellow_button;
@synthesize black_button = _black_button;
@synthesize red_button = _red_button;
@synthesize blue_button = _blue_button;
@synthesize purple_button =_purple_button;
@synthesize brown_button = _brown_button;
@synthesize white_button = _white_button;
@synthesize green_button =_green_button;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //drawing *mydraw = [[drawing alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    //self.mydraw = [[drawing alloc]initWithFrame:CGRectMake(0, 20, 320, 750)];
    //[self.view addSubview:_mydraw];
    /*
    CGRect newFrame = self.mydraw.frame;
    newFrame.size.width = 370;
    newFrame.size.height = 700;
    [self.mydraw setFrame:newFrame];
     */
    self.needDraw = [[NSNumber alloc]initWithBool:YES];
    
    self.strokeList = [[NSMutableArray alloc]init];
    now_color = [UIColor blackColor];
    background_color = [UIColor clearColor];
    self.white_button.layer.cornerRadius =3.0;
    self.white_button.layer.borderWidth =1.0;
    self.white_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.black_button.layer.cornerRadius =3.0;
    self.black_button.layer.borderWidth =1.0;
    self.black_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.red_button.layer.cornerRadius =3.0;
    self.red_button.layer.borderWidth =1.0;
    self.red_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.green_button.layer.cornerRadius =3.0;
    self.green_button.layer.borderWidth =1.0;
    self.green_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.purple_button.layer.cornerRadius =3.0;
    self.purple_button.layer.borderWidth =1.0;
    self.purple_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.yellow_button.layer.cornerRadius =3.0;
    self.yellow_button.layer.borderWidth =1.0;
    self.yellow_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.brown_button.layer.cornerRadius =3.0;
    self.brown_button.layer.borderWidth =1.0;
    self.brown_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.blue_button.layer.cornerRadius =3.0;
    self.blue_button.layer.borderWidth =1.0;
    self.blue_button.layer.borderColor =[UIColor blackColor].CGColor;
    self.myPen_preview.layer.cornerRadius = 5.0;
    self.myPen_preview.layer.borderWidth = 1.5;
    self.myPen_preview.layer.borderColor = [UIColor blackColor].CGColor;
    self.myPen_preview.now_stroke = [[ModStroke alloc]init];
    self.myPen_preview.now_stroke.pen_size = now_penSize;
    self.myPen_preview.now_stroke.pen_color = now_color;
    [self.myPen_preview setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.needDraw==[[NSNumber alloc]initWithBool:YES])
    {
        ModStroke *s=[[ModStroke alloc]init];
        s.pen_color = now_color;
        s.pen_path = CGPathCreateMutable();
        s.pen_size = now_penSize;
        self.stroke = s;
        //self.myPen_preview.now_stroke = self.stroke;
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:self.mydraw];
        self.stroke.pointArray = [[NSMutableArray alloc] init];
        [self.stroke.pointArray addObject:[NSValue valueWithCGPoint:location]];
        CGPathMoveToPoint((self.stroke.pen_path), NULL, location.x  , location.y);
        [self.strokeList addObject:(id)self.stroke];
        //UIGraphicsPushContext(UIGraphicsGetCurrentContext());
        self.mydraw.strokeList = self.strokeList;
        empty_touch = true;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.needDraw==[[NSNumber alloc]initWithBool:YES])
    {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:self.mydraw];
        [self.stroke.pointArray addObject:[NSValue valueWithCGPoint:location]];
        ModStroke *now_stroke = (__bridge ModStroke *)((__bridge CGMutablePathRef)([self.strokeList objectAtIndex:[self.strokeList count]-1]));
        CGPathAddLineToPoint(now_stroke.pen_path, NULL, [touch locationInView:self.mydraw].x , [touch locationInView:self.mydraw].y);
        self.mydraw.now_stroke = self.stroke;
        NSLog(@"%f , %f",location.x ,location.y);
        [self.mydraw setNeedsDisplay];
        empty_touch = false;
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
        //UIGraphicsPushContext(UIGraphicsGetCurrentContext());
    if(self.needDraw==[[NSNumber alloc]initWithBool:YES])
    {
        if(empty_touch)
        {
            [self.strokeList removeObjectAtIndex:[self.strokeList count]-1];
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(IBAction)undoClick:(id)sender
{
    
    //UIGraphicsPopContext();
    if([self.strokeList count] > 0 )
    {
        [self.strokeList removeObjectAtIndex:[self.strokeList count]-1];
    }
    [self.mydraw setBackgroundColor:[UIColor clearColor]];
    NSLog(@"%lu" , (unsigned long)[self.strokeList count]);
    self.mydraw.strokeList = self.strokeList;
    [self.mydraw setNeedsDisplayInRect:*(self.mydraw.rect)];
    //UIGraphicsPopContext();
    self.mydraw.isUndo = true;
    [self.mydraw setNeedsDisplay];
    
}

-(IBAction)valueChanged :(UIStepper *)sender
{
    float pen_newsize = [sender value];
    //self.stroke.pen_size = pen_newsize;
    now_penSize = pen_newsize;
    self.myPen_preview.now_stroke.pen_size = now_penSize;
    [self.myPen_preview setNeedsDisplay];
    
}

-(IBAction)eraseClick:(id)sender
{
    //now_isErase = true;
    now_color = [UIColor whiteColor];
    self.myPen_preview.now_stroke.pen_color = now_color;
    [self.myPen_preview setNeedsDisplay];
}

-(IBAction)colorClick:(UIButton*)sender
{
    if(sender == _white_button)
    {
        now_color = [UIColor whiteColor];
    }
    else if (sender == _black_button)
    {
        now_color = [UIColor blackColor];
    }
    else if(sender == _red_button)
    {
        now_color = [UIColor redColor];
    }
    else if (sender == _blue_button)
    {
        now_color = [UIColor blueColor];
    }
    else if (sender == _brown_button)
    {
        now_color = [UIColor brownColor];
    }
    else if (sender == _yellow_button)
    {
        now_color = [UIColor yellowColor];
    }
    else if (sender == _green_button)
    {
        now_color = [UIColor greenColor];
    }
    else if (sender == _purple_button)
    {
        now_color = [UIColor purpleColor];
    }
    
    self.myPen_preview.now_stroke.pen_color = now_color;
    [self.myPen_preview setNeedsDisplay];
}

-(IBAction)ClearClick:(id)sender
{
    [self.strokeList removeAllObjects];
    [self.mydraw setNeedsDisplay];
}

-(IBAction)NextClick:(id)sender
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Input title:" message:@"Please input the title. " preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler: ^(UITextField *textField) {
        textField.placeholder = @"title";
        self.graph_title = textField.text;
    } ];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        self.graph_title = [alert.textFields[0] text];
        if([self.graph_title length] >0 && [self.graph_title length]<11)
        {
            self.needDraw = [[NSNumber alloc]initWithBool:NO];
            [self performSegueWithIdentifier:@"To GuessViewController" sender:self];
            self.needDraw = [[NSNumber alloc]initWithBool:YES];
            //[self.myPen_preview setNeedsDisplay];
        }
        else
        {
            UIAlertController* alert2 =[UIAlertController alertControllerWithTitle:@"ERROR!" message:@"Character number must in the range:1~10 " preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction2 =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            [alert2 addAction:defaultAction2];
            [self presentViewController:alert2 animated:NO completion:nil];
        }
    } ];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {} ];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"To GuessViewController"])
    {
        GuessViewController *gvc =segue.destinationViewController;
        gvc.answer = self.graph_title;
        gvc.strokeList = self.strokeList;
        gvc.needDraw = self.needDraw;
    }
}


@end
