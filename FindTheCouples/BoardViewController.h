//
//  BoardViewController.h
//  FindTheCouples
//
//  Created by Marco Arjona Núñez on 22/9/16.
//  Copyright © 2016 Marco Arjona Núñez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_colors;
    NSMutableArray *_selectedCouples;
    int _numberOfCouples;
}

@property (strong, nonatomic) IBOutlet UICollectionView *board;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *boardFlowLayout;

@property (assign) int numberOfCells;

@end
