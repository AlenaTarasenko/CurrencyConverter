//
//  ANRSSParser.h
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANBankDetails.h"

@interface ANRSSParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) ANBankDetails * bankDetails;
@property (strong, nonatomic) NSData * currentData;

-(ANBankDetails*) parserXMLData:(NSData*) dataXML;

@end
