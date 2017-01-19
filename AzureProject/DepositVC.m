//
//  DepositVC.m
//  AzureProject
//
//  Created by Alexandr on 19.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "DepositVC.h"
#import "SmartView.h"
#import "Offer.h"
#import "Account.h"
#import "Bank.h"

@interface DepositVC ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet SmartView *smartView;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;

@end

@implementation DepositVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    double startAmount = self.deposit.startFunds;
    double interestRate = ((double)self.deposit.offer.interestRate / 100) + 1;
    double depositDuration = self.deposit.depositTerm;
    double res = startAmount * pow(interestRate, depositDuration);
    
    self.nameLabel.text = [NSString stringWithFormat:@"Deposit Name: %@", self.deposit.offer.name];
    
    self.startLabel.text = [NSString stringWithFormat:@"Start Sum: %.0f", startAmount];
    
    self.resultLabel.text = [NSString stringWithFormat:@"Result Sum: %.2f", res];
    
    self.interestLabel.text = [NSString stringWithFormat:@"Interest Rate: %ld%%", self.deposit.offer.interestRate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM.dd.yyyy"];
    
    self.fromLabel.text = [NSString stringWithFormat:@"From: %@", [formatter stringFromDate:self.deposit.startDate]];
    self.toLabel.text = [NSString stringWithFormat:@"To: %@", [formatter stringFromDate:self.deposit.finishDate]];

    [self.smartView reloadView];
    [self.smartView layoutSubviews];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    double startAmount = self.deposit.startFunds;
    double interestRate = ((double)self.deposit.offer.interestRate / 100) + 1;
    double depositDuration = self.deposit.depositTerm;
    double res = startAmount * pow(interestRate, depositDuration);

    
    [self.smartView reloadView];
    [self.smartView layoutSubviews];
    [self.smartView updateWithStartAmount:startAmount total:res];
    
    [UIView animateWithDuration:2.f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.smartView layoutSubviews];
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end