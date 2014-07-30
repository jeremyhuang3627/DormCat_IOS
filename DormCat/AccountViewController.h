//
//  AccountViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/25/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextField *firstNameField;
@property (nonatomic, strong) IBOutlet UITextField *lastNameField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;
@property (nonatomic, strong) IBOutlet UITextField *mobileField;
@property (nonatomic, strong) IBOutlet UITextField *streetAddressField;
@property (nonatomic, strong) IBOutlet UITextField *roomNumberField;
@property (nonatomic, strong) IBOutlet UITextField *zipCodeField;
@end
