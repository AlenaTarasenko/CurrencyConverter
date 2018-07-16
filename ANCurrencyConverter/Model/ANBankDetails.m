//
//  ANBankDetails.m
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANBankDetails.h"
#import "ANValute.h"

@implementation ANBankDetails

- (instancetype)init
{
    self = [super init];
    if (self) {
        _valuteArray = [NSMutableArray array];
        _nameNationalCcurrency = @"Рубль";
        _nationalValute = [[ANValute alloc] init];
        _nationalValute.identifier = @"0000";
        _nationalValute.charCode = @"RU";
        _nationalValute.nominal = 1.f;
        _nationalValute.nameValute = _nameNationalCcurrency ;
        _nationalValute.value = 1.f;
        [_valuteArray addObject:_nationalValute];
    }
    return self;
}


@end
