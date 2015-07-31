//
//  ViewController.m
//  FYStarSlider
//
//  Created by yangfeiyu on 15-7-31.
//  Copyright (c) 2015年 NJJ. All rights reserved.
//

#import "ViewController.h"
#import "FYStarSliderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FYStarSliderView *starSlider = [[FYStarSliderView alloc] initWithFrame:CGRectMake(0, 100, 300, 100)];
    [starSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:starSlider];
    
}

- (void)valueChanged:(UIView *)sender {
    NSLog(@"----valueChanged-------");
}



@end
