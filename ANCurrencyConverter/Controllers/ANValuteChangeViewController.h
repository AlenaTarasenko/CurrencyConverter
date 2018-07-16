//
//  ANValuteChangeViewController.h
//  ANCurrencyConverter
//
//  Created by Admin on 08.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANBankDetails;
@class ANValute;

//@class ANValuteChangeViewController;

@protocol ANValuteChangeDelegate

-(void)changeCurrentValute:(ANValute *) valute;

@end

@interface ANValuteChangeViewController : UITableViewController

@property (strong,nonatomic) ANBankDetails * bankDetails;
@property (strong,nonatomic) ANValute * currentValute;
@property (weak, nonatomic) id <ANValuteChangeDelegate> delegate;

@end


