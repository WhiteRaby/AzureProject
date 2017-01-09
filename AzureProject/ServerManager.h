//
//  ServerManager.h
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock) (BOOL success, id result);

@interface ServerManager : NSObject

+ (ServerManager*)sharedInstance;
- (void)getUsersWithCompletion:(CompletionBlock)completion;

@end
