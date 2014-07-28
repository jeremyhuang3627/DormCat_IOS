//
//  BecomeCleanerViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/25/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "BecomeCleanerViewController.h"
#import "Macros.h"
#import "MBProgressHUD.h"

@interface BecomeCleanerViewController ()

@end

@implementation BecomeCleanerViewController

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
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)takePicture
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (BOOL)startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    [controller presentViewController:cameraUI animated:YES completion:NULL];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"finished picking image");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURL * requestURL = [NSURL URLWithString:[DEV_HOST stringByAppendingString:@"/upload_id_image"]];
    NSString * FileParam = @"id_image";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParam] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n"
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [request setHTTPBody:body];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:requestURL];
    
    NSOperationQueue * q = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:q completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString * res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"res %@",res);
        dispatch_async(dispatch_get_main_queue(), ^{
           [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}


@end
