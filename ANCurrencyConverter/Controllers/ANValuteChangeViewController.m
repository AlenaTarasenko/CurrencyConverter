//
//  ANValuteChangeViewController.m
//  ANCurrencyConverter
//
//  Created by Admin on 08.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANValuteChangeViewController.h"
#include "ANValuteTableViewCell.h"
#include "ANBankDetails.h"
#include "ANValute.h"

@interface ANValuteChangeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ANValuteChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//}

#pragma mark - UITableViewDataSource
-(void)configurationCell:(ANValuteTableViewCell *) cell ForRowAtIndexPath:(NSIndexPath *)indexPath{
    ANValute * currentValute = [self.bankDetails.valuteArray objectAtIndex:indexPath.row];
    if(currentValute== self.currentValute){
        cell.checkBoxView.image = [UIImage imageNamed:@"checkmarkCell"];
    }else{
         cell.checkBoxView.image = nil;
    }
    cell.nameLabel.text = currentValute.nameValute;
    cell.charCodeLabel.text = currentValute.charCode;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.bankDetails.valuteArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *  cellIdentifire = @"Cell";
   // ANValuteTableViewCell *
    ANValuteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifire];
    if(!cell){
        cell = [[ANValuteTableViewCell alloc] init];
    }
    [self configurationCell:cell ForRowAtIndexPath:indexPath];
    
   // cell.textLabel.text = @"coooo";
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Select cell %ld", (long)indexPath.row);
    self.currentValute = [self.bankDetails.valuteArray objectAtIndex:indexPath.row];
    [self.delegate changeCurrentValute:self.currentValute];
    [self backAction:nil];
}

#pragma mark - Action

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//UITableViewCell

@end
