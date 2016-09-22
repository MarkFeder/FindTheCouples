//
//  ViewController.h
//  FindTheCouples
//
//  Created by Marco Arjona Núñez on 22/9/16.
//  Copyright © 2016 Marco Arjona Núñez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *_boardPickerData;
}

@property (weak, nonatomic) IBOutlet UIPickerView *boardPicker;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

