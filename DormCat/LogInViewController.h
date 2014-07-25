//
//  SignUpViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/22/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GooglePlus/GooglePlus.h"
#import "FacebookSDK/FacebookSDK.h"

@interface LogInViewController : UIViewController <GPPSignInDelegate,FBLoginViewDelegate>
@property (nonatomic,weak) IBOutlet UIButton *googleLogInBtn;
@property (nonatomic,weak) IBOutlet UIButton *facebookLogInBtn;
@end
