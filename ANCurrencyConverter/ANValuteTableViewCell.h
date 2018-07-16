//
//  ANValuteTableViewCell.h
//  ANCurrencyConverter
//
//  Created by Admin on 08.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANValuteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *charCodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxView;

@end
