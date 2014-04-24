//
//  SLFViewController.m
//  Selfy
//
//  Created by Derek Weber on 4/22/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFViewController.h"
#import <Parse/Parse.h>

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
//        username.delegate = self;
        
        
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 180, 160, 30)];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        password.textColor = [UIColor blackColor];
        password.backgroundColor = [UIColor darkGrayColor];
        password.layer.cornerRadius = 6;
//        password.delegate = self;
        
        [self.view addSubview:password];
        
        SignIn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 300, 160, 30)];
        [SignIn setTitle:@"SignIn" forState:UIControlStateNormal];
        SignIn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        SignIn.backgroundColor = [UIColor blueColor];
        SignIn.layer.cornerRadius = 6;
        [SignIn addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:SignIn];
        
        
        
    }
    return self;
}

-(void)newUser
{
    PFUser * user = [PFUser currentUser];
    
    user.username = @"Derek Weber";
    user.password = @"password";
    
    [user saveInBackground];

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


//

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
