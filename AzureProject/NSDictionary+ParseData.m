//
//  NSDictionary+ParseData.m
//  AzureProject
//
//  Created by Alexandr on 11.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "NSDictionary+ParseData.h"

@implementation NSDictionary (ParseData)

- (id)notNullObjectForKey:(id)aKey {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        object = nil;
    }
    
    return object;
}

@end
