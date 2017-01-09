//
//  User.m
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, %@", self.ID, self.login, self.password];
}

@end
