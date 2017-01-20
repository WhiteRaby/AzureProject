//
//  DepositVC.h
//  AzureProject
//
//  Created by Alexandr on 19.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuActionDelegate.h"

@class Account;

@interface DepositVC : UIViewController

@property (strong, nonatomic) Account *deposit;
@property (nonatomic) BOOL isRootVC;
@property (weak, nonatomic) id<MenuActionDelegate> delegate;

@end
