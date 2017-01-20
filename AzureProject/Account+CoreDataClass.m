//
//  Account+CoreDataClass.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Account+CoreDataClass.h"
#import "Offer+CoreDataClass.h"
#import "AppDelegate.h"


@implementation Account

+ (Account*)create {
    
    NSManagedObjectContext *context = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
    return (Account*)[NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
}

@end
