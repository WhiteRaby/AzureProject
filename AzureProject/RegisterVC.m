//
//  RegisterVC.m
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "RegisterVC.h"
#import "ServerManager.h"
#import "User.h"
#import <MBProgressHUD.h>

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
    
    User *user = [User new];
    user.login = self.loginTextField.text;
    user.password = self.passwordTextField.text;
    
    if (![self checkEmail:user.login]) {
        [self showEmailError];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ServerManager sharedInstance] saveUser:user completion:^(BOOL success, id result) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        if (success) {
            if (self.completion) {
                self.completion(user);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"%@", result);
        }
    }];
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
