//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by Derek Weber on 4/29/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFSettingsButton.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//-(BOOL)isToggled
//{

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    
    int w = rect.size.width - 2;
    int h = rect.size.height - 2;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    
    CGContextClearRect(context, rect);
    [self.tintColor set];
    
    CGContextMoveToPoint(context, 1, 1);
    CGContextAddLineToPoint(context, w , 1);
    
    CGContextMoveToPoint(context, 1, h/2);
    CGContextAddLineToPoint(context, w , h/2);
    
    CGContextMoveToPoint(context, 1, h/3);
    CGContextAddLineToPoint(context, w , h/3);
    
    
    
    CGContextStrokePath(context);
    
}


@end
