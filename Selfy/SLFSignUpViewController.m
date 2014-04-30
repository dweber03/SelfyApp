//
//  SLFSignUpViewController.m
//  Selfy
//
//  Created by Derek Weber on 4/29/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFSignUpViewController.h"
#import <Parse/Parse.h>
#import "SLFTableViewController.h"

@interface SLFSignUpViewController () <UITextFieldDelegate>

@end

@implementation SLFSignUpViewController
{
    UIView * signupForm;
    //    UITextField * usernameField;
    //    UITextField * displayNameField;
    //    UITextField * passwordField;
    //    UITextField * emailField;
    UIImageView * avatar;
    
    float signupOrigY;
    
    NSArray * fieldNames;
    NSMutableArray * fields;
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
        [self.view addGestureRecognizer:tap];
        
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem * cancelSignUpButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSignUp)];
    cancelSignUpButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelSignUpButton;
    
    signupOrigY = (self.view.frame.size.height - 240) / 2;
    signupForm = [[UIView alloc] initWithFrame:CGRectMake(20, signupOrigY, 280, 240)];
    
    [self.view addSubview: signupForm];
    
    fieldNames = @[
                   @"Username",
                   @"Password",
                   @"Display Name",
                   @"Email"
                   ];
    
    fields = [@[] mutableCopy];
    
    
    for (NSString * name in fieldNames)
    {
        NSInteger index = [fieldNames indexOfObject:name];
        
        UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(0, index * 50, 280, 40)];
        textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.placeholder = name;
        textField.textColor = [UIColor blackColor];
        textField.backgroundColor = [UIColor lightGrayColor];
        textField.layer.cornerRadius = 6;
        textField.delegate = self;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [fields addObject:textField];
        [signupForm addSubview:textField];
        
        UIButton * submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, [fieldNames count] * 50, 280, 40)];
        [submitButton setTitle:@"SignUp" forState:UIControlStateNormal];
        submitButton.backgroundColor = [UIColor blueColor];
        submitButton.layer.cornerRadius = 6;
        [submitButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        [signupForm addSubview: submitButton];
        
    }
    //    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 40)];
    //    usernameField.placeholder = @"Username";
    //    usernameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    //    usernameField.leftViewMode = UITextFieldViewModeAlways;
    //    usernameField.textColor = [UIColor blackColor];
    //    usernameField.backgroundColor = [UIColor darkGrayColor];
    //    usernameField.layer.cornerRadius = 6;
    //    usernameField.delegate = self;
    //    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //    usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    //
    //    [signupForm addSubview:usernameField];
    //
    //    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 280, 40)];
    //    passwordField.placeholder = @"Password";
    //    usernameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    //    usernameField.leftViewMode = UITextFieldViewModeAlways;
    //    passwordField.secureTextEntry = YES;
    //    passwordField.textColor = [UIColor blackColor];
    //    passwordField.backgroundColor = [UIColor darkGrayColor];
    //    passwordField.layer.cornerRadius = 6;
    //    passwordField.delegate = self;
    //
    //    [signupForm addSubview:passwordField];
    //
    //    displayNameField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 150, 160, 30)];
    //    displayNameField.placeholder = @"Displayname";
    //    displayNameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    //    displayNameField.leftViewMode = UITextFieldViewModeAlways;
    //    displayNameField.textColor = [UIColor blackColor];
    //    displayNameField.backgroundColor = [UIColor darkGrayColor];
    //    displayNameField.layer.cornerRadius = 6;
    //    displayNameField.delegate = self;
    //
    //    [signupForm addSubview:displayNameField];
    //
    //    emailField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 150, 160, 30)];
    //    emailField.placeholder = @"Email";
    //    emailField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    //    emailField.leftViewMode = UITextFieldViewModeAlways;
    //    emailField.textColor = [UIColor blackColor];
    //    emailField.backgroundColor = [UIColor darkGrayColor];
    //    emailField.layer.cornerRadius = 6;
    //    emailField.delegate = self;
    //
    //    [signupForm addSubview:emailField];
    //
    //
    

    avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boss"]];
    
    
    
    
    
    
    
    
    
    
}

-(void)signUp
{
    [self hideKeyboard];
    
    PFUser * user = [PFUser user];
    
    
    
    NSData * imageData = UIImagePNGRepresentation(avatar.image);
    
    PFFile * imageFile = [PFFile fileWithName:@"avatar.png" data:imageData];
    
    user.username = ((UITextField*)fields[0]).text;
    user.password = ((UITextField*)fields[1]).text;
    user.email = ((UITextField*)fields[3]).text;
    user[@"displayName"] = ((UITextField *)fields[2]).text;
    user[@"avatar"] = imageFile;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error == nil)
            
        {   UINavigationController * pnc = (UINavigationController *)self.presentedViewController;
            pnc.navigationBarHidden = NO;
            pnc.viewControllers = @[[[SLFTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            
            [self cancelSignUp];
        
        
            
        }else {
            
            NSString * errorDescription = error.userInfo[@"error"];
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Username Taken" message:errorDescription delegate:self cancelButtonTitle:@"Try Another Username" otherButtonTitles:nil];
            
            [alertView show];

            }
        
    }];
    
    
    
}

-(void)cancelSignUp
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    NSInteger index = [fields indexOfObject:textField];
//    NSInteger emptyIndex = [fields count];
//
//    for (UITextField * textFieldItem in fields)
//    {
//        NSInteger fieldIndex = [fields indexOfObject:textFieldItem];
//
//        if(emptyIndex == [fields count])
//        {
//            if([textFieldItem.text isEqualToString:@""])
//            {
//                emptyIndex = fieldIndex;
//            }
//
//        }
//    }
//
//    if(index <= emptyIndex) return YES;
//
//    return NO;
//
//}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%.00f", self.view.frame.size.height);
    
    int extraSlide = 0;
    
    if(self.view.frame.size.height > 500)
    {
        extraSlide = 107;
        
    } else {
        NSInteger index = [fields indexOfObject:textField];
        extraSlide = index *25 + 65;
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        signupForm.frame = CGRectMake(20, signupOrigY - extraSlide, 280, 240);
    }];
}

-(void)hideKeyboard
{
    for (UITextField * textFieldItem in fields)
    {
        [textFieldItem resignFirstResponder];
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        signupForm.frame = CGRectMake(20, signupOrigY, 280, 240);
    }];
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
