//
//  ViewController.m
//  Lesson21-Animation
//
//  Created by Nick Bibikov on 10/16/14.
//  Copyright (c) 2014 NickBibikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray* viewsArray;
@property (strong, nonatomic) NSArray* colorArray;
@property (assign, nonatomic) NSInteger sizeView;
@property (assign, nonatomic) NSInteger forward;
@end

@implementation ViewController

//-------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewsArray   = [[NSMutableArray alloc] init];
    NSInteger size       = 100;
    self.sizeView        = size;
    CGRect rectBounds    = self.view.bounds;

    NSArray* colorArray  = [[NSArray alloc] initWithObjects: UIColorFromRGB(0xf10046), UIColorFromRGB(0x9c6c4a),
                            UIColorFromRGB(0x0098da), UIColorFromRGB(0x3ec23f), nil];
    self.colorArray = colorArray;
    //Create views
    [self createViewWithX:0 andY:0 andSize:size andColor:[colorArray objectAtIndex:0]];
    [self createViewWithX:CGRectGetWidth(rectBounds) - size andY:0 andSize:size andColor:[colorArray objectAtIndex:1]];
    [self createViewWithX:CGRectGetWidth(rectBounds) - size andY:CGRectGetHeight(rectBounds) - size andSize:size andColor:[colorArray objectAtIndex:2]];
    [self createViewWithX:0 andY:CGRectGetHeight(rectBounds) - size andSize:size andColor:[colorArray objectAtIndex:3]];

    for (UIView* view in self.viewsArray) {
        [self startAnimationForward:view];
    }


    // Do any additional setup after loading the view, typically from a nib.
}
//-------------------------------------------------------------------------------
    //Create views and add to mutableArray
- (UIView*) createViewWithX: (CGFloat)x andY: (CGFloat)y andSize: (NSInteger)size andColor: (UIColor*)color {

    CGRect rect          = CGRectMake(x, y, size, size);
    UIView* view         = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    [self.viewsArray addObject:view];
    [self.view addSubview:view];
    return view;
}

//-------------------------------------------------------------------------------
- (void) startAnimationForward: (UIView*)view {
   
    CGFloat x = CGRectGetMinX(view.frame);
    CGFloat y = CGRectGetMinY(view.frame);
    UIColor* color = [[UIColor alloc] init];
    BOOL forward = arc4random() % 2;
    
    if (!forward) {
    
        if (x == 0 && y == 0) {
            x = CGRectGetWidth(self.view.bounds) - (CGFloat)self.sizeView;
            color = [self.colorArray objectAtIndex:1];
        }
        else if (x == CGRectGetWidth(self.view.bounds) - self.sizeView && y == 0) {
            y = CGRectGetHeight(self.view.bounds) - self.sizeView;
            color = [self.colorArray objectAtIndex:2];
        }
        else if (x == CGRectGetWidth(self.view.bounds) - self.sizeView &&  y == CGRectGetHeight(self.view.bounds) - self.sizeView) {
            x = 0;
            color = [self.colorArray objectAtIndex:3];
        }
        else if (x == 0 && y == CGRectGetHeight(self.view.bounds) - self.sizeView) {
            y = 0;
            color = [self.colorArray objectAtIndex:0];
        }

 else {
    
        if (x == 0 && y == 0) {
            y = CGRectGetHeight(self.view.bounds) - self.sizeView;
            color = [self.colorArray objectAtIndex:3];
        }
        else if (x == 0 && y == CGRectGetHeight(self.view.bounds) - self.sizeView) {
            x = CGRectGetWidth(self.view.bounds) - self.sizeView;
            color = [self.colorArray objectAtIndex:2];
        }
        else if (x == CGRectGetWidth(self.view.bounds) - self.sizeView &&  y == CGRectGetHeight(self.view.bounds) - self.sizeView) {
            y = 0;
            color = [self.colorArray objectAtIndex:1];
        }
        else if (x == CGRectGetWidth(self.view.bounds) - self.sizeView && y == 0) {
            x = 0;
            color = [self.colorArray objectAtIndex:0];
        }
 } }

    
    [UIView animateWithDuration:4
                          delay:0
                        options:UIViewAnimationCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         view.center = CGPointMake(x + self.sizeView / 2, y + self.sizeView / 2);
                         view.backgroundColor = color;

                     } completion:^(BOOL finished) {
                
                         __weak UIView* weakView = view;
                         [self startAnimationForward:weakView];
                         
                     }];
        }
//-------------------------------------------------------------------------------

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
