//
//  loginViewController.m
//  FB AccountKit Demo
//
//  Created by MD ABDUR RAHMAN on 20/3/19.
//  Copyright © 2019 MD ABDUR RAHMAN. All rights reserved.
//

#import "loginViewController.h"
#import <AccountKit/AKFAccountKit.h>
#import <AccountKit/AKFViewController.h>
#import <AccountKit/AKFSkinManager.h>
#import <AccountKit/AKFPhoneNumber.h>
@interface loginViewController () <AKFViewControllerDelegate>

@end

@implementation loginViewController{
    AKFAccountKit *accountKit;
    NSString *authorizationCode;
    UIViewController <AKFViewController> *pendingLoginViewController;
    
};

- (void)viewDidLoad {
    [super viewDidLoad];
    accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAccessToken];
    pendingLoginViewController = [accountKit viewControllerForLoginResume];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (pendingLoginViewController != nil) {
        [self _prepareLoginViewController:pendingLoginViewController];
        [self presentViewController:pendingLoginViewController animated:YES completion:NULL];
        pendingLoginViewController = nil;
    }
    
    [accountKit requestAccount:^(id<AKFAccount> account, NSError *error) {
        // account ID
        
        if ([account phoneNumber] != nil) {
            self.lblshow.text = [[account phoneNumber] stringRepresentation];
            self.showme.text = [[account phoneNumber] stringRepresentation];
        }
    }];
}

#pragma AKFViewControllerDelegate
- (void)viewController:(UIViewController<AKFViewController> *)viewController didFailWithError:(NSError *)error{
    NSLog(@"%@", error.localizedDescription);
}
- (void)viewController:(UIViewController<AKFViewController> *)viewController didCompleteLoginWithAccessToken:(id<AKFAccessToken>)accessToken state:(NSString *)state{
    NSLog(@"%@", accessToken.accountID);
}

#pragma helper Method
- (void)_prepareLoginViewController:(UIViewController<AKFViewController> *)loginViewController
{   loginViewController.defaultCountryCode = @"BD";
    loginViewController.delegate = self;
    // Optionally, you may set up backup verification methods.
    //    viewController.enableSendToFacebook = YES;
    //    viewController.enableGetACall = YES;
    loginViewController.uiManager = [[AKFSkinManager alloc]
                                     initWithSkinType:AKFSkinTypeTranslucent
                                     primaryColor:[UIColor colorWithRed:0.27 green:0.56 blue:0.65 alpha:1.0]
                                     backgroundImage:[UIImage imageNamed:@"mozahar_ios_logo.png"]
                                     backgroundTint:AKFBackgroundTintBlack
                                     tintIntensity:0.70];
    
    
}



- (IBAction)loginWithEmail:(id)sender {
    UIViewController<AKFViewController> *viewController = [accountKit viewControllerForEmailLoginWithEmail:nil state:nil ];
    [self _prepareLoginViewController:viewController];
    [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)loginWithPhone:(id)sender {
    UIViewController<AKFViewController> *viewController = [accountKit viewControllerForPhoneLoginWithPhoneNumber:nil state:nil ];
    [self _prepareLoginViewController:viewController];
    [self presentViewController:viewController animated:YES completion:NULL];
}
- (IBAction)btnLogout:(id)sender {
    [accountKit logOut];
    _lblshow.text = nil;
    _showme.text = nil;
}
@end
