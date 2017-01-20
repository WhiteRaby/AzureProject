//
//  Offer.m
//  AzureProject
//
//  Created by Alexandr on 11.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "Offer.h"
#import "NSDictionary+ParseData.h"
#import "ServerManager.h"

@implementation Offer

+ (Offer*)parseOffer:(NSDictionary*)item {
    
    Offer *offer = [Offer new];
    
    offer.ID = [item notNullObjectForKey:@"id"];
    offer.name = [item notNullObjectForKey:@"OfferName"];
    offer.currency = [item notNullObjectForKey:@"Currency"];
    offer.interestRate = [[item notNullObjectForKey:@"InterestRate"] integerValue];
    offer.bankID = [item notNullObjectForKey:@"BankRefRecId"];
    offer.startFunds = [[item notNullObjectForKey:@"MinStartFunds"] integerValue];
    offer.capitalize = [item notNullObjectForKey:@"Capitalize"];
    offer.period = [item notNullObjectForKey:@"InterestPeriodicity"];
    
    return offer;
}

@end
