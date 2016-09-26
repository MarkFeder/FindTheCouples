//
//  ViewController.h
//  FindTheCouples
//
//  Created by Marco Arjona Núñez on 22/9/16.
//  Copyright © 2016 Marco Arjona Núñez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardViewController.h"

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UITextField *boardOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *boardTwoTextField;

@end

