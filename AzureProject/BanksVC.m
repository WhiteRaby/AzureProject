//
//  BanksVC.m
//  AzureProject
//
//  Created by Alexandr on 10.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "BanksVC.h"
#import "ServerManager.h"
#import "Bank.h"

@interface BanksVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *banks;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BanksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Banks";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];;
    
    [[ServerManager sharedInstance] getBanksCompletion:^(BOOL success, id result) {
        
        if (success) {
            self.banks = result;
            [self.tableView reloadData];
        }
    }];
}

- (void)menuAction {
    
    [self.delegate menuAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.banks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BankCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BankCell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }
    
    Bank *bank = self.banks[indexPath.row];
    cell.textLabel.text = bank.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.f;
}

@end
