//
//  ServerManagerV2.m
//  AzureProject
//
//  Created by Alexandr on 20.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "ServerManagerV2.h"
#import "User+CoreDataClass.h"
#import "Bank+CoreDataClass.h"
#import "Offer+CoreDataClass.h"
#import "Account+CoreDataClass.h"
#import "AppDelegate.h"

@interface ServerManagerV2 ()

@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation ServerManagerV2

+ (ServerManagerV2*)sharedInstance {
    
    static ServerManagerV2 *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManagerV2 alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.context = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] persistentContainer] viewContext];
        [self startData];
        
    }
    return self;
}

- (NSManagedObject*)createEntityWithEntityName:(NSString*)name {
    
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:[self context]];
    return object;
}

- (void)save {
 
    NSError *error = nil;
    if ([[self context] save:&error] == NO) {
        //NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

- (void)getUsersWithCompletion:(CompletionBlock)completion {
    NSError *error = nil;

    NSArray *users = [self.context executeFetchRequest:[User fetchRequest] error:&error];
    NSLog(@"%@",error);
    completion(YES, users);
    
}

- (void)getUserWithLogin:(NSString*)login andPassword:(NSString*)password completion:(CompletionBlock)completion {

    NSFetchRequest *request = [User fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"login == %@ AND password == %@", login, password]];
    
    NSArray *users = [self.context executeFetchRequest:request error:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([users count]) {
            completion(YES, [users firstObject]);
        } else {
            completion(NO, users);
        }
    });

}

- (void)getBanksCompletion:(CompletionBlock)completion {
    
    NSArray *banks = [self.context executeFetchRequest:[Bank fetchRequest] error:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(YES, banks);
    });
}

- (void)getOffersCompletion:(CompletionBlock)completion {
    
    NSArray *offers = [self.context executeFetchRequest:[Offer fetchRequest] error:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(YES, offers);
    });

}

- (void)getAccountsWithUserLogin:(NSString*)login completion:(CompletionBlock)completion {
    
    
    NSFetchRequest *request = [Account fetchRequest];
    [request setPredicate:[NSPredicate predicateWithFormat:@"userLogin == %@", login]];
    
    NSArray *accounts = [self.context executeFetchRequest:request error:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.55 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([accounts count]) {
            completion(YES, accounts);
        } else {
            completion(NO, accounts);
        }
    });
}

- (void)startData {

    if ([[self.context executeFetchRequest:[Bank fetchRequest] error:nil] count] != 0) {
        return;
    }

    
    
    // ТУТ ТЕБЕ НАДО ДОБАВИТЬ ДАННЫЕ
    
    
    Bank *bank1 = [Bank create];
    bank1.name = @"Husak loh :)";
    bank1.info = @"mamku e.....";
    
    Offer *offer1 = [Offer create];
    offer1.name = @"first offer";
    offer1.currency = @"UA";
    offer1.interestRate = 10;
    offer1.startFunds = 100;
    offer1.capitalize = @"Monthly";
    offer1.period = @"hz chto suda pisat'"; // Сука разберись что это значит
    
    [bank1 addOffersObject:offer1];
    
    
    
    
    //Offer *offer1 = [Offer create];
    // так же сделай
    //[bank1 addOffersObject:offer2]; // ну ты понял

    
    
    //Bank *bank2 = [Bank create];
    //Offer *offer3 = [Offer create];

    //[bank2 addOffersObject:offer3];

    [self save];
}




@end
