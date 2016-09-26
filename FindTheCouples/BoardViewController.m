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
    
    [_board reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selectedCouples = [[NSMutableArray alloc] initWithCapacity:2];
    _colors = [[NSMutableArray alloc] init];
    
    _numberOfCouples = _numberOfCells / 2;

    // Initialize board
    self.board.delegate = self;
    self.board.dataSource = self;
    self.board.scrollEnabled = YES;
    self.board.allowsMultipleSelection = YES;
    
    // Set colors and data
    [self randomizeColors];
    [self shuffleBoardData];
    
    // Set JBSpacer options to fit size
    CGSize boardSize = self.board.frame.size;
    
    CGFloat availableSize = boardSize.width;
    CGFloat minimumGutter = 2.0f;
    CGFloat itemSize = self.numberOfCells > 50 ? 50.0f : 80.0f;
    
    [self setJBSpacerOptionsWithItemSize:itemSize size:availableSize gutter:minimumGutter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HelperMethods

- (void)setJBSpacerOptionsWithItemSize:(CGFloat)itemSize size:(CGFloat)availableSize gutter:(CGFloat)minimumGutter
{
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
        [self.board setBackgroundColor:[UIColor blackColor]];
    }
}

- (void)randomizeColors
{
    [_colors removeAllObjects];
    
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

- (void)repeateAgainOrNot
{
    // Display error message to the user
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game end!"
                                                                   message:@"You have found all the couples!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* playAgainAction = [UIAlertAction actionWithTitle:@"Play again" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              // Reset info
                                                              [_selectedCouples removeAllObjects];
                                                              _counterLabel.text = [NSString stringWithFormat:@"%i",0];
                                                              [self shuffleBoardDataAndReload];
                                                          }];
    
    UIAlertAction* returnToMenuAction = [UIAlertAction actionWithTitle:@"Return to main menu" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              // Return to main menu
                                                              [self performBack:nil];
                                                          }];
    [alert addAction:playAgainAction];
    [alert addAction:returnToMenuAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlert
{
    // Display error message to the user
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"That's not a couple!"
                                                                   message:@"Try it again!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              // Reset info
                                                              [_selectedCouples removeAllObjects];
                                                              _counterLabel.text = [NSString stringWithFormat:@"%i",0];
                                                              [self.board reloadData];
                                                          }];
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:@"Cell"
                                  forIndexPath:indexPath];
    
    @try
    {
        // Default background color
        cell.backgroundColor = [UIColor grayColor];
        
        // Selected background view when user selects cell
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = (UIColor *)[_colors objectAtIndex:indexPath.row];
        cell.selectedBackgroundView = backgroundView;

    }@catch (NSException *exception) {
        NSLog(@"%@", [exception userInfo]);
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *currentCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [_selectedCouples addObject:currentCell];
    
    if ([_selectedCouples count] == 2)
    {
        UICollectionViewCell *previousCell = (UICollectionViewCell *)[_selectedCouples objectAtIndex:0];
        
        if ([previousCell.selectedBackgroundView.backgroundColor isEqual:currentCell.selectedBackgroundView.backgroundColor])
        {
            int currentCounter = [_counterLabel.text intValue]; currentCounter++;
            _counterLabel.text = [NSString stringWithFormat:@"%i", currentCounter];
            
            if (currentCounter >= _numberOfCouples)
            {
                [self repeateAgainOrNot];
            }
        }
        else
        {
            [self showAlert];
        }
        
        [_selectedCouples removeAllObjects];
    }
}

#pragma mark - BackButton

- (IBAction)performBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
