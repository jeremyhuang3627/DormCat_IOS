//
//  SavedCleanersViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/25/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "SavedCleanersViewController.h"
#import "Macros.h"

@interface SavedCleanersViewController ()

@end

@implementation SavedCleanersViewController

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
    self.view.backgroundColor = UIColorFromRGB(PROFILE_COLOR);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
