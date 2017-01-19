//
//  ViewController.m
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "LoginVC.h"
#import "ServerManager.h"
#import "User.h"
#import <MBProgressHUD.h>
#import "RegisterVC.h"
#import "BaseVC.h"
#import "SideMenuVC.h"
#import "OffersVC.h"

@interface LoginVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *stayOnlineSwitch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginConstraint;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
//    [[ServerManager sharedInstance] getUsersWithCompletion:^(BOOL success, id result) {
//        NSLog(@"%@",result);
//    }];
}

- (void)initUI {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.loginTextField.text = [userDefaults objectForKey:@"login"];
    self.passwordTextField.text = [userDefaults objectForKey:@"password"];
    self.stayOnlineSwitch.on = [userDefaults boolForKey:@"logged in"];
}

- (void)saveLoginAndPassword {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (self.stayOnlineSwitch.isOn) {
        [userDefaults setObject:self.loginTextField.text forKey:@"login"];
        [userDefaults setObject:self.passwordTextField.text forKey:@"password"];
        [userDefaults setBool:YES forKey:@"logged in"];
    } else {
        [userDefaults removeObjectForKey:@"login"];
        [userDefaults removeObjectForKey:@"password"];
        [userDefaults setBool:NO forKey:@"logged in"];
    }
    [userDefaults synchronize];
}

- (IBAction)signInAction:(id)sender {
    
    NSString *login = self.loginTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[ServerManager sharedInstance] getUserWithLogin:login andPassword:password completion:^(BOOL success, id result) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        if (success) {
            [self saveLoginAndPassword];
            [ServerManager sharedInstance].user = result;
            [self presentViewController:[BaseVC new] animated:YES completion:nil];
        } else {
            NSLog(@"%@",result);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showSignInError];
            });
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self.view layoutIfNeeded];
    
    self.titleConstraint.constant = -140.f;
    self.loginConstraint.constant = 100.f;
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self.view layoutIfNeeded];
    
    self.titleConstraint.constant = 100.f;
    self.loginConstraint.constant = 250.f;
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.loginTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - SegueActions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Register"]) {
        ((RegisterVC*)segue.destinationViewController).completion = ^(User *user) {
            self.loginTextField.text = user.login;
            self.passwordTextField.text = user.password;
            self.stayOnlineSwitch.on = NO;
        };
    }
}

#pragma mark - Alerts

- (void)showSignInError {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Incorrect login or password"
                                                                             message:@"Try again!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
