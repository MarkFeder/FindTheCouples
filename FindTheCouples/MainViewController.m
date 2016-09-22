//
//  ViewController.m
//  FindTheCouples
//
//  Created by Marco Arjona Núñez on 22/9/16.
//  Copyright © 2016 Marco Arjona Núñez. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize data
    _boardPickerData = @[@"4x4"];
    
    // Connect data
    self.boardPicker.dataSource = self;
    self.boardPicker.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - PickerViewProtocols

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _boardPickerData.count;
}

@end
