//
//  MyDepositsVC.m
//  AzureProject
//
//  Created by Alexandr on 19.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "MyDepositsVC.h"
#import "ServerManager.h"
#import "User.h"
#import "Account.h"
#import "Offer.h"
#import "DepositVC.h"

@interface MyDepositsVC ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *deposits;
@end

@implementation MyDepositsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"My deposits";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"] style:UIBarButtonItemStylePlain target:self.delegate action:@selector(menuAction)];
    
    [self loadOffers];
}

- (void)loadOffers {
    
    self.deposits = [NSArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSString *login = [[ServerManager sharedInstance] user].login;
        [[ServerManager sharedInstance] getAccountsWithUserLogin:login completion:^(BOOL success, id result) {
            
            if (success) {
                self.deposits = result;
            } else {
                NSLog(@"%@", result);
            }
            dispatch_semaphore_signal(semaphore);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_group_t group = dispatch_group_create();
        for (Account *account in self.deposits) {
            
            dispatch_group_enter(group);
            [[ServerManager sharedInstance] getBankWithID:account.bankID Completion:^(BOOL success, id result) {
                if (success) {
                    account.bank = result;
                } else {
                    NSLog(@"%@", result);
                }
                dispatch_group_leave(group);
            }];
            
            dispatch_group_enter(group);
            [[ServerManager sharedInstance] getOffersWithID:account.offerID Completion:^(BOOL success, id result) {
                if (success) {
                    account.offer = result;
                } else {
                    NSLog(@"%@", result);
                }
                dispatch_group_leave(group);
            }];
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.deposits count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DepositCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DepositCell"];
    }
    
    Account *account = self.deposits[indexPath.row];
    cell.textLabel.text = account.offer.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DepositVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DepositVC"];
    vc.deposit = self.deposits[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
