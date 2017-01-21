//
//  BankDetailVC.m
//  AzureProject
//
//  Created by Alexandr on 21.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "BankDetailVC.h"
#import "Bank+CoreDataClass.h"

@interface BankDetailVC ()
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation BankDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoTextView.textContainer.lineFragmentPadding = 20;
    self.infoTextView.textContainerInset = UIEdgeInsetsZero;

    self.title = self.bank.name;
    self.infoTextView.text = self.bank.info;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
