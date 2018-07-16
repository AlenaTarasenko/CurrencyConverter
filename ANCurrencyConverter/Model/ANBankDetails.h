//
//  ANBankDetails.h
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ANValute;

@interface ANBankDetails : NSObject

@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * currentDate;
@property (strong,nonatomic) ANValute * nationalValute;
@property (strong,nonatomic) NSString * nameNationalCcurrency;
@property (strong,nonatomic) NSMutableArray * valuteArray;



@end
