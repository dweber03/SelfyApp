//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Derek Weber on 4/22/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFSelfyViewController.h"
#import <Parse/Parse.h>
#import "SLFViewController.h"

@interface SLFSelfyViewController ()

@end

@implementation SLFSelfyViewController
{
    UIButton * submit;
    UIButton * cancel;
    UITextView * caption;
    UIImageView * imageView;
    UIView * newForm;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        newForm = [[UIView alloc] initWithFrame:self.view.frame];
        
        [self.view addSubview:newForm];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 280)];
        imageView.image = [UIImage imageNamed:@"boss"];
        imageView.backgroundColor = [UIColor whiteColor];
        
        [newForm addSubview:imageView];
        
       
        caption = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 300, 160, 30)];
       caption.textColor = [UIColor blackColor];
        caption.backgroundColor = [UIColor lightGrayColor];
        caption.layer.cornerRadius = 6;
        [caption.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
        [caption.layer setBorderWidth: 2.0];
        caption.keyboardType = UIKeyboardTypeTwitter;
        caption.delegate = self;
        
        [newForm addSubview:caption];
//        
//        UIImageView * newSelfy = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 170, 160, 110)];
//        newSelfy.backgroundColor = [UIColor lightGrayColor];
//        [newSelfy.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
//        [newSelfy.layer setBorderWidth: 2.0];
//
//        [newForm addSubview:newSelfy];
        
        
//        cancel = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 290, 160, 30)];
//        [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
//        cancel.titleLabel.font = [UIFont systemFontOfSize:12];
//        
//        cancel.backgroundColor = [UIColor redColor];
//        cancel.layer.cornerRadius = 6;
//        //        [submit addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
//        
//        [newForm addSubview:cancel];
        
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 330, 160, 30)];
        [submit setTitle:@"newSelfy" forState:UIControlStateNormal];
        submit.titleLabel.font = [UIFont systemFontOfSize:12];
        
        submit.backgroundColor = [UIColor blueColor];
        submit.layer.cornerRadius = 6;
        [submit addTarget:self action:@selector(newSelfy) forControlEvents:UIControlEventTouchUpInside];
    
        
        [newForm addSubview:submit];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        
    }
    return self;
}

- (void)tapScreen
{
    [caption resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{ newForm.frame = CGRectMake(0,-KB_HEIGHT, 320, self.view.frame.size.height);}];
    newForm.frame = self.view.frame;
    

}

-(void)newSelfy
{

    // connect current user to newSelfy as parent - Parse/Objects/Relational Data documentation to create a Parent
    
    NSData * imageData = UIImagePNGRepresentation(imageView.image);
    
    
    
//    UIImage * image = [UIImage imageNamed:@"heart"];
    PFFile * imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    PFObject * newSelfy = [PFObject objectWithClassName:@"UserSelfy"];
    newSelfy[@"caption"] = caption.text;
    newSelfy[@"image"] = imageFile;
    [newSelfy saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"%u", succeeded);
        [self cancelNewSelfy];
        
    }];
    
    
    
}
- (BOOL)textViewShouldReturn:(UITextView *)textView;
{
    [caption resignFirstResponder];
    
    
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{ newForm.frame = CGRectMake(0,-KB_HEIGHT, 320, self.view.frame.size.height);}];
     
}
     
     
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * cancelNewSelfyButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNewSelfy)];
    
    cancelNewSelfyButton.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = cancelNewSelfyButton;
    [self setNeedsStatusBarAppearanceUpdate];
    
}

-(void)cancelNewSelfy
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

@end
