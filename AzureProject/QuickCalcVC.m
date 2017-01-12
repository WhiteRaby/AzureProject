//
//  QuickCalcVC.m
//  AzureProject
//
//  Created by Alexandr on 11.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "QuickCalcVC.h"
#import "SmartView.h"

@interface QuickCalcVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *startAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *InterestRateTextField;
@property (weak, nonatomic) IBOutlet UITextField *depositDuration;
@property (weak, nonatomic) IBOutlet UIButton *culcButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet SmartView *amountView;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;

@end

@implementation QuickCalcVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Quick Calculator";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];;
    
    [self showResultViews:NO];
}

- (void)menuAction {
    
    [self.delegate menuAction];
}

- (IBAction)culcAction:(id)sender {
    
    
    double startAmount = [self.startAmountTextField.text doubleValue];
    double interestRate = ([self.InterestRateTextField.text doubleValue] / 100) + 1;
    double depositDuration = [self.depositDuration.text doubleValue];
    
    if (startAmount < 0 || interestRate < 1 || interestRate > 2 || depositDuration < 0) {
        return;
    }
    
    double res = startAmount * pow(interestRate, depositDuration);
    
    self.totalAmount.text = [NSString stringWithFormat:@"Profit: %.2f", res];
    
    [self showResultViews:YES];
    [self hideKeyboard];
    
    [self.amountView reloadView];
    [self.amountView layoutSubviews];
    [self.amountView updateWithStartAmount:startAmount total:res];
    
    [UIView animateWithDuration:2.f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.amountView layoutSubviews];
    } completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self showResultViews:NO];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [self showResultViews:NO];
    return YES;
}

- (void)showResultViews:(BOOL)isShow {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.culcButton.enabled = !isShow;
        if (!isShow) {
            self.culcButton.alpha = 1.f;
            
            self.titleLable.alpha = 0.f;
            self.amountView.alpha = 0.f;
            self.totalAmount.alpha = 0.f;
        } else {
            self.culcButton.alpha = 0.4f;
            
            self.titleLable.alpha = 1.f;
            self.amountView.alpha = 1.f;
            self.totalAmount.alpha = 1.f;
        }
    }];
}

- (void)hideKeyboard {
    
    [self.startAmountTextField resignFirstResponder];
    [self.InterestRateTextField resignFirstResponder];
    [self.depositDuration resignFirstResponder];
}

@end
