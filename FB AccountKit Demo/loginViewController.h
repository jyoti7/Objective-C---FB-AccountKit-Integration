//
//  loginViewController.h
//  FB AccountKit Demo
//
//  Created by MD ABDUR RAHMAN on 20/3/19.
//  Copyright © 2019 MD ABDUR RAHMAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface loginViewController : UIViewController
- (IBAction)loginWithEmail:(id)sender;
- (IBAction)loginWithPhone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *showme;
@property (weak, nonatomic) IBOutlet UILabel *lblshow;
- (IBAction)btnLogout:(id)sender;

@end

NS_ASSUME_NONNULL_END
