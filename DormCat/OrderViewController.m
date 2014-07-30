//
//  OrderViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/22/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "OrderViewController.h"
#import "macros.h"
#import "Order.h"

@interface OrderViewController ()
@end

@implementation OrderViewController{
    int bedRoomNumber;
    int bathRoomNumber;
    int livingRoomNumber;
    int kitchenNumber;
    double totalAmount;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc ]initWithTitle:@"Book" image:[UIImage imageNamed:@"Calendar.png"] tag:0];
        bedRoomNumber = 1;
        bathRoomNumber = 1;
        livingRoomNumber = 0;
        kitchenNumber = 0;
        [self updateTotal];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    self.topBar.backgroundColor = UIColorFromRGB(NAVIGATION_BAR_COLOR);
    [self.bedRoomNumberLabel setText:[NSString stringWithFormat:@"%d",bedRoomNumber]];
    [self.bathRoomNumberLabel setText:[NSString stringWithFormat:@"%d",bathRoomNumber]];
    [self.livingRoomNumberLabel setText:[NSString stringWithFormat:@"%d",livingRoomNumber]];
    [self.kitchenNumberLabel setText:[NSString stringWithFormat:@"%d",kitchenNumber]];
    [self updateTotal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

-(void)updateTotal
{
    totalAmount = (double)(bedRoomNumber + bathRoomNumber + livingRoomNumber + kitchenNumber) * PRICE_PER_ROOM;
    [self.totalAmountLabel setText:[NSString stringWithFormat:@"Total : $%d",(int)totalAmount]];
}

-(IBAction)done
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:bedRoomNumber forKey:BEDROOMNUMBER];
    [defaults setInteger:bathRoomNumber forKey:BATHROOMNUMBER];
    [defaults setInteger:livingRoomNumber forKey:LIVINGROOMNUMBER];
    [defaults setInteger:kitchenNumber forKey:KITCHENNUMBER];
    [defaults setDouble:totalAmount forKey:TOTALAMOUNT];
    [self.delegate placedOrder];
}

-(IBAction)increaseBedRoomNumber:(id)sender{
    bedRoomNumber++;
    [self.bedRoomNumberLabel setText:[NSString stringWithFormat:@"%d",bedRoomNumber]];
    [self updateTotal];
}

-(IBAction)increaseBathRoomNumber:(id)sender{
    bathRoomNumber++;
    [self.bathRoomNumberLabel setText:[NSString stringWithFormat:@"%d",bathRoomNumber]];
    [self updateTotal];
}

-(IBAction)increaseLivingRoomNumber:(id)sender{
    livingRoomNumber++;
    [self.livingRoomNumberLabel setText:[NSString stringWithFormat:@"%d",livingRoomNumber]];
    [self updateTotal];
}

-(IBAction)increaseKitchenNumber:(id)sender{
    kitchenNumber++;
    [self.kitchenNumberLabel setText:[NSString stringWithFormat:@"%d",kitchenNumber]];
    [self updateTotal];
}

-(IBAction)decreaseBedRoomNumber:(id)sender{
    if(bedRoomNumber>0)bedRoomNumber--;
    [self.bedRoomNumberLabel setText:[NSString stringWithFormat:@"%d",bedRoomNumber]];
    [self updateTotal];
}

-(IBAction)decreaseBathRoomNumber:(id)sender{
    if(bathRoomNumber>0)bathRoomNumber--;
    [self.bathRoomNumberLabel setText:[NSString stringWithFormat:@"%d",bathRoomNumber]];
    [self updateTotal];
}

-(IBAction)decreaseLivingRoomNumber:(id)sender{
    if(livingRoomNumber>0)livingRoomNumber--;
    [self.livingRoomNumberLabel setText:[NSString stringWithFormat:@"%d",livingRoomNumber]];
    [self updateTotal];
}

-(IBAction)decreaseKitchenNumber:(id)sender{
    if(kitchenNumber>0)kitchenNumber--;
    [self.kitchenNumberLabel setText:[NSString stringWithFormat:@"%d",kitchenNumber]];
    [self updateTotal];
}

@end
