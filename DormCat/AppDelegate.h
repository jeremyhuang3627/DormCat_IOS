//
//  AppDelegate.h
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class MSDynamicsDrawerViewController;
@class LogInViewController;
@class LeftPanelViewController;
@class TabBarViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
@property (strong, nonatomic) LogInViewController *logInViewController;
@property (strong, nonatomic) LeftPanelViewController *leftPanelViewController;
@property (strong, nonatomic) TabBarViewController *tabBarViewController;
- (void)logout;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
@end
