//
//  Bank+CoreDataClass.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Bank+CoreDataClass.h"
#import "Offer+CoreDataClass.h"
#import "AppDelegate.h"

@implementation Bank

+ (Bank*)create {
    
    NSManagedObjectContext *context = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
    return (Bank*)[NSEntityDescription insertNewObjectForEntityForName:@"Bank" inManagedObjectContext:context];
}

@end
