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

+ (void)showMessage:(NSString*)message withText:(NSString*)text target:(UIViewController*)target completion:(void(^)())completion {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:text
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          if (completion)
                                                              completion();
                                                      }]];
    
    [target presentViewController:alertController animated:YES completion:nil];
}

@end
