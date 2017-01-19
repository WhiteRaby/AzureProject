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
#import "OffersVC.h"
#import "QuickCalcVC.h"
#import "MenuActionDelegate.h"
#import "CreateDepositVC.h"
#import "MyDepositsVC.h"

@interface BaseVC () <UIGestureRecognizerDelegate, MenuActionDelegate, SideMenuDelegate>

@property (strong, nonatomic) UIStoryboard *mainStoryboard;

@end

@implementation BaseVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:147.f/255 green:221.f/255 blue:118.f/255 alpha:1.f]];
        [[UINavigationBar appearance] setTranslucent:NO];
        
        self.mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SideMenuVC *leftVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"SideMenuVC"];
        leftVC.delegate = self;
        
        self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
        self.leftViewWidth = 250.0;
        self.leftViewBackgroundColor = [UIColor colorWithRed:32.f/255 green:71.f/255 blue:102.f/255 alpha:1.0];
        self.leftViewBackgroundImage = [UIImage imageNamed:@"menu"];
        //self.rootViewCoverColorForLeftView = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.05];
        
        self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;
        
        self.leftViewController = leftVC;
        
        [self showMyDepositsVC];
    }
    return self;
}

- (void)showBankVC {
    
    BanksVC *banksVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"BanksVC"];
    banksVC.delegate = self;
    
    [self setRootViewController:[self navigationControllerWithRootViewConntroller:banksVC]];
}

- (void)showOffersVC {

    OffersVC *offersVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"OffersVC"];
    offersVC.delegate = self;
    
    [self setRootViewController:[self navigationControllerWithRootViewConntroller:offersVC]];
}

- (void)showQuickCalcVC {
    
    QuickCalcVC *quickCalcVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"QuickCalcVC"];
    quickCalcVC.delegate = self;
    
    [self setRootViewController:[self navigationControllerWithRootViewConntroller:quickCalcVC]];
}

- (void)showCreateDepositVC {
    
    CreateDepositVC *createDepositVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"CreateDepositVC"];
    createDepositVC.delegate = self;
    
    [self setRootViewController:[self navigationControllerWithRootViewConntroller:createDepositVC]];
}

- (void)showMyDepositsVC {
    
    MyDepositsVC *myDepositsVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"MyDepositsVC"];
    myDepositsVC.delegate = self;
    
    [self setRootViewController:[self navigationControllerWithRootViewConntroller:myDepositsVC]];
}


- (UINavigationController*)navigationControllerWithRootViewConntroller:(UIViewController*)vc {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:147.f/255 green:221.f/255 blue:118.f/255 alpha:1.f];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    [nav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    return nav;
}

- (void)menuAction {
    
    [self showLeftViewAnimated:YES completionHandler:nil];
}

- (void)didSelectRow:(NSInteger)row {
    
    switch (row) {
        case 0:
            [self showMyDepositsVC];
            break;
        case 1:
            [self showCreateDepositVC];
            break;
        case 2:
            [self showBankVC];
            break;
        case 3:
            [self showOffersVC];
            break;
        case 4:
            [self showQuickCalcVC];
            break;
            
        default:
            break;
    }
    [self hideLeftViewAnimated:self];
}

- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super leftViewWillLayoutSubviewsWithSize:size];
    
    if (!self.isLeftViewStatusBarHidden) {
        self.leftView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
    }
}

@end
