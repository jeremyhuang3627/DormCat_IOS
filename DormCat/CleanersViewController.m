//
//  CleanersViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/22/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "CleanersViewController.h"
#import "CleanerCell.h"
#import "Cleaner.h"
#import "Macros.h"
#import "TabBarViewController.h"

static NSString *const CleanerCellIdentifier = @"CleanerCell";

@implementation CleanersViewController
{
    NSMutableArray * cleaners;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        cleaners = [[NSMutableArray alloc] init];
        for(int i=0;i<3;i++){
            NSLog(@"initializing cleaner %d",i);
            Cleaner * a_cleaner = [[Cleaner alloc] init];
            a_cleaner.userName = [NSString stringWithFormat:@"Cleaner%d",i];
            a_cleaner.introduction = [NSString stringWithFormat:@"I am fast and efficient"];
            a_cleaner.favorites = [NSNumber numberWithInt:i];
            a_cleaner.rating = [NSNumber numberWithDouble:i/10];
            [cleaners addObject:a_cleaner];
        }
        NSLog(@"cleaners count %d",[cleaners count]);
        self.tabBarItem = [[UITabBarItem alloc ]initWithTitle:@"Cleaners" image:[UIImage imageNamed:@"User.png"] tag:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    UINib *cellNib = [UINib nibWithNibName:CleanerCellIdentifier bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:CleanerCellIdentifier];
    self.tableView.rowHeight = 90;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cleaners count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CleanerCell * cc = (CleanerCell *)[tableView dequeueReusableCellWithIdentifier:CleanerCellIdentifier];
    Cleaner * cl = [cleaners objectAtIndex:indexPath.row];
    [cc.username setText:cl.userName];
    [cc.description setText:cl.introduction];
    [cc.favorites setText:[cl.favorites stringValue]];
    [cc.rating setText:[cl.rating stringValue]];
    return cc;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)btnMovePanelLeft:(id)sender
{
    [self.dcTabBarViewController dynamicsDrawerRevealRightBarButtonItemTapped:sender];
}

@end
