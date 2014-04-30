//
//  SLFSettingsButton.h
//  Selfy
//
//  Created by Derek Weber on 4/30/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFSettingsButton : UIButton

@property (nonatomic, getter = isToggled) BOOL toggled;

@property (nonatomic) UIColor * toggledTintColor;



-(void)toggle;

@end
