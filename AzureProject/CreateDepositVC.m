//
//  CreateDepositVC.m
//  AzureProject
//
//  Created by Alexandr on 12.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "CreateDepositVC.h"
//#import "ServerManager.h"
//#import "Offer.h"
//#import "Bank.h"
#import <MBProgressHUD.h>
//#import "Account.h"
//#import "User.h"
#import "ServerManagerV2.h"
#import "User+CoreDataClass.h"
#import "Offer+CoreDataClass.h"
#import "Bank+CoreDataClass.h"
#import "Account+CoreDataClass.h"
#import "AlertController.h"
#import "DepositVC.h"
#import "AlertController.h"


@interface CreateDepositVC () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *bankTextField;
@property (weak, nonatomic) IBOutlet UITextField *startAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *offerTextField;
@property (weak, nonatomic) IBOutlet UITextField *holderNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *noticeTextField;
@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *depositTermTextField;

@property (strong, nonatomic) UIPickerView *bankPicker;
@property (strong, nonatomic) UIPickerView *offerPicker;
@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) NSArray *banks;
@property (strong, nonatomic) NSArray *offers;

@property (strong, nonatomic) Bank *selectedBank;
@property (strong, nonatomic) Offer *selectedOffer;

@end

@implementation CreateDepositVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"New deposit";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"] style:UIBarButtonItemStylePlain target:self.delegate action:@selector(menuAction)];
    
    self.bankPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 250)];
    [self.bankPicker setDataSource: self];
    [self.bankPicker setDelegate: self];
    self.bankPicker.showsSelectionIndicator = YES;
    self.bankTextField.inputView = self.bankPicker;
    
    self.offerPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 250)];
    [self.offerPicker setDataSource: self];
    [self.offerPicker setDelegate: self];
    self.offerPicker.showsSelectionIndicator = YES;
    self.offerTextField.inputView = self.offerPicker;
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, 100, 250)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.minimumDate = [NSDate date];
    [self.datePicker addTarget:self action:@selector(incidentDateValueChanged:) forControlEvents:UIControlEventValueChanged];

    self.startTimeTextField.inputView = self.datePicker;
    
    self.offerTextField.tintColor = [UIColor clearColor];
    self.bankTextField.tintColor = [UIColor clearColor];
    self.startTimeTextField.tintColor = [UIColor clearColor];
    
    [self getBanksAndOffers];
}

- (void)getBanksAndOffers {
    
    self.banks = [NSArray array];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);
        
        [[ServerManagerV2 sharedInstance] getBanksCompletion:^(BOOL success, id result) {
            if (success) {
                
                self.banks = result;
            } else {
                NSLog(@"error = %@", result);
            }
            dispatch_semaphore_signal(semaphore1);
        }];
        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
        
//        
//        [[ServerManager sharedInstance] getOffersCompletion:^(BOOL success, id result) {
//            if (success) {
//                
//                self.offers = result;
//            } else {
//                NSLog(@"error = %@", result);
//            }
//            dispatch_semaphore_signal(semaphore2);
//
//        }];
//        dispatch_semaphore_wait(semaphore2, DISPATCH_TIME_FOREVER);
        
//        NSLog(@"banks = %ld, offers = %ld", [self.banks count], [self.offers count]);
//        
//        for (Offer *offer in self.offers) {
//            for (Bank *bank in self.banks) {
//                if ([bank.ID isEqualToString:offer.bankID]) {
//                    [bank.offers addObject:offer];
//                    break;
//                }
//            }
//        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self initUI];
        });
    });

}


- (void)initUI {
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == self.bankPicker) {
        return [self.banks count];
        
    } else if (pickerView == self.offerPicker) {
        return [self.selectedBank.offers count];
    }
    
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component  {
    
    if (pickerView == self.bankPicker && [self.banks count] > row) {
        return ((Bank*)self.banks[row]).name;
        
    } else if (pickerView == self.offerPicker && [self.selectedBank.offers count] > row) {
        return ((Offer*)[self.selectedBank.offers allObjects][row]).name;
    }
    
    return @"Null";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.bankPicker && [self.banks count] > row) {
        self.selectedBank = self.banks[row];
        self.bankTextField.text = self.selectedBank.name;
        
    } else if (pickerView == self.offerPicker && [self.selectedBank.offers count] > row) {
        self.selectedOffer = [self.selectedBank.offers allObjects][row];
        self.offerTextField.text = self.selectedOffer.name;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.offerTextField) {
        if (self.selectedBank && [self.selectedBank.offers count] > 0) {
            
            Offer *offer;
            if ([self.selectedBank.offers count] > [self.offerPicker selectedRowInComponent:0]) {
                offer = [self.selectedBank.offers allObjects][[self.offerPicker selectedRowInComponent:0]];
            } else {
                offer = [self.selectedBank.offers anyObject];
            }
            self.offerTextField.text = offer.name;
            self.selectedOffer = offer;
        }
        
    } else if (textField == self.bankTextField) {
        if ([self.banks count] > [self.bankPicker selectedRowInComponent:0]) {
            Bank *bank = self.banks[[self.bankPicker selectedRowInComponent:0]];
            self.bankTextField.text = bank.name;
            self.selectedBank = bank;
        }
        self.selectedOffer = nil;
        self.offerTextField.text = @"";
        
    } else if (textField == self.startTimeTextField) {
        [self incidentDateValueChanged:nil];
    }
}

- (void)incidentDateValueChanged:(id)sender {
    
    NSDate *date = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd yyyy"];
    
    self.startTimeTextField.text = [formatter stringFromDate:date];
}

- (IBAction)saveAction:(id)sender {
    
    if (!self.selectedBank || !self.selectedOffer || [self.startTimeTextField.text isEqualToString:@""] || [self.startAmountTextField.text isEqualToString:@""] || [self.depositTermTextField.text isEqualToString:@""]) {
        
        [AlertController showMessage:@"Something went wrong!" withText:@"Check all fields" target:self completion:nil];

        
        return;
    }
    

    Account *account = [Account create];
    
    NSDate *startDate = self.datePicker.date;
    NSInteger month = [self.depositTermTextField.text integerValue];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *finishDate = [cal dateByAddingUnit:NSCalendarUnitMonth value:month toDate:startDate options:0];
    
    account.userLogin = [ServerManagerV2 sharedInstance].user.login;
    account.startDate = startDate;
    account.finishDate = finishDate;
    account.startFunds = [self.startAmountTextField.text integerValue];
    account.holderName = self.holderNameTextField.text;
    account.notice = self.noticeTextField.text;
    account.offer = self.selectedOffer;
    account.depositTerm = [self.depositTermTextField.text integerValue];
    
    [[ServerManagerV2 sharedInstance] save];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //[AlertController showMessage:@"Congratulations!" withText:@"Account was added successfully" target:self completion:^{
            
            DepositVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DepositVC"];
            vc.deposit = account;
            vc.isRootVC = YES;
            vc.delegate = self.delegate;
            [self.navigationController pushViewController:vc animated:YES];
        //}];
    });
}



@end
