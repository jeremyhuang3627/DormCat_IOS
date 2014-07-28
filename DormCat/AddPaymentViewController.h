//
//  AddPaymentViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/27/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Braintree-Payments-UI.h"

@protocol AddPaymentViewControllerDelegate <NSObject>

-(void)addCardDictionary:(NSMutableDictionary *)card;

@end

@interface AddPaymentViewController : UIViewController <BTUICardFormViewDelegate>
@property (nonatomic,strong) IBOutlet UIButton * saveBtn;
@property (nonatomic,strong) BTUICardFormView * cardFormView;
@property (nonatomic,strong) id<AddPaymentViewControllerDelegate> delegate;
@end
