//
//  BoardViewController.m
//  FindTheCouples
//
//  Created by Marco Arjona Núñez on 22/9/16.
//  Copyright © 2016 Marco Arjona Núñez. All rights reserved.
//

#import "BoardViewController.h"
#import "JBSpacer.h"

@interface BoardViewController ()

@end

@implementation BoardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self shuffleBoardDataAndReload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialize board
    self.board.delegate = self;
    self.board.dataSource = self;
    self.board.scrollEnabled = YES;
    self.board.allowsMultipleSelection = YES;
    
    // Set colors and data
    _numberOfCouples = _numberOfCells / 2;
    [self randomizeColors];
    [self shuffleBoardData];
    
    // Set JBSpacer options to fit size
    CGSize boardSize = self.board.frame.size;
    
    CGFloat availableSize = boardSize.width;
    CGFloat minimumGutter = 2.0f;
    CGFloat itemSize = self.numberOfCells > 50 ? 50.0f : 100.0f;
    
    JBSpacer *spacer = [JBSpacer spacer];
    
    BOOL success = [spacer findBestSpacingWithOptions:@[[JBSpacerOption optionWithItemSize:itemSize
                                                                        minimumGutter:minimumGutter
                                                                  gutterToMarginRatio:1.0f
                                                                        availableSize:availableSize
                                                             distributeExtraToMargins:YES]]];
    if (success)
    {
        // Apply options to boardFlowLayout
        [spacer applySpacingToCollectionViewFlowLayout:self.boardFlowLayout];

        // Register cell
        [self.board registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.board setBackgroundColor:[UIColor redColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HelperMethods

- (void)randomizeColors
{
    _colors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _numberOfCouples; i++)
    {
        CGFloat hue = ( arc4random() % 256 / 256.0 );
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
        
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        // double the colors
        [_colors addObject:color];
        [_colors addObject:color];
    }
}

- (void)shuffleBoardData
{
    for (int i = 0; i < _colors.count; i++)
    {
        int randomInt1 = arc4random() % [_colors count];
        int randomInt2 = arc4random() % [_colors count];
        
        [_colors exchangeObjectAtIndex:randomInt1 withObjectAtIndex:randomInt2];
    }
}

- (void)shuffleBoardDataAndReload
{
    [self shuffleBoardData];
    [self.board reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:identifier
                                  forIndexPath:indexPath];
    
    // default background color
    cell.backgroundColor = [UIColor grayColor];
    
    // selected background view when user selects cell
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = (UIColor *)[_colors objectAtIndex:indexPath.row];
    cell.selectedBackgroundView = backgroundView;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Back button

- (IBAction)performBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
