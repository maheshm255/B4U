//
//  PayUMoneyViewController.m
//  bro4u
//
//  Created by Rahul on 05/04/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

#import "PayUMoneyViewController.h"
#import "PayU_iOS_CoreSDK.h"

@interface PayUMoneyViewController ()

@property (strong, nonatomic) PayUModelPaymentParams *paymentParamForPassing;
@property (strong, nonatomic) NSString *saltKey;
@property (nonatomic, strong) PayUCreateRequest *createRequest;

@end

@implementation PayUMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureAllParameters];
    [self PayByNetBanking];

}

-(void)configureAllParameters{
    
    
    self.paymentParamForPassing = [PayUModelPaymentParams new];
    self.paymentParamForPassing.key = @"p6VnFd";
    self.paymentParamForPassing.transactionID = @"Ywism0Q9XC88qvy";
    self.paymentParamForPassing.amount = @"1.0";
    self.paymentParamForPassing.productInfo = @"Nokia";
    self.paymentParamForPassing.firstName = @"Ram";
    self.paymentParamForPassing.email = @"email@testsdk1.com";
    self.paymentParamForPassing.userCredentials = @"ra:ra";
    self.paymentParamForPassing.phoneNumber = @"1111111111";
    self.paymentParamForPassing.SURL = @"http://v2.20160301.testing.bro4u.com/api_v2/index.php/order/payu_postback";
    self.paymentParamForPassing.FURL = @"http://v2.20160301.testing.bro4u.com/api_v2/index.php/order/payu_postback";
//    self.paymentParamForPassing.udf1 = @"u1";
//    self.paymentParamForPassing.udf2 = @"u2";
//    self.paymentParamForPassing.udf3 = @"u3";
//    self.paymentParamForPassing.udf4 = @"u4";
//    self.paymentParamForPassing.udf5 = @"u5";
    self.paymentParamForPassing.Environment = @"0";
    self.paymentParamForPassing.offerKey = @"offertest@1411";
    self.saltKey =  @"4Lzjev3I";
    self.paymentParamForPassing.hashes.paymentHash = @"ade84bf6dd9da35d0aab50a5bf61d6272ab0fc488b361b65c66745054aacf1900e3c60b5022d2114bae7360174ebcb3cd7185a5d472e5c99701e5e7e1eccec34";

}


- (void)PayByNetBanking{
    NSString *bankCode = @"AXIB";
    
    self.paymentParamForPassing.bankCode = bankCode;
    
        self.createRequest = [PayUCreateRequest new];
        [self.createRequest createRequestWithPaymentParam:self.paymentParamForPassing forPaymentType:PAYMENT_PG_NET_BANKING withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
            if (error == nil) {
                PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"PayUUIPaymentUIWebViewControllerID"];
                webView.paymentRequest = request;
                webView.paymentParam = self.paymentParamForPassing;
                [self.navigationController pushViewController:webView animated:true];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                
            }
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
