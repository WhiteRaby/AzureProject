//
//  QuickCalcVC.h
//  AzureProject
//
//  Created by Alexandr on 11.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuActionDelegate.h"

@interface QuickCalcVC : UIViewController

@property (weak, nonatomic) id<MenuActionDelegate> delegate;

@end
