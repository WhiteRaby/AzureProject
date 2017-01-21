//
//  MyDepositsVC.m
//  AzureProject
//
//  Created by Alexandr on 19.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "MyDepositsVC.h"
//#import "ServerManager.h"
//#import "User.h"
//#import "Account.h"
//#import "Offer.h"
#import "DepositVC.h"
#import "ServerManagerV2.h"
#import "User+CoreDataClass.h"
#import "Account+CoreDataClass.h"
#import "Offer+CoreDataClass.h"
#import <MBProgressHUD.h>

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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        NSString *login = [[ServerManagerV2 sharedInstance] user].login;
        [[ServerManagerV2 sharedInstance] getAccountsWithUserLogin:login completion:^(BOOL success, id result) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (success) {
                self.deposits = result;
            } else {
                NSLog(@"%@", result);
            }
            dispatch_semaphore_signal(semaphore);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
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
    cell.detailTextLabel.text = account.notice;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DepositVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DepositVC"];
    vc.deposit = self.deposits[indexPath.row];
    vc.isRootVC = NO;

    [self.navigationController pushViewController:vc animated:YES];
}

@end
