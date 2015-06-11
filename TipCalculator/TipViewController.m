//
//  TipViewController.m
//  TipCalculator
//
//  Created by Kenny Chu on 2015/6/8.
//  Copyright (c) 2015年 Kenny Chu. All rights reserved.
//

#import "TipViewController.h"
#import "SettingViewController.h"
#import "AppDelegate.h"

bool isFirst = true;

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTextLabel;
- (IBAction)onTap:(id)sender;
- (IBAction)textFieldChanged:(id)sender;
- (void)updateValues;
- (void)loadSettings;
@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tip Calculator";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self loadSettings];
    [self.billTextField becomeFirstResponder];
    isFirst = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadSettings];
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

- (IBAction)onTap:(id)sender {
    [self updateValues];
}

- (IBAction)textFieldChanged:(id)sender {
    [self updateValues];
}

-(void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    if (!isFirst && (self.billTextField.text == nil || self.billTextField.text.length == 0)) {
        [UIView animateWithDuration:1 animations:^{
            self.totalLabel.alpha = 0;
            self.totalTextLabel.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];

    } else if (isFirst) {
        self.totalLabel.alpha = 0;
        self.totalTextLabel.alpha = 0;
    } else {
        self.totalLabel.alpha = 1;
        self.totalTextLabel.alpha = 1;
    }
    isFirst = false;
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}

- (void)loadSettings {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.tipControl setSelectedSegmentIndex:[defaults integerForKey:@"defaultTipAmountIndex"]];
    
    if ([defaults integerForKey:@"Theme"] == 0) {
        self.view.backgroundColor = app.lightColor;
        self.billLabel.textColor = [UIColor blueColor];
        self.tipAmountLabel.textColor = [UIColor blueColor];
        self.tipControl.tintColor = [UIColor blueColor];
        self.totalLabel.textColor = [UIColor blueColor];
        self.tipLabel.textColor = [UIColor blueColor];
        self.totalTextLabel.textColor = [UIColor blueColor];
        self.billTextField.backgroundColor = app.lightColor;
        self.billTextField.textColor = [UIColor blueColor];
    } else {
        self.view.backgroundColor = app.darkColor;
        self.billLabel.textColor = [UIColor whiteColor];
        self.tipAmountLabel.textColor = [UIColor whiteColor];
        self.tipControl.tintColor = [UIColor whiteColor];
        self.totalLabel.textColor = [UIColor whiteColor];
        self.tipLabel.textColor = [UIColor whiteColor];
        self.totalTextLabel.textColor = [UIColor whiteColor];
        self.billTextField.backgroundColor = app.darkColor;
        self.billTextField.textColor = [UIColor whiteColor];
    }
    
    [self updateValues];
}
@end
