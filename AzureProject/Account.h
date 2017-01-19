//
//  Account.h
//  AzureProject
//
//  Created by Alexandr on 12.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bank, Offer;

@interface Account : NSObject

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *userLogin;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *finishDate;
@property (strong, nonatomic) NSString *bankID;
@property (assign, nonatomic) NSInteger startFunds;
@property (strong, nonatomic) NSString *holderName;
@property (strong, nonatomic) NSString *notice;
@property (strong, nonatomic) NSString *offerID;
@property (assign, nonatomic) NSInteger depositTerm;

@property (strong, nonatomic) Bank *bank;
@property (strong, nonatomic) Offer *offer;


+ (Account*)parseAccount:(NSDictionary*)item;
- (NSDictionary*)dictionary;

@end
