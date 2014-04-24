//
//  SLFSelfyViewController.m
//  Selfy
//
//  Created by Derek Weber on 4/22/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFSelfyViewController.h"

@interface SLFSelfyViewController ()

@end

@implementation SLFSelfyViewController
{
    UIButton * submit;
    UIButton * cancel;
    UITextView * caption;
    UIImageView * newSelfy;
    UIView * newForm;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        newForm = [[UIView alloc] initWithFrame:self.view.frame];
        
        [self.view addSubview:newForm];
        
        caption = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 40, 160, 110)];
        caption.textColor = [UIColor blackColor];
        caption.backgroundColor = [UIColor lightGrayColor];
        caption.layer.cornerRadius = 6;
        [caption.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
        [caption.layer setBorderWidth: 2.0];
        caption.keyboardType = UIKeyboardTypeTwitter;
        caption.delegate = self;
        
        [newForm addSubview:caption];
        
        newSelfy = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 170, 160, 110)];
        newSelfy.backgroundColor = [UIColor lightGrayColor];
        [newSelfy.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
        [newSelfy.layer setBorderWidth: 2.0];

        [newForm addSubview:newSelfy];
        
        
        cancel = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 340, 160, 30)];
        [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont systemFontOfSize:12];
        
        cancel.backgroundColor = [UIColor redColor];
        cancel.layer.cornerRadius = 6;
        //        [submit addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
        
        [newForm addSubview:cancel];
        
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, 390, 160, 30)];
        [submit setTitle:@"newSelfy" forState:UIControlStateNormal];
        submit.titleLabel.font = [UIFont systemFontOfSize:12];
        
        submit.backgroundColor = [UIColor blueColor];
        submit.layer.cornerRadius = 6;
//        [submit addTarget:self action:@selector(newSelfy) forControlEvents:UIControlEventTouchUpInside];
    
        
        [newForm addSubview:submit];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen)];
        [self.view addGestureRecognizer:tap];
        
        
    }
    return self;
}

- (void)tapScreen
{
    [caption resignFirstResponder];
    
//    [UIView animateWithDuration:0.2 animations:^{ newForm.frame = CGRectMake(0,-KB_HEIGHT, 320, self.view.frame.size.height);}];
    newForm.frame = self.view.frame;
    

}

//-(void)newSelfy
//{
//    PFObject *testObject = [PFObject objectWithClassName:@"newSelfy"];
//    newSelfy [@"foo"] = @"bar";
//    [newSelfy saveInBackground];
//    
//
//}
//- (BOOL)textViewShouldReturn:(UITextView *)textView;
//{
//    [caption resignFirstResponder];
//    
//    
//    return YES;
//}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{ newForm.frame = CGRectMake(0,-KB_HEIGHT, 320, self.view.frame.size.height);}];
     
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
