//
//  SideMenuVC.m
//  AzureProject
//
//  Created by Alexandr on 10.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "BaseVC.h"
#import "SideMenuVC.h"
#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"
#import "BanksVC.h"

@interface BaseVC ()

@end

@implementation BaseVC


- (void)setupVC {
    
    UIStoryboard *mainST = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SideMenuVC *leftVC = [mainST instantiateViewControllerWithIdentifier:@"SideMenuVC"];
    BanksVC *banksVC = [mainST instantiateViewControllerWithIdentifier:@"BanksVC"];
    
    
    self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    self.leftViewWidth = 250.0;
    self.leftViewBackgroundColor = [UIColor colorWithRed:32.f/255 green:71.f/255 blue:102.f/255 alpha:1.0];
    self.leftViewBackgroundImage = [UIImage imageNamed:@"menu"];
    self.rootViewCoverBlurEffectForLeftView = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.rootViewCoverAlphaForLeftView = 0.8;
    self.leftViewSwipeGestureRange = LGSideMenuSwipeGestureRangeMake(0.0, 88.0);
    
    self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
    
    self.leftViewController = leftVC;
    self.rootViewController = banksVC;
}


//- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
//    [super leftViewWillLayoutSubviewsWithSize:size];
//    
//    if (!self.isLeftViewStatusBarHidden) {
//        self.leftView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
//    }
//}
//
//- (void)rightViewWillLayoutSubviewsWithSize:(CGSize)size {
//    [super rightViewWillLayoutSubviewsWithSize:size];
//    
//    if (!self.isRightViewStatusBarHidden ||
//        (self.rightViewAlwaysVisibleOptions & LGSideMenuAlwaysVisibleOnPadLandscape &&
//         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad &&
//         UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))) {
//            self.rightView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
//        }
//}

@end
