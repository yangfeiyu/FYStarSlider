//
//  FYStarSliderView.m
//  FYStarSlider
//
//  Created by yangfeiyu on 15-7-31.
//  Copyright (c) 2015年 NJJ. All rights reserved.
//

#import "FYStarSliderView.h"

#define imageNormal [UIImage imageNamed:@"star"]
#define imageHighlight [UIImage imageNamed:@"starHighlight"]

static NSInteger const WIDTH = 50;
@implementation FYStarSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    float offsetCenter = WIDTH;
    for (int i = 0; i <= 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH)];
        imageView.image = imageNormal;
        imageView.center = CGPointMake(offsetCenter, self.intrinsicContentSize.height / 2);
        offsetCenter += WIDTH * 1.5f;
        [self addSubview:imageView];
    }
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(WIDTH * 8.0f, 34.0f);
}

#pragma mark - 
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    [self updateValueAtPoint:point];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.frame, point)) {
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    } else {
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
    }
    [self updateValueAtPoint:point];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.frame, point)) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
        [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [self sendActionsForControlEvents:UIControlEventTouchCancel];
}

#pragma mark - private methods
- (void)updateValueAtPoint:(CGPoint)point {
    int newValue = 0;
    UIImageView *changedView = nil;
    
    for (UIImageView *eachItem in [self subviews]) {
        if (point.x < eachItem.frame.origin.x) {
            eachItem.image = imageNormal;
        } else {
            eachItem.image =imageHighlight;
            changedView = eachItem;
            newValue ++;
        }
    }
    
    if (self.value != newValue) {
        self.value = newValue;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        [UIView animateWithDuration:0.15f animations:^{
            changedView.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        } completion:^(BOOL finished) {
            changedView.transform = CGAffineTransformIdentity;
        }];
    }
}

@end
