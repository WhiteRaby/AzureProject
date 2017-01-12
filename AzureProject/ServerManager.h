//
//  ServerManager.h
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

typedef void (^CompletionBlock) (BOOL success, id result);

@interface ServerManager : NSObject

+ (ServerManager*)sharedInstance;
- (void)getUsersWithCompletion:(CompletionBlock)completion;
- (void)getUserWithLogin:(NSString*)login andPassword:(NSString*)password completion:(CompletionBlock)completion;
- (void)saveUser:(User*)user completion:(CompletionBlock)completion;
- (void)getBanksCompletion:(CompletionBlock)completion;
- (void)getBankWithID:(NSString*)ID Completion:(CompletionBlock)completion;
- (void)getOffersCompletion:(CompletionBlock)completion;

@end
