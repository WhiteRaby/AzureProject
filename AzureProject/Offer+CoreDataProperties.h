//
//  Offer+CoreDataProperties.h
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Offer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Offer (CoreDataProperties)

+ (NSFetchRequest<Offer *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *currency;
@property (nonatomic) int64_t interestRate;
@property (nonatomic) int64_t startFunds;
@property (nullable, nonatomic, copy) NSString *capitalize;
@property (nullable, nonatomic, copy) NSString *period;
@property (nullable, nonatomic, retain) Bank *bank;
@property (nullable, nonatomic, retain) NSSet<Account *> *accounts;

@end

@interface Offer (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(Account *)value;
- (void)removeAccountsObject:(Account *)value;
- (void)addAccounts:(NSSet<Account *> *)values;
- (void)removeAccounts:(NSSet<Account *> *)values;

@end

NS_ASSUME_NONNULL_END
