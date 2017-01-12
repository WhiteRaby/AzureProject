//
//  AcauntsVC.m
//  AzureProject
//
//  Created by Alexandr on 10.01.17.
//  Copyright © 2017 Alex Golovaschenko. All rights reserved.
//

#import "OffersVC.h"
#import "CustomCollectionViewLayout.h"
#import "ContentCollectionViewCell.h"
#import "ServerManager.h"
#import "Offer.h"
#import "Bank.h"

@interface OffersVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *offers;

@end

@implementation OffersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Offers";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(menuAction)];;

    [self setupCollectionView];
    [self loadOffers];
}

- (void)menuAction {
    
    [self.delegate menuAction];
}

- (void)loadOffers {
    
    self.offers = [NSArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [[ServerManager sharedInstance] getOffersCompletion:^(BOOL success, id result) {
            
            if (success) {
                self.offers = result;
            } else {
                NSLog(@"%@", result);
            }
            dispatch_semaphore_signal(semaphore);
        }];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_group_t group = dispatch_group_create();
        for (Offer *offer in self.offers) {
            
            dispatch_group_enter(group);
            [[ServerManager sharedInstance] getBankWithID:offer.bankID Completion:^(BOOL success, id result) {
                if (success) {
                    offer.bank = result;
                } else {
                    NSLog(@"%@", result);
                }
                dispatch_group_leave(group);
            }];
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
    
}

- (void)setupCollectionView {
    CustomCollectionViewLayout *collectionLayout = [[CustomCollectionViewLayout alloc] init];
    self.collectionView.collectionViewLayout = collectionLayout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ContentCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"CollectionCell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.offers count]) {
        return [self.offers count] + 1;
    } else {
        return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];

    NSString *text;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                text = @"Offer";
                break;
            case 1:
                text = @"Bank";
                break;
            case 2:
                text = @"Min Start";
                break;
            case 3:
                text = @"Currency";
                break;
            case 4:
                text = @"%";
                break;
            case 5:
                text = @"Period";
                break;
            case 6:
                text = @"Capitalisation";
                break;
            default:
                break;
        }
    } else {
        Offer *offer = self.offers[indexPath.section - 1];
        switch (indexPath.row) {
            case 0:
                text = [NSString stringWithFormat:@"%@", offer.name];
                break;
            case 1:
                text = offer.bank.name;
                break;
            case 2:
                text = [NSString stringWithFormat:@"%ld", (long)offer.startFunds];
                break;
            case 3:
                text = offer.currency;
                break;
            case 4:
                text = [NSString stringWithFormat:@"%ld", (long)offer.interestRate];
                break;
            case 5:
                text = offer.period;
                break;
            case 6:
                text = offer.capitalize;
                break;
            default:
                break;
        }
    }
    
    UIColor *backgroundColor;
    UIColor *textColor;
    
    if (indexPath.section == 0) {
        textColor = [UIColor whiteColor];
        backgroundColor = [UIColor colorWithRed:112.f/255 green:173.f/255 blue:71.f/255 alpha:1.f];
    } else {
        textColor = [UIColor blackColor];
        if (indexPath.row == 0) {
            backgroundColor = [UIColor colorWithRed:142.f/255 green:196.f/255 blue:106.f/255 alpha:1.f];
        } else {
            if (indexPath.section % 2) {
                backgroundColor = [UIColor colorWithRed:197.f/255 green:224.f/255 blue:179.f/255 alpha:1.f];
            } else {
                backgroundColor = [UIColor colorWithRed:226.f/255 green:239.f/255 blue:217.f/255 alpha:1.f];
            }
        }
    }
    
    cell.backgroundColor = backgroundColor;
    cell.contentLabel.textColor = textColor;
    cell.contentLabel.text = text;
    return cell;
}


@end
