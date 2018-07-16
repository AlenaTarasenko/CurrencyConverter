//
//  ANNetworkManager.m
//  ANCurrencyConverter
//
//  Created by Admin on 06.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ANNetworkManager.h"

@interface ANNetworkManager ()

@property (strong, nonatomic) NSURL * bankURL;
@property (strong, nonatomic) NSURLSession * session;
@property (strong, nonatomic) __block NSData * dataXML;

@end

@implementation ANNetworkManager 

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bankURL = [[NSURL alloc] initWithString:@"http://www.cbr.ru/scripts/XML_daily.asp"];
    }
    return self;
}

-(void) loadData{
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask * task = [self.session dataTaskWithURL:self.bankURL
                                              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      self.dataXML = data;
                                                      
                                                      if(error){
                                                          NSLog(@"%@", [error description]);}
                                                  });
                                              }];
    [task resume];
}



@end
