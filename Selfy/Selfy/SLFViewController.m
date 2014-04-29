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
#import "SLFSignUpViewController.h"

@interface SLFViewController ()

@end

@implementation SLFViewController

{
    UIView * loginForm;
    
    UITextField * username;
    UITextField * password;
    UIButton * SignIn;
    //    UIButton * SignUp;
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        loginForm = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:loginForm];
        
        username = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 90, 160, 30)];
        username.placeholder = @"New User";
        username.textColor = [UIColor blackColor];
        username.backgroundColor = [UIColor darkGrayColor];
        username.layer.cornerRadius = 6;
        username.delegate = self;
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        username.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [loginForm addSubview:username];
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 150, 160, 30)];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        password.textColor = [UIColor blackColor];
        password.backgroundColor = [UIColor darkGrayColor];
        password.layer.cornerRadius = 6;
        password.delegate = self;
        
        [loginForm addSubview:password];
        
        SignIn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 220, 160, 30)];
        [SignIn setTitle:@"SignIn" forState:UIControlStateNormal];
        SignIn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        SignIn.backgroundColor = [UIColor blueColor];
        SignIn.layer.cornerRadius = 6;
        [SignIn addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
        
        [loginForm addSubview:SignIn];
        
        UIButton * SignUp = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 260, 160, 30)];
        [SignUp setTitle:@"SignUp" forState:UIControlStateNormal];
        SignUp.titleLabel.font = [UIFont systemFontOfSize:12];
        
        SignUp.backgroundColor = [UIColor blueColor];
        SignUp.layer.cornerRadius = 6;
        [SignUp addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        [loginForm addSubview: SignUp];
        
        
        // remove auto capitalization
        // animate login screen up
        
    }
    return self;
}

-(void)signUp
{
    SLFSignUpViewController * signUpVC = [[SLFSignUpViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:signUpVC];
    nc.navigationBar.barTintColor = [UIColor blueColor];
    nc.navigationBar.translucent = NO;
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
    }];
    
}

-(void)signIn
{
    //
    //    PFUser * user = [PFUser currentUser];
    //
    //    user.username = username.text;
    //    user.password = password.text;
    //
    //    username.text = nil;
    //    password.text = nil;
    
    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    
    activityIndicator.color = [UIColor orangeColor];
    activityIndicator.frame = CGRectMake(0, 150, 160, 30);
    [SignIn addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    
    
    // UIActiviyIndicatorView in the login
    // create a method that begins with start tied to the UIActivityIndicator & add it to subview
    
    [PFUser logInWithUsernameInBackground:username.text password:password.text block:^(PFUser *user, NSError * error) {
        
        NSLog(@"logged in %@", user.username);
        NSLog(@"current user %@", [PFUser currentUser].username);
        
        
        if (error == nil)
        {
            
            self.navigationController.navigationBarHidden = NO;
            
            self.navigationController.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            
        } else {
            
            password.text = nil;
            [activityIndicator removeFromSuperview];
            
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
