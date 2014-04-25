//
//  SLFViewController.m
//  Selfy
//
//  Created by Derek Weber on 4/22/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFViewController.h"
#import <Parse/Parse.h>
#import "SLFTableViewController.h"
#import "SLFSelfyViewController.h" 

@interface SLFViewController ()

@end

@implementation SLFViewController

{
    UITextField * username;
    UITextField * password;
    UIButton * SignIn;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        username = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 90, 160, 30)];
        username.placeholder = @"New User";
        username.textColor = [UIColor blackColor];
        username.backgroundColor = [UIColor darkGrayColor];
        username.layer.cornerRadius = 6;
        username.delegate = self;
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        username.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [self.view addSubview:username];
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 150, 160, 30)];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        password.textColor = [UIColor blackColor];
        password.backgroundColor = [UIColor darkGrayColor];
        password.layer.cornerRadius = 6;
        password.delegate = self;
        
        [self.view addSubview:password];
        
        SignIn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 220, 160, 30)];
        [SignIn setTitle:@"SignIn" forState:UIControlStateNormal];
        SignIn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        SignIn.backgroundColor = [UIColor blueColor];
        SignIn.layer.cornerRadius = 6;
        [SignIn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:SignIn];
        
        // remove auto capitalization
        // animate login screen up
        
    }
    return self;
}

-(void)signIn
{
    PFUser * user = [PFUser currentUser];
    
    user.username = username.text;
    user.password = password.text;
    
    username.text = nil;
    password.text = nil;
    
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    
    activityIndicator.color = [UIColor orangeColor];
    activityIndicator.frame = CGRectMake(0, 150, 160, 30);
    [SignIn addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    
    
    // UIActiviyIndicatorView in the login
    // create a method that begins with start tied to the UIActivityIndicator & add it to subview
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (error == nil)
        {
            [activityIndicator removeFromSuperview];
            
            self.navigationController.navigationBarHidden = NO;
            
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            
        } else {
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:errorDescription delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
            
            [alertView show];
//            error.userInfo[@"error"]
//            UIAlertView with message
            
            // if activity indicator errors out then removeFromSuperView
            
        }
    }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [username resignFirstResponder];
    [password resignFirstResponder];
;
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
