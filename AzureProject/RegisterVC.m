//
//  RegisterVC.m
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "RegisterVC.h"
//#import "ServerManager.h"
//#import "User.h"
#import <MBProgressHUD.h>
#import "ServerManagerV2.h"
#import "User+CoreDataClass.h"

@interface RegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation RegisterVC

- (void)viewDidLoad {
    
}

- (IBAction)registerAction:(id)sender {
    
    [self.loginTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    

    
    
    if (![self checkEmail:self.loginTextField.text]) {
        [self showEmailError];
        return;
    }
    
    User *user = [User create];
    user.login = self.loginTextField.text;
    user.password = self.passwordTextField.text;
    [[ServerManagerV2 sharedInstance] save];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
    
//    [[ServerManager sharedInstance] saveUser:user completion:^(BOOL success, id result) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
//        if (success) {
//            if (self.completion) {
//                self.completion(user);
//            }
//        } else {
//            NSLog(@"%@", result);
//        }
//    }];
}

- (BOOL)checkEmail:(NSString*)email {
    
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"[a-z][a-z0-9-._]*[a-z0-9]*@[a-z]+[.][a-z]+"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    
    NSRange range = [regex rangeOfFirstMatchInString:email
                                             options:0
                                               range:NSMakeRange(0, [email length])];
    
    return (range.location == 0 && range.length == [email length]);
}

- (IBAction)cancelAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showEmailError {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Incorrect login" message:@"Try again!" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
