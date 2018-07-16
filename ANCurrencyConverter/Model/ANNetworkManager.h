//
//  ANNetworkManager.h
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANNetworkManager : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic, readonly) NSData * dataXML;

-(void) loadData;

@end
