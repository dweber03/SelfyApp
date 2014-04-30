//
//  SLFSettingsButton.m
//  Selfy
//
//  Created by Derek Weber on 4/30/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFSettingsButton.h"

@implementation SLFSettingsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)toggle
{
    //!self is defined as not self
    self.toggled = !self.toggled;
}




-(void)setToggled:(BOOL)toggled
{
    // this method allows us to return a value of YES/NO instead of returning NIL for !self.toggled
    _toggled= toggled;
    
    self.alpha = 0.0;
    [self setNeedsDisplay];
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:nil];
    
    
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float pad = 1.0;
    float w = rect.size.width - pad;
    float h = rect.size.height - pad;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextClearRect(context, rect);
    [self.tintColor set];
    
    if([self isToggled])
    {
        CGContextMoveToPoint(context, pad, pad);
        CGContextAddLineToPoint(context, w, h);
        
        CGContextMoveToPoint(context, w, pad);
        CGContextAddLineToPoint(context, pad, h);
        
    } else {
        
        CGContextMoveToPoint(context, pad, pad);
        CGContextAddLineToPoint(context, w, pad);
        
        CGContextMoveToPoint(context, pad, h/2);
        CGContextAddLineToPoint(context, w , h/2);
        
        CGContextMoveToPoint(context, pad, h);
        CGContextAddLineToPoint(context, w , h);
    }
    
//    int numLines = 5;
//    float ySpacing
        CGContextStrokePath(context);
}
    
    
@end
    
    
