//
//  Bank+CoreDataProperties.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Bank+CoreDataProperties.h"

@implementation Bank (CoreDataProperties)

+ (NSFetchRequest<Bank *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Bank"];
}

@dynamic name;
@dynamic info;
@dynamic image;
@dynamic offers;

@end
