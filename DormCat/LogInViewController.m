//
//  SignUpViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/22/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInViewController.h"
#import "macros.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

static NSString * const kClientId = @"278164520085-tmneqopjgctitr14408qpra9ilsu4rhl.apps.googleusercontent.com";

@implementation LogInViewController

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    // Uncomment one of these two statements for the scope you chose in the previous step
  //  signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.scopes = @[@"profile"];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    self.googleLogInBtn.layer.cornerRadius = 3;
}

-(IBAction)googlePlusLogIn:(id)sender
{
    [[GPPSignIn sharedInstance] authenticate];
}

-(IBAction)facebookLogIn:(id)sender
{
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile",@"email"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         // Retrieve the app delegate
         AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
         // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
         [appDelegate sessionStateChanged:session state:state error:error];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//google plus authentication handler
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if(!error){
        NSLog(@"Dismissing login view");
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
}

// facebook authentication handler
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView;
{
    NSLog(@"Logged in from facebook");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void) loginViewFetchedUserInfo:(FBLoginView *)loginView
user:(id<FBGraphUser>)user{
    NSLog(@"fetched user %@",user);
}

- (void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    NSLog(@"User logged out");
}

- (void) loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSLog(@"logged in error  %@",error);
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
