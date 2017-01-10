//
//  User.m
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "User.h"

@implementation User

+ (User*)parseUser:(NSDictionary*)item {
    
    User *user = [User new];
    user.ID = [item objectForKey:@"id"];
    user.login = [item objectForKey:@"Login"];
    user.password = [item objectForKey:@"Password"];
    return user;
}

- (NSDictionary*)dictionary {
    
    return @{@"Login": self.login,
             @"Password": self.password};
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@, %@, %@", self.ID, self.login, self.password];
}

@end
