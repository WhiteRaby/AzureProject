//
//  Bank+CoreDataProperties.h
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Bank+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Bank (CoreDataProperties)

+ (NSFetchRequest<Bank *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, retain) NSObject *image;
@property (nullable, nonatomic, retain) NSSet<Offer *> *offers;

@end

@interface Bank (CoreDataGeneratedAccessors)

- (void)addOffersObject:(Offer *)value;
- (void)removeOffersObject:(Offer *)value;
- (void)addOffers:(NSSet<Offer *> *)values;
- (void)removeOffers:(NSSet<Offer *> *)values;

@end

NS_ASSUME_NONNULL_END
