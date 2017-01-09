//
//  ViewController.m
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"
#import "User.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *stayOnlineSwitch;

@property (strong, nonatomic) NSArray *users;

@end

@implementation ViewController

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

// catachrom123@gmail.com cata123chrom
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {

    if ([identifier isEqualToString:@"SignIn"]) {
        
        NSString *login = self.loginTextField.text;
        NSString *password = self.passwordTextField.text;
        
        for (User *user in self.users) {
            if ([[user.login lowercaseString] isEqualToString:[login lowercaseString]] &&
                [user.password isEqualToString:password]) {
                
                [self saveLoginAndPassword];
                
                return YES;
            }
        }
        [self showSignInError];
        return NO;
        
    } else if ([identifier isEqualToString:@"Register"]) {
        return YES;
    } else {
        return NO;
    }
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
