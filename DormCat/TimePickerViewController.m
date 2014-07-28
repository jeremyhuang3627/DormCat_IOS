//
//  TimePickerViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/26/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "TimePickerViewController.h"

@interface TimePickerViewController ()

@end

@implementation TimePickerViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)next
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
