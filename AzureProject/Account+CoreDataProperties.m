//
//  Account+CoreDataProperties.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Account+CoreDataProperties.h"

@implementation Account (CoreDataProperties)

+ (NSFetchRequest<Account *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Account"];
}

@dynamic userLogin;
@dynamic startDate;
@dynamic finishDate;
@dynamic startFunds;
@dynamic holderName;
@dynamic notice;
@dynamic depositTerm;
@dynamic offer;

@end
