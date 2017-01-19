//
//  AlertController.m
//  AzureProject
//
//  Created by Alexandr on 12.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "AlertController.h"

@interface AlertController ()

@end

@implementation AlertController

+ (void)showMessage:(NSString*)message withText:(NSString*)text target:(UIViewController*)target {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Incorrect login or password"
                                                                             message:@"Try again!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    
    [target presentViewController:alertController animated:YES completion:nil];
}

@end
