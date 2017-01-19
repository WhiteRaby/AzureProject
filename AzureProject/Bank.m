//
//  Bunk.m
//  AzureProject
//
//  Created by Alexandr on 10.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "Bank.h"

@implementation Bank


+ (Bank*)parseBank:(NSDictionary*)item {
    
    Bank *bank = [Bank new];
    bank.ID = [item objectForKey:@"id"];
    bank.name = [item objectForKey:@"BankName"];
    bank.info = [item objectForKey:@"BankDescription"];

    return bank;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.offers = [NSMutableArray array];
    }
    return self;
}

@end
