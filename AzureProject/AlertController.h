//
//  AlertController.h
//  AzureProject
//
//  Created by Alexandr on 12.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UIAlertController

+ (void)showMessage:(NSString*)message withText:(NSString*)text target:(UIViewController*)target completion:(void(^)())completion;

@end
