//
//  ServerManagerV2.h
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObject, User;

typedef void (^CompletionBlock) (BOOL success, id result);

@interface ServerManagerV2 : NSObject

@property (strong, nonatomic) User *user;

+ (ServerManagerV2*)sharedInstance;
- (NSManagedObject*)createEntityWithEntityName:(NSString*)name;
- (void)save;
- (void)getUsersWithCompletion:(CompletionBlock)completion;
- (void)getUserWithLogin:(NSString*)login andPassword:(NSString*)password completion:(CompletionBlock)completion;
- (void)getBanksCompletion:(CompletionBlock)completion;
- (void)getOffersCompletion:(CompletionBlock)completion;
- (void)getAccountsWithUserLogin:(NSString*)login completion:(CompletionBlock)completion;

@end
