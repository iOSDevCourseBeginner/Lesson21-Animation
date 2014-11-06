//
//  ViewController.m
//  Lesson21-Animation
//
//  Created by Nick Bibikov on 10/16/14.
//  Copyright (c) 2014 NickBibikov. All rights reserved.
//

#import "ViewController.h"
#define SIZE 100
#define ENDX CGRectGetWidth(self.view.bounds) - SIZE
#define ENDY CGRectGetHeight(self.view.bounds) - SIZE

@interface ViewController ()
@property (strong, nonatomic) NSArray* viewsArray;
@property (strong, nonatomic) NSArray* colorArray;
@property (strong, nonatomic) NSArray* cornerViewsArray;
@property (strong, nonatomic) NSArray* pointsArray;
@property (strong, nonatomic) NSArray* imageArray;
@property (strong, nonatomic) UIImageView* imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* firstView     = [[UIView alloc] initWithFrame:CGRectMake(100, 150, SIZE, SIZE)];
    UIView* secondView    = [[UIView alloc] initWithFrame:CGRectMake(100, 250, SIZE, SIZE)];
    UIView* thirdView     = [[UIView alloc] initWithFrame:CGRectMake(100, 350, SIZE, SIZE)];
    UIView* fourView      = [[UIView alloc] initWithFrame:CGRectMake(100, 450, SIZE, SIZE)];
    self.viewsArray       = [[NSArray alloc] initWithObjects:firstView, secondView, thirdView, fourView, nil];

    UIView* leftTop       = [[UIView alloc] initWithFrame:CGRectMake(0, ENDY, SIZE, SIZE)];
    UIView* rightTop      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE, SIZE)];
    UIView* rightBottom   = [[UIView alloc] initWithFrame:CGRectMake(ENDX, 0, SIZE, SIZE)];
    UIView* leftBottom    = [[UIView alloc] initWithFrame:CGRectMake(ENDX, ENDY, SIZE, SIZE)];
    rightTop.tag = 1;
    //self.rightTop = rightTop;
    
    self.cornerViewsArray = [[NSArray alloc] initWithObjects:   leftTop,
                                                                rightTop,
                                                                rightBottom,
                                                                leftBottom, nil];
    
    self.colorArray       = [NSArray arrayWithObjects:  UIColorFromRGB(0xf10046),
                                                        UIColorFromRGB(0x9c6c4a),
                                                        UIColorFromRGB(0x0098da),
                                                        UIColorFromRGB(0x3ec23f), nil];
    
    self.pointsArray      = [NSArray arrayWithObjects:  [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                                                        [NSValue valueWithCGPoint:CGPointMake(ENDX, 0)],
                                                        [NSValue valueWithCGPoint:CGPointMake(ENDX, ENDY)],
                                                        [NSValue valueWithCGPoint:CGPointMake(0, ENDY)], nil];

    UIImageView* imageView         = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE, SIZE)];
    self.imageView                 = imageView;
    self.imageArray                = [NSArray arrayWithObjects: [UIImage imageNamed:@"1.png"],
                                                                [UIImage imageNamed:@"2.png"],
                                                                [UIImage imageNamed:@"3.png"],
                                                                [UIImage imageNamed:@"4.png"],
                                                                [UIImage imageNamed:@"5.png"],
                                                                [UIImage imageNamed:@"6.png"],
                                                                [UIImage imageNamed:@"7.png"],
                                                                [UIImage imageNamed:@"8.png"],
                                                                [UIImage imageNamed:@"9.png"],
                                                                [UIImage imageNamed:@"10.png"], nil];

            for (UIView* view in self.viewsArray) {
    view.backgroundColor           = [self randomColor];
        [self.view addSubview:view];
        }

        [self startAnimation:firstView withAnimation:UIViewAnimationOptionCurveEaseIn];
        [self startAnimation:secondView withAnimation:UIViewAnimationOptionCurveEaseOut];
        [self startAnimation:thirdView withAnimation:UIViewAnimationOptionCurveEaseInOut];
        [self startAnimation:fourView withAnimation:UIViewAnimationOptionCurveLinear];


        for (UIView* view in self.cornerViewsArray) {
        [self.view addSubview:view];
        }

    self.imageView.animationImages = self.imageArray;
    self.imageView.transform       = CGAffineTransformMakeRotation(M_PI);
    [rightTop addSubview:imageView];

    [self.imageView startAnimating];

    [self startAnimationCorner:leftTop toPoints:self.pointsArray andColor:self.colorArray andStep:0];
    [self startAnimationCorner:rightTop toPoints:self.pointsArray andColor:self.colorArray andStep:1];
    [self startAnimationCorner:rightBottom toPoints:self.pointsArray andColor:self.colorArray andStep:2];
    [self startAnimationCorner:leftBottom toPoints:self.pointsArray andColor:self.colorArray andStep:3];


    
}

#pragma mark - Learner
- (void) startAnimation:(UIView*)view withAnimation:(UIViewAnimationOptions)animation {
    
    [UIView animateWithDuration:4
                          delay:1
                        options: animation | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations:^{
                         view.frame = CGRectMake(ENDX - SIZE, view.frame.origin.y, SIZE, SIZE);
                         view.backgroundColor = [self randomColor];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}
//-------------------------------------------------------------------------------
#pragma mark - Student

- (void) startAnimationCorner:(UIView*)view toPoints:(NSArray*)pointsArray andColor:(NSArray*)color andStep:(NSInteger)step {

    __block NSInteger steps = step;
    
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.frame = CGRectMake([[pointsArray objectAtIndex:steps]CGPointValue].x, [[pointsArray objectAtIndex:steps]CGPointValue].y, SIZE, SIZE);
                         view.backgroundColor = [color objectAtIndex:steps];
                     } completion:^(BOOL finished) {
                         if (steps == 3) {
                             steps = 0;
                         }
                         else steps++;
                         
                         if (view.tag == 1) {
                             switch (steps) {
                                 case 0:
                                     view.transform = CGAffineTransformMakeRotation(-M_PI_2);
                                     break;
                                 case 1:
                                     view.transform = CGAffineTransformMakeRotation(2*M_PI);
                                     break;
                                 case 2:
                                     view.transform = CGAffineTransformMakeRotation(M_PI_2);
                                     break;
                                 case 3:
                                     view.transform = CGAffineTransformMakeRotation(-M_PI);
                                     break;
                             } }
                         
                         [self startAnimationCorner:view toPoints:pointsArray andColor:color andStep:steps];
                     }];
   
}

//-------------------------------------------------------------------------------
- (UIColor*) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor* color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
