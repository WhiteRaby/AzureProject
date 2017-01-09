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

@interface ServerManager ()

@property (nonatomic, strong) MSClient *client;
@property (nonatomic, strong) MSTable *userTable;

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

        self.userTable = [self.client tableWithName:@"User"];
        
    }
    return self;
}

- (void)getUsersWithCompletion:(CompletionBlock)completion {
    
    [self.userTable readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            if (completion) {
                completion(NO, error);
            }
        } else {
            NSMutableArray *users = [NSMutableArray array];
            for(NSDictionary *item in result.items) { // items is NSArray of records that match query
                [users addObject:[self parseUser:item]];
            }
            if (completion) {
                completion(YES, [users copy]);
            }
        }
    }];
}

- (User*)parseUser:(NSDictionary*)item {
    
    User *user = [User new];
    user.ID = [item objectForKey:@"id"];
    user.login = [item objectForKey:@"Login"];
    user.password = [item objectForKey:@"Password"];
    return user;
}


@end
