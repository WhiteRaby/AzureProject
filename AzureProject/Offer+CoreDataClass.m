//
//  Offer+CoreDataClass.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Offer+CoreDataClass.h"
#import "Account+CoreDataClass.h"
#import "Bank+CoreDataClass.h"
#import "AppDelegate.h"

@implementation Offer

+ (Offer*)create {
    
    NSManagedObjectContext *context = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
    return (Offer*)[NSEntityDescription insertNewObjectForEntityForName:@"Offer" inManagedObjectContext:context];
}

@end
