//
//  SettingViewController.m
//  TipCalculator
//
//  Created by Kenny Chu on 2015/6/8.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *themeSelector;
@property (weak, nonatomic) IBOutlet UILabel *defaultTipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (strong, nonatomic) NSUserDefaults *defaults;
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultAmountSelector;
- (IBAction)segmentedControlChanged:(id)sender;
- (IBAction)themeChanged:(id)sender;
- (void)changeTheme:(int)index;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _defaults = [NSUserDefaults standardUserDefaults];
    [self.defaultAmountSelector setSelectedSegmentIndex:[self.defaults integerForKey:@"defaultTipAmountIndex"]];
    [self.themeSelector setSelectedSegmentIndex:[self.defaults integerForKey:@"Theme"]];
    [self changeTheme:[self.defaults integerForKey:@"Theme"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)segmentedControlChanged:(id)sender {
    UISegmentedControl *s = (UISegmentedControl *)sender;
    
    [self.defaults setInteger:s.selectedSegmentIndex forKey:@"defaultTipAmountIndex"];
    [self.defaults synchronize];
    NSLog(@"save  %ld", (long)s.selectedSegmentIndex);
}

- (IBAction)themeChanged:(id)sender {
    UISegmentedControl *s = (UISegmentedControl *)sender;
    [self changeTheme:s.selectedSegmentIndex];
    [self.defaults setInteger:s.selectedSegmentIndex forKey:@"Theme"];
    [self.defaults synchronize];
}

- (void)changeTheme:(int)index {
    if (index == 0) {
        self.view.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:248.0f/255.0f blue:44.0f/255.0f alpha:1.0];
        self.defaultTipAmountLabel.textColor = [UIColor blueColor];
        self.themeLabel.textColor = [UIColor blueColor];
        self.defaultAmountSelector.tintColor = [UIColor blueColor];
        self.themeSelector.tintColor = [UIColor blueColor];
    } else {
        self.view.backgroundColor = [UIColor colorWithRed:122.0f/255.0f green:35.0f/255.0f blue:251.0f/255.0f alpha:1.0];
        self.defaultTipAmountLabel.textColor = [UIColor whiteColor];
        self.themeLabel.textColor = [UIColor whiteColor];
        self.defaultAmountSelector.tintColor = [UIColor whiteColor];
        self.themeSelector.tintColor = [UIColor whiteColor];
    }
}

@end
