//
//  ANValute.m
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANValute.h"

@implementation ANValute
- (NSString *)description
{
    return [NSString stringWithFormat:@"identifier: %@\n"
           @"numCode: %@\n"
            @"charCode: %@\n"
            @"nominal: %f\n"
            @"nameValute: %@\n"
            @"value: %f\n", self.identifier,self.numCode, self.charCode, self.nominal,self.nameValute,self.value];
}

@end
