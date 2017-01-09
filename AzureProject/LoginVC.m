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

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *stayOnlineSwitch;

@property (strong, nonatomic) NSArray *users;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUsers];
    [self initUI];
}

- (void)initUI {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.loginTextField.text = [userDefaults objectForKey:@"login"];
    self.passwordTextField.text = [userDefaults objectForKey:@"password"];
    self.stayOnlineSwitch.on = [userDefaults boolForKey:@"logged in"];
}

- (void)loadUsers {
    self.users = nil;
    
    [[ServerManager sharedInstance] getUsersWithCompletion:^(BOOL success, id result) {
        if (success) {
            
            self.users = (NSArray*)result;
            for (User *user in self.users) {
                NSLog(@"%@ %@", user.login, user.password);
            }
        }
    }];
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
            [self performSegueWithIdentifier:@"SignIn" sender:self];
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showSignInError];
            });
        }
    }];
}

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