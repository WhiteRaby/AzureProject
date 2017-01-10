//
//  RegisterVC.h
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface RegisterVC : UIViewController

@property (nonatomic, copy) void (^completion)(User *user) ;

@end
