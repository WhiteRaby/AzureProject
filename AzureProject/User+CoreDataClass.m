//
//  User+CoreDataClass.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "User+CoreDataClass.h"
#import "AppDelegate.h"

@implementation User

+ (User*)create {
    
    NSManagedObjectContext *context = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
    return (User*)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
}

@end
