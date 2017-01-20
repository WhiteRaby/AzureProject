//
//  Bunk.h
//  AzureProject
//
//  Created by Alexandr on 10.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Offer;

@interface Bank : NSObject

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *info;

@property (strong, nonatomic) NSMutableArray *offers;

+ (Bank*)parseBank:(NSDictionary*)item;

@end
