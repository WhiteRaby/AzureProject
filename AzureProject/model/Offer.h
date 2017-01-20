//
//  Offer.h
//  AzureProject
//
//  Created by Alexandr on 11.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bank;

@interface Offer : NSObject

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *currency;
@property (nonatomic) NSInteger interestRate;
@property (strong, nonatomic) NSString *bankID;
@property (nonatomic) NSInteger startFunds;
@property (strong, nonatomic) NSString *capitalize;
@property (strong, nonatomic) NSString *period;

@property (strong, nonatomic) Bank *bank;

+ (Offer*)parseOffer:(NSDictionary*)item;

@end
