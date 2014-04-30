//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by Derek Weber on 4/21/14.
//  Copyright (c) 2014 Derek Weber. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell

{
    UIImageView * selfyView;
    UIImageView * avatarView;
    UILabel * selfyCaption;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
        
    {
        selfyView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
        selfyView .backgroundColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:selfyView];
        
        
        avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 40, 40)];
        avatarView .backgroundColor = [UIColor lightGrayColor];
        avatarView.layer.cornerRadius = 20;
        avatarView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:avatarView];
        
        selfyCaption = [[UILabel alloc] initWithFrame:CGRectMake(80, 300, 220, 40)];
        selfyCaption.textColor = [UIColor darkGrayColor];
        selfyCaption.text = @"Hello";
        
        [self.contentView addSubview:selfyCaption];
        
    }
    return self;
}



- (void)setSelfyInfo:(PFObject *)selfyInfo

{
    _selfyInfo = selfyInfo;
    
    //    selfyCaption.text = selfyInfo[@"caption"];
    selfyCaption.text = [selfyInfo objectForKey:@"caption"];
    
    
    
    //    NSURL * imageURL = [NSURL URLWithString:selfyInfo[@"image"]];
    //    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    //    UIImage * image = [UIImage imageWithData:imageData];
    
    PFFile * imageFile = [selfyInfo objectForKey:@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage * image = [UIImage imageWithData:data];
        selfyView.image = image;
        
        
    } progressBlock:^(int percentDone){
        
        //do something
    }];
    
    PFUser * user = [selfyInfo objectForKey:@"parent"];
    
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        PFFile * avatarFile = [object objectForKey:@"avatar"];
        
        [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
         {
             avatarView.image = [UIImage imageWithData:data];
             
         }];
    }];
    
    
    //    NSURL * avatarURL = [NSURL URLWithString:selfyInfo[@"avatar"]];
    //    NSData * avatarData = [NSData dataWithContentsOfURL:avatarURL];
    //    UIImage * avatar = [UIImage imageWithData:avatarData];
    //
    //    avatarView.image = avatar;
    
}

@end
