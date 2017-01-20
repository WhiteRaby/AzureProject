//
//  Account+CoreDataProperties.h
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Account+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties)

+ (NSFetchRequest<Account *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userLogin;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSDate *finishDate;
@property (nonatomic) int64_t startFunds;
@property (nullable, nonatomic, copy) NSString *holderName;
@property (nullable, nonatomic, copy) NSString *notice;
@property (nonatomic) int64_t depositTerm;
@property (nullable, nonatomic, retain) Offer *offer;

@end

NS_ASSUME_NONNULL_END
