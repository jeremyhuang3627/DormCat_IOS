//
//  SubmittedOrdersViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/29/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "SubmittedOrdersViewController.h"
#import "OrderCell.h"
#import "Macros.h"
#import "NoOrderCell.h"
#import "MBProgressHUD.h"

static NSString *const OrderCellIdentifier = @"OrderCell";
static NSString *const NoOrderCellIdentifier = @"NoOrderCell";


@interface SubmittedOrdersViewController ()

@end

@implementation SubmittedOrdersViewController{
    NSMutableArray * orders;
    BOOL noOrders;
}

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray * ordersArray = [defaults objectForKey:@"orders"];
    orders = [NSMutableArray arrayWithArray:ordersArray];
    NSLog(@"orders %@",orders);
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    UINib *cellNib = [UINib nibWithNibName:OrderCellIdentifier bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:OrderCellIdentifier];
    
    cellNib = [UINib nibWithNibName:NoOrderCellIdentifier bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:NoOrderCellIdentifier];
    
    self.tableView.rowHeight = 130;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    
    if([orders count]){
        noOrders = NO;
    }else{
        noOrders = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(noOrders){
        return 1;
    }else{
        return [orders count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!noOrders){
    OrderCell * oc = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:OrderCellIdentifier];
    NSDictionary * order = [orders objectAtIndex:indexPath.row];
    NSString * orderString = @"";
    orderString = [orderString stringByAppendingString:[NSString stringWithFormat:@"%@ bed ",order[@"bed_room_number"]]];
    orderString = [orderString stringByAppendingString:[NSString stringWithFormat:@"%@ bath ",order[@"bath_room_number"]]];
    orderString = [orderString stringByAppendingString:[NSString stringWithFormat:@"%@ livin ",order[@"living_room_number"]]];
    orderString = [orderString stringByAppendingString:[NSString stringWithFormat:@"%@ kitchen",order[@"kitchen_number"]]];
    [oc.orderLabel setText:orderString];
    [oc.statusLabel setText:[NSString stringWithFormat:@"Status: %@",order[@"status"]]];
    [oc.amountLabel setText:[NSString stringWithFormat:@"Total: %@", order[@"total_amount"]]];
    NSDateFormatter * formatter = [NSDateFormatter new];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[((NSString *)order[@"date_time_since_epoc"]) doubleValue]/1000];
    NSLog(@"date %@",date);
    [formatter setDateFormat:@"EEE, MMM d HH:mm"];
    [oc.dateLabel setText:[NSString stringWithFormat:@"Date: %@",[formatter stringFromDate:date]]];
    [oc.addressLabel setText:[NSString stringWithFormat:@"Address: %@",order[@"street_address"]]];
    oc.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
        return oc;
    }else{
        NoOrderCell * noOrderCell = (NoOrderCell *)[tableView dequeueReusableCellWithIdentifier:NoOrderCellIdentifier];
        noOrderCell.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
        return noOrderCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteOrderAtIndexPath:indexPath fromTableView:tableView];
    }
}

-(void)deleteOrderAtIndexPath:(NSIndexPath *)indexPath fromTableView:(UITableView *)tableView
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString * orderId = [orders objectAtIndex:indexPath.row][@"_id"];
    [orders removeObjectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:orders forKey:@"orders"];
    NSURL *url = [NSURL URLWithString:[DEV_HOST stringByAppendingString:[NSString stringWithFormat:@"/cancel_order"]]];
    NSString * postString = [NSString stringWithFormat:@"order_id=%@",orderId];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue * q = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:req queue:q completionHandler:^(NSURLResponse * response, NSData * data,NSError * error){
        NSString * res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if([res isEqualToString:SUCCESS_MSG]){
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.labelText = @"Done!";
                [hud hide:YES];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Opps,this is embarrasing."
                                                             message:@"An error occured."
                                                            delegate:self
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
