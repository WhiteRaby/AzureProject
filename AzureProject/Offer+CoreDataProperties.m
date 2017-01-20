//
//  Offer+CoreDataProperties.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Offer+CoreDataProperties.h"

@implementation Offer (CoreDataProperties)

+ (NSFetchRequest<Offer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Offer"];
}

@dynamic name;
@dynamic currency;
@dynamic interestRate;
@dynamic startFunds;
@dynamic capitalize;
@dynamic period;
@dynamic bank;
@dynamic accounts;

@end
