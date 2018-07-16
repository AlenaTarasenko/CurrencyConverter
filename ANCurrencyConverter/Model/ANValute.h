//
//  ANValute.h
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANValute : NSObject

@property (strong, nonatomic) NSString * identifier;
@property (strong, nonatomic) NSString * numCode;
@property (strong, nonatomic) NSString * charCode;
@property (assign, nonatomic) float  nominal;
@property (strong, nonatomic) NSString * nameValute;
@property (assign, nonatomic) float  value;

@end
