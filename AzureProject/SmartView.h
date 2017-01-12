//
//  SmartView.h
//  AzureProject
//
//  Created by Alexandr on 11.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartView : UIView

- (void)reloadView;
- (void)updateWithStartAmount:(double)startAmount total:(double)total;

@end
