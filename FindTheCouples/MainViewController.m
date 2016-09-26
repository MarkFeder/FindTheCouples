//
//  ViewController.m
//  FindTheCouples
//
//  Created by Marco Arjona Núñez on 22/9/16.
//  Copyright © 2016 Marco Arjona Núñez. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) BoardViewController* boardController;

@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - PlayButton

- (IBAction)playGameAction:(id)sender
{
    NSString *boardOne = self.boardOneTextField.text;
    NSString *boardTwo = self.boardTwoTextField.text;
    
    if ((boardOne.length && boardTwo.length) && ([boardOne isEqualToString:boardTwo] && ([boardOne intValue] * [boardTwo intValue] % 2 == 0)))
    {
        // Load BoardView
        int cells = [boardOne intValue];
        
        // Initialize board controller
        _boardController = [[BoardViewController alloc] initWithNibName:@"BoardView" bundle:nil];
        
        // Normally, NxN
        _boardController.numberOfCells = cells * cells;
        
        [self.navigationController pushViewController:_boardController animated:YES];
    }
    else
    {
        // Display error message to the user
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                       message:@"You have not inserted a proper board"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
