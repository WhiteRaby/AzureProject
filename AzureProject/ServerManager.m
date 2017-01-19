//
//  ServerManager.m
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "ServerManager.h"
#import <MicrosoftAzureMobile/MicrosoftAzureMobile.h>
#import "AppDelegate.h"
#import "User.h"
#import "Bank.h"
#import "Offer.h"
#import "Account.h"

@interface ServerManager ()

@property (nonatomic, strong) MSClient *client;
@property (nonatomic, strong) MSTable *usersTable;
@property (nonatomic, strong) MSTable *banksTable;
@property (nonatomic, strong) MSTable *offersTable;
@property (nonatomic, strong) MSTable *accountTable;

@end


@implementation ServerManager

+ (ServerManager*)sharedInstance {
    
    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];

        self.usersTable = [self.client tableWithName:@"User"];
        self.banksTable = [self.client tableWithName:@"Bank"];
        self.offersTable = [self.client tableWithName:@"BankOffer"];
        self.accountTable = [self.client tableWithName:@"Account"];

    }
    return self;
}

- (void)getUsersWithCompletion:(CompletionBlock)completion {
    
    [self.usersTable readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            if (completion) {
                completion(NO, error);
            }
        } else {
            NSMutableArray *users = [NSMutableArray array];
            for(NSDictionary *item in result.items) { // items is NSArray of records that match query
                [users addObject:[User parseUser:item]];
            }
            if (completion) {
                completion(YES, [users copy]);
            }
        }
    }];
}

- (void)getUserWithLogin:(NSString*)login andPassword:(NSString*)password completion:(CompletionBlock)completion {
    
    // Create a predicate that finds items where complete is false
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"Login == %@ AND Password == %@", login, password];
    // Query the TodoItem table
    [self.usersTable readWithPredicate:predicate completion:^(MSQueryResult *result, NSError *error) {
        if (error) {
            if (completion) {
                completion(NO, error);
            }
        } else {
            
            if ([result.items count] > 0) {
                User *user = [User parseUser:[result.items firstObject]];
                if (completion) {
                    completion(YES, user);
                }
            } else {
                if (completion) {
                    completion(NO, result.items);
                }
            }
        }
    }];
}

- (void)saveUser:(User*)user completion:(CompletionBlock)completion {
    
    [self.usersTable insert:[user dictionary] completion:^(NSDictionary *result, NSError *error) {
        if(error) {
            if (completion) {
                completion(NO, error);
            }
        } else {
            if (completion) {
                completion(YES, result);
            }
        }
    }];
}

- (void)getBanksCompletion:(CompletionBlock)completion {
    
    [self.banksTable readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            if (completion) {
                completion(NO, error);
            }
        } else {
            NSMutableArray *bunks = [NSMutableArray array];
            for(NSDictionary *item in result.items) { // items is NSArray of records that match query
                [bunks addObject:[Bank parseBank:item]];
            }
            if (completion) {
                completion(YES, [bunks copy]);
            }
        }
    }];
}

- (void)getBankWithID:(NSString*)ID Completion:(CompletionBlock)completion {
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"id == %@", ID];
    [self.banksTable readWithPredicate:predicate completion:^(MSQueryResult *result, NSError *error) {
        if (error) {
            if (completion) {
                completion(NO, error);
            }
        } else {
            
            if ([result.items count] > 0) {
                Bank *bank = [Bank parseBank:[result.items firstObject]];
                if (completion) {
                    completion(YES, bank);
                }
            } else {
                if (completion) {
                    completion(NO, result.items);
                }
            }
        }
    }];
}

- (void)getOffersCompletion:(CompletionBlock)completion {
    
    [self.offersTable readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            if (completion) {
                completion(NO, error);
            }
        } else {
            NSMutableArray *offers = [NSMutableArray array];
            for(NSDictionary *item in result.items) { // items is NSArray of records that match query
                [offers addObject:[Offer parseOffer:item]];
            }
            if (completion) {
                completion(YES, [offers copy]);
            }
        }
    }];
}

- (void)getOffersWithID:(NSString*)ID Completion:(CompletionBlock)completion {
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"id == %@", ID];
    [self.offersTable readWithPredicate:predicate completion:^(MSQueryResult *result, NSError *error) {
        if (error) {
            if (completion) {
                completion(NO, error);
            }
        } else {
            
            if ([result.items count] > 0) {
                Offer *offer = [Offer parseOffer:[result.items firstObject]];
                if (completion) {
                    completion(YES, offer);
                }
            } else {
                if (completion) {
                    completion(NO, result.items);
                }
            }
        }
    }];
}

- (void)getAccountsWithUserLogin:(NSString*)login completion:(CompletionBlock)completion {
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"LoginRefRecId == %@", login];
    [self.accountTable readWithPredicate:predicate completion:^(MSQueryResult *result, NSError *error) {
        if (error) {
            if (completion) {
                completion(NO, error);
            }
        } else {
            if ([result.items count] > 0) {
                
                NSMutableArray *accounts = [NSMutableArray array];
                for (NSDictionary *item in result.items) {
                    Account *account = [Account parseAccount:item];
                    [accounts addObject:account];
                }
                if (completion) {
                    completion(YES, [accounts copy]);
                }
            } else {
                if (completion) {
                    completion(NO, result.items);
                }
            }
        }
    }];
}

- (void)saveAccount:(Account*)account completion:(CompletionBlock)completion {
    
    [self.accountTable insert:[account dictionary] completion:^(NSDictionary *result, NSError *error) {
        if(error) {
            if (completion) {
                completion(NO, error);
            }
        } else {
            if (completion) {
                completion(YES, result);
            }
        }
    }];
}

@end
