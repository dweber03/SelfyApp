//
//  SLFNavController.m
//  Selfy
//
//  Created by Derek Weber on 4/24/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFNavController.h"

#import "SLFViewController.h"

@interface SLFNavController () <UITextViewDelegate>

@end

@implementation SLFNavController


{
    UIView * loginForm;
    
    SLFViewController * SLF;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    loginForm = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:loginForm];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addViewController:(SLFViewController *)viewController
{
     SLF = viewController;
    
    [self pushViewController:viewController animated:NO];
    
//    if ([SLF isTweetItemsEmpty])
//    {
//        [self newItem:nil];
//    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
