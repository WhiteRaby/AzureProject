//
//  AcauntsVC.h
//  AzureProject
//
//  Created by Alexandr on 10.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuActionDelegate.h"

@interface OffersVC : UIViewController
@property (weak, nonatomic) id<MenuActionDelegate> delegate;

@end
