//
//  User.h
//  AzureProject
//
//  Created by Alexandr on 09.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;

@end
