//
//  SmartView.m
//  AzureProject
//
//  Created by Alexandr on 11.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "SmartView.h"

@interface SmartView ()

@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *greenTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowTrailingConstraint;

@end


@implementation SmartView

- (void)reloadView {
    
    double width = self.bounds.size.width;
    
    self.blueLeadingConstraint.constant = 0;
    self.blueTrailingConstraint.constant = width;
    self.greenLeadingConstraint.constant = 0 - 50;
    self.greenTrailingConstraint.constant = width + 50;
    self.yellowLeadingConstraint.constant = 0 - 100;
    self.yellowTrailingConstraint.constant = width + 100;
}

- (void)updateWithStartAmount:(double)startAmount total:(double)total {
    
    double profit = total - startAmount;
    
    double width = self.bounds.size.width;
    
    double x0 = 0.f;
    double x1 = width * startAmount / total;
    double x2 = width;
    
    self.blueLeadingConstraint.constant = x0;
    self.blueTrailingConstraint.constant = width - x1;
    self.greenLeadingConstraint.constant = x1;
    self.greenTrailingConstraint.constant = 0;
    self.yellowLeadingConstraint.constant = x2;
    self.yellowTrailingConstraint.constant = 0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
