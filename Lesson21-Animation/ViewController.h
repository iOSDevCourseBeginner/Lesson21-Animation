//
//  ViewController.h
//  Lesson21-Animation
//
//  Created by Nick Bibikov on 10/16/14.
//  Copyright (c) 2014 NickBibikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.8]


@interface ViewController : UIViewController


@end

