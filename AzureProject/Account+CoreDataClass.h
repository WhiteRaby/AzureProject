//
//  Account+CoreDataClass.h
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Offer;

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSManagedObject

+ (Account*)create;

@end

NS_ASSUME_NONNULL_END

#import "Account+CoreDataProperties.h"
