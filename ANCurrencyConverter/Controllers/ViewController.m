//
//  ViewController.m
//  ANCurrencyConverter
//
//  Created by Admin on 05.07.18.
//  Copyright © 2018 Alena Tarasenko. All rights reserved.
//

#import "ViewController.h"
#import "ANRSSParser.h"
#import "ANNetworkManager.h"
#import "ANConverterViewController.h"

@interface ViewController ()

@property (strong,nonatomic) ANRSSParser * parserRSS;
@property (strong,nonatomic) ANNetworkManager * networkManager;
@property (strong,nonatomic) ANBankDetails * bankDetails;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityloadIndicatorView;

@end


@implementation ViewController

- (void)dealloc
{
    [self.networkManager removeObserver:self forKeyPath:@"dataXML"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkManager = [[ANNetworkManager alloc] init];
    [self.networkManager addObserver:self
                         forKeyPath:@"dataXML"
                            options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                            context:nil];
    [self.networkManager loadData];
    self.parserRSS  = [[ANRSSParser alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    self.bankDetails = [self.parserRSS parserXMLData:self.networkManager.dataXML];
    [self.activityloadIndicatorView stopAnimating];
    [self performSegueWithIdentifier:@"convertingNavigation" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([segue.identifier isEqualToString:@"convertingNavigation"]) {
       ANConverterViewController * converterController = segue.destinationViewController;
       converterController.bankDetails = self.bankDetails;
   }
}

@end
