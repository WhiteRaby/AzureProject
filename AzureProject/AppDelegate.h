//
//  AppDelegate.h
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MicrosoftAzureMobile/MicrosoftAzureMobile.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong, nonatomic) MSClient *client;

- (void)saveContext;


@end

