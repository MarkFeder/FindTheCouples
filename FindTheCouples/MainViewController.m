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
    
    // Initialize board controller
    _boardController = [[BoardViewController alloc] initWithNibName:@"BoardView" bundle:nil];

    // Initialize data
    _boardPickerData = @[@"4x4"];
    
    // Connect data
    self.boardPicker.dataSource = self;
    self.boardPicker.delegate = self;
    
    // Initial row selected
    [self.boardPicker selectRow:0 inComponent:0 animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - PickerViewProtocol

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _boardPickerData.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _boardPickerData[row];
}

# pragma mark - PlayButton

- (IBAction)playGameAction:(id)sender
{
    NSString *currentBoard = [self.boardPicker.delegate pickerView:self.boardPicker titleForRow:[self.boardPicker selectedRowInComponent:0] forComponent:0];
    
    if (currentBoard.length && _boardController)
    {
        // load BoardView
        [self.navigationController pushViewController:_boardController animated:YES];
    }
    else
    {
        // display error message to the user
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                       message:@"You have not selected a proper board"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
