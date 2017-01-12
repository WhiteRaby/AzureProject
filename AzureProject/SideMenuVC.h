//
//  SideMenuVC.h
//  AzureProject
//
//  Created by Alexandr on 10.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideMenuDelegate <NSObject>

- (void)didSelectRow:(NSInteger)row;

@end


@interface SideMenuVC : UITableViewController

@property (weak, nonatomic) id<SideMenuDelegate> delegate;

@end
