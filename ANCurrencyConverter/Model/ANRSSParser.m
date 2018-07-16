//
//  ANRSSParser.m
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANRSSParser.h"
#import "ANValute.h"
#import "ANNetworkManager.h"

@interface ANRSSParser()

//@property (strong, nonatomic) ANBankDetails * bankDetails;
@property (strong, nonatomic) NSMutableArray * valuteArray;
@property (strong, nonatomic) NSString * currentElement;
@property (strong, nonatomic) ANValute * currentValute;
@property (strong, nonatomic) ANNetworkManager * networkMnager;

@end

@implementation ANRSSParser

-(ANBankDetails*) parserXMLData:(NSData*) dataXML{
    
    self.bankDetails = [[ANBankDetails alloc] init];
    self.valuteArray = self.bankDetails.valuteArray;
    self.currentData = dataXML;
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithData:self.currentData];
    [xmlparser setDelegate:self];
    [xmlparser parse];
    NSLog(@"END Parsing");
    return self.bankDetails;
}


#pragma mark - NSXMLParserDelegate

//<ValCurs Date="05.07.2018" name="Foreign Currency Market">

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI
 qualifiedName:(nullable NSString *)qName
    attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    if(!self.currentValute){
        self.currentValute = [[ANValute alloc] init];
    }
    self.currentElement = elementName;
    if([elementName isEqualToString:@"Valute"]){
        self.currentValute.identifier = [attributeDict objectForKey:@"ID"];
    }
    if([elementName isEqualToString:@"ValCurs"]){
        self.bankDetails.currentDate =  [attributeDict objectForKey:@"Date"];
        self.bankDetails.name = [attributeDict objectForKey:@"name"];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([self.currentElement isEqualToString:@"NumCode"]) {
        self.currentValute.numCode = string ;
    } else if([self.currentElement isEqualToString:@"CharCode"]){
        self.currentValute.charCode = string ;
    }else if([self.currentElement isEqualToString:@"Nominal"]){
        self.currentValute.nominal = (float)[string integerValue] ;
    }else if([self.currentElement isEqualToString:@"Name"]){
        self.currentValute.nameValute = string ;
    }else if([self.currentElement isEqualToString:@"Value"]){
        self.currentValute.value = [string floatValue];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Valute"]) {
        [self.valuteArray addObject:self.currentValute];
        self.currentValute = nil;
        self.currentElement = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

@end
