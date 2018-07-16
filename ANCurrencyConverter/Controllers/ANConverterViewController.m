//
//  ANConverterViewController.m
//  ANCurrencyConverter
//
//  Created by Admin on 08.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANConverterViewController.h"
#import "ANValuteChangeViewController.h"
#import "ANBankDetails.h"
#import "ANValute.h"

typedef enum  {
    LeftPosition = 0,
    RightPosition,
}(ANPositionValute);

@interface ANConverterViewController () <ANValuteChangeDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *leftTextField;
@property (weak, nonatomic) IBOutlet UITextField *rightTextField;
@property (weak, nonatomic) IBOutlet UILabel *leftCharCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightCharCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftChangeValuteButton;
@property (weak, nonatomic) IBOutlet UIButton *rightChangeValuteButton;
@property (weak, nonatomic) IBOutlet UILabel *nameBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;

@property (strong, nonatomic) ANValute* nationalValute;
@property (strong, nonatomic) ANValute* leftValute;
@property (strong, nonatomic) ANValute* rightValute;
@property (assign, nonatomic) float leftAmount;
@property (assign, nonatomic) float rightAmount;
@property (assign, nonatomic) ANPositionValute position;

@end

@implementation ANConverterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nationalValute = [self.bankDetails.valuteArray firstObject];
    self.leftChangeValuteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.rightChangeValuteButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.leftValute =[self.bankDetails.valuteArray objectAtIndex: [self getRand]];
    self.rightValute = self.nationalValute;
    [self initializedValuteInView:self.leftValute inPosition:LeftPosition];
    self.nameBankLabel.text = self.bankDetails.name;
    self.currentDateLabel.text = self.bankDetails.currentDate;
}

#pragma mark - initialize

-(void)initializedValuteInView:(ANValute *)valute inPosition:(ANPositionValute) position{
    if(position == LeftPosition){
        self.leftTextField.text = [NSString stringWithFormat:@"%.2f", valute.nominal];
        self.leftCharCodeLabel.text = valute.charCode;
        self.position = LeftPosition;
        [self loadConvertedValute];
    }else{
        self.rightTextField.text = [NSString stringWithFormat:@"%.2f", valute.nominal];
        self.rightCharCodeLabel.text = valute.charCode;
        self.position = RightPosition;
        [self loadConvertedValute];
    }
}

-(NSUInteger) getRand{
    return arc4random_uniform([self.bankDetails.valuteArray count]-1);
}

#pragma mark - converting valute
-(float)getLeftCostInRU{
     return (self.leftValute.value / self.leftValute.nominal);
}
-(float)getRightCostInRU{
    return (self.rightValute.value / self.rightValute.nominal);
}

-(void) loadConvertedValute{
    float leftCost = [self getLeftCostInRU];
    float rightCost = [self getRightCostInRU];
    if(self.position == LeftPosition){
        float convertCost = (leftCost/rightCost)* self.leftValute.nominal;
        self.rightTextField.text = [NSString stringWithFormat:@"%.2f", convertCost];
        self.rightCharCodeLabel.text = self.rightValute.charCode;
    }else{
        float convertCost = (rightCost/leftCost)*self.rightValute.nominal;
        self.leftTextField.text = [NSString stringWithFormat:@"%.2f", convertCost];
        self.leftCharCodeLabel.text = self.leftValute.charCode;
    }
}

-(void) changeAmount{
    float leftCost = [self getLeftCostInRU];
    float rightCost = [self getRightCostInRU];
    if(self.position == LeftPosition){
        float convertCost= (leftCost/rightCost)* self.leftAmount;
        self.rightTextField.text = [NSString stringWithFormat:@"%.2f", convertCost];
    }else{
        float convertCost= (rightCost/leftCost)*self.rightAmount;
        self.leftTextField.text = [NSString stringWithFormat:@"%.2f", convertCost];
    }
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     ANValuteChangeViewController * changeController = segue.destinationViewController;
     changeController.bankDetails   = self.bankDetails;
     changeController.delegate =  self;
     if ([segue.identifier isEqualToString:@"changedLeftNavigation"]){
         self.position = LeftPosition;
         changeController.currentValute = self.leftValute;
     }else if ([segue.identifier isEqualToString:@"changedRightNavigation"]){
         self.position = RightPosition;
         changeController.currentValute = self.rightValute;
     }
 }

#pragma mark - ANValuteChangeDelegate

-(void)changeCurrentValute:(ANValute *) valute{
    if(self.position == LeftPosition){
        self.leftValute = valute;
        
    }else{
        self.rightValute = valute;
    }
    [self initializedValuteInView:valute inPosition:self.position];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([textField isEqual:self.leftTextField]){
        self.leftAmount = [self.leftTextField.text floatValue];
        self.position = LeftPosition;
    }else{
         self.rightAmount = [self.rightTextField.text floatValue];
        self.position = RightPosition;
    }
    [self changeAmount];
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(string.length == 0){
        return YES;
    }
    NSString *replaceString =[textField.text stringByReplacingCharactersInRange:range withString:string];
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890."]   invertedSet];
    NSArray * resultArray =[replaceString componentsSeparatedByCharactersInSet:set];
    NSCharacterSet *setContansDot = [NSCharacterSet characterSetWithCharactersInString:@"."];
    NSArray * resultDotArray =[replaceString componentsSeparatedByCharactersInSet:setContansDot];
    return [replaceString length] <9 && [resultArray count]<=1 && [resultDotArray count] <= 2;
}

@end
