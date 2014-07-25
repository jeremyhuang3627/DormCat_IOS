//
//  AppDelegate.m
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "AppDelegate.h"
#import "MSDynamicsDrawerStyler.h"
#import "TabBarViewController.h"
#import "CleanersViewController.h"
#import "GooglePlus/GooglePlus.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LogInViewController.h"
#import "LeftPanelViewController.h"
#import "DormCatCustomer.h"
#define FACEBOOK_SCHEME @"fb244051742471725"
#define GOOGLE_SCHEME @"dorminate.dormcat"

@interface AppDelegate () <MSDynamicsDrawerViewControllerDelegate>
@property (nonatomic, strong) UIImageView *windowBackground;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureWindow];
    [self createDynamicDrawer];
    // Override point for customization after application launch.
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"Found a cached session");
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
        // If there's no cached session, we will show a login button
    } else {
        NSLog(@"showing login view");
        [self showLogInView];
    }
   
    return YES;
}

- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation {
    NSLog(@"received URL %@",url.scheme);
    
    if ([[url scheme] isEqualToString:GOOGLE_SCHEME]){
        NSLog(@"equal to google scheme");
        return [GPPURLHandler handleURL:url
                      sourceApplication:sourceApplication
                             annotation:annotation];
    }

    if ([[url scheme] isEqualToString:FACEBOOK_SCHEME])
        return [FBSession.activeSession handleOpenURL:url];
    return NO;
}

-(void)logout
{
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        NSLog(@"signing out facebook user");
        [FBSession.activeSession closeAndClearTokenInformation];
    }
    
    if([[GPPSignIn sharedInstance] authentication]){
        NSLog(@"signing out google plus user");
        [[GPPSignIn sharedInstance] signOut];
        [self showLogInView];
    }
}

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        if([[self.window.rootViewController presentedViewController] isEqual:self.logInViewController]){
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
        }
        NSString *fbAccessToken = [[[FBSession activeSession] accessTokenData] accessToken];
        NSLog(@"access token %@",fbAccessToken);
        return;
    }
    
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self showLogInView];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self showLogInView];
    }
}

-(void)createDynamicDrawer
{
    self.dynamicsDrawerViewController = [MSDynamicsDrawerViewController new];
    self.dynamicsDrawerViewController.delegate = self;
    LeftPanelViewController *leftPaneViewController = [LeftPanelViewController new];
    [self.dynamicsDrawerViewController setDrawerViewController:leftPaneViewController forDirection:MSDynamicsDrawerDirectionLeft];
    //adding pane view controller
    TabBarViewController * tabBarViewController = [TabBarViewController new];
    tabBarViewController.dynamicsDrawerViewController = self.dynamicsDrawerViewController;
    self.dynamicsDrawerViewController.paneViewController = tabBarViewController;
    MSDynamicsDrawerShadowStyler *shadowStyler = [MSDynamicsDrawerShadowStyler new];
    shadowStyler.shadowOpacity = 0.5;
    [self.dynamicsDrawerViewController addStyler:shadowStyler forDirection:MSDynamicsDrawerDirectionLeft];
    self.window.rootViewController = self.dynamicsDrawerViewController;
}

-(void)showLogInView
{
    self.logInViewController = [LogInViewController new];
    [self.window.rootViewController presentViewController:self.logInViewController animated:NO completion:nil];
}

-(void)configureWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window addSubview:self.windowBackground];
    [self.window sendSubviewToBack:self.windowBackground];
}

- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
}

-(void)makeRequestForUserData
{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // Success! Include your code to handle the results here
            NSLog(@"user info: %@", result);
            self.leftPanelViewController.customer.email = [result objectForKey:@"email"];
            self.leftPanelViewController.customer.first_name = [result objectForKey:@"first_name"];
            self.leftPanelViewController.customer.last_name = [result objectForKey:@"last_name"];
            self.leftPanelViewController.customer.user_id = [result objectForKey:@"id"];
         /*   [self insertOrUpdateUser:self.rightPanelViewController.customer completion:^(DormCatCustomer * customer){
                self.rightPanelViewController.customer = customer;
            }]; */
        } else {
            // An error occurred, we need to handle the error
            // See: https://developers.facebook.com/docs/ios/errors
            NSLog(@"error %@", error.description);
        }
    }];
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
