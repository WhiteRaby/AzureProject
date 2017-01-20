//
//  Account.m
//  AzureProject
//
//  Created by Alexandr on 12.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "Account.h"
#import "NSDictionary+ParseData.h"

@implementation Account


+ (Account*)parseAccount:(NSDictionary*)item {
    
    Account *account = [Account new];
    
    account.ID = [item notNullObjectForKey:@"id"];
    account.userLogin = [item notNullObjectForKey:@"LoginRefRecId"];
    account.startDate = [item notNullObjectForKey:@"DateFrom"];
    account.finishDate = [item notNullObjectForKey:@"DateTo"];
    account.bankID = [item notNullObjectForKey:@"BankRefRecID"];
    account.startFunds = [[item notNullObjectForKey:@"StartFunds"] integerValue];
    account.holderName = [item notNullObjectForKey:@"HolderName"];
    account.notice = [item notNullObjectForKey:@"Notice"];
    account.offerID = [item notNullObjectForKey:@"BankOfferRefRecId"];
    account.depositTerm = [[item notNullObjectForKey:@"DepositTermMonth"] integerValue];
    
    account.bank = nil;
    account.offer = nil;
    
    return account;
}

- (NSDictionary*)dictionary {
    
    return @{@"LoginRefRecId": self.userLogin,
             @"DateFrom": self.startDate,
             @"DateTo": self.finishDate,
             @"BankRefRecID": self.bankID,
             @"StartFunds": @(self.startFunds),
             @"HolderName": self.holderName,
             @"Notice": self.notice,
             @"BankOfferRefRecId": self.offerID,
             @"DepositTermMonth": @(self.depositTerm)};
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionary]];
}

@end
