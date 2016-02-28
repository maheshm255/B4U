//
//  PayUMoneyViewController.m
//  SegmentControlDemo
//
//  Created by Rahul on 27/02/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

#import "PayUMoneyViewController.h"

@interface PayUMoneyViewController ()

@property (strong, nonatomic) PayUModelPaymentParams *paymentParam;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (strong, nonatomic) PayUSAGetHashes *getHashesFromServer;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;
@property (strong, nonatomic) PayUSAGetTransactionID *getTransactionID;

@end

@implementation PayUMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setDefaultSetting];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    self.getTransactionID = [PayUSAGetTransactionID new];
}

-(void)setDefaultSetting
{
    self.defaultActivityIndicator = [[iOSDefaultActivityIndicator alloc]init];
    self.paymentParam = [PayUModelPaymentParams new];
    self.paymentParam.key = @"0MQaQP";//@"smsplus";//@"obScKz";//@"DXOF8m"; //gtKFFx //0MQaQP //DXOF8m //2Hl5U0En //PqvxqV//obScKz
    self.paymentParam.amount = @"10.0";
    self.paymentParam.productInfo = @"Nokia";
    self.paymentParam.firstName = @"Ram";
    self.paymentParam.email = @"email@testsdk1.com";
    self.paymentParam.userCredentials = @"n:m";
    self.paymentParam.phoneNumber = @"1111111111";
    self.paymentParam.SURL = @"https://payu.herokuapp.com/success";
    self.paymentParam.FURL = @"https://payu.herokuapp.com/failure";
    self.paymentParam.udf1 = @"u1";
    self.paymentParam.udf2 = @"u2";
    self.paymentParam.udf3 = @"u3";
    self.paymentParam.udf4 = @"u4";
    self.paymentParam.udf5 = @"u5";
    self.paymentParam.environment = ENVIRONMENT_PRODUCTION;
    self.paymentParam.offerKey = @"test123@6622";

    //    self.textFieldSalt.text = @"2Hl5U0En";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"passData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"paymentResponse" object:nil];
    
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    self.getHashesFromServer = [PayUSAGetHashes new];
    
    //
//    if (self.switchForSalt.on) {
//        PayUDontUseThisClass *obj = [PayUDontUseThisClass new];
//        [obj getPayUHashesWithPaymentParam:self.paymentParam merchantSalt:self.textFieldSalt.text withCompletionBlock:^(PayUModelHashes *allHashes, PayUModelHashes *hashString, NSString *errorMessage) {
//            [self callSDKWithHashes:allHashes withError:errorMessage];
//        }];
//    }
//    else{
//        [self.getHashesFromServer generateHashFromServer:self.paymentParam withCompletionBlock:^(PayUModelHashes *hashes, NSString *errorString) {
//            [self callSDKWithHashes:hashes withError:errorString];
//        }];
//        
//    }

    [self.getHashesFromServer generateHashFromServer:self.paymentParam withCompletionBlock:^(PayUModelHashes *hashes, NSString *errorString) {
        [self callSDKWithHashes:hashes withError:errorString];
    }];
}

-(void)callSDKWithHashes:(PayUModelHashes *) allHashes withError:(NSString *) errorMessage{
    if (errorMessage == nil) {
        self.paymentParam.hashes = allHashes;
//        if (self.switchForOneTap.on) {
//            PayUSAOneTapToken *OneTapToken = [PayUSAOneTapToken new];
//            [OneTapToken getOneTapTokenDictionaryFromServerWithPaymentParam:self.paymentParam CompletionBlock:^(NSDictionary *CardTokenAndMerchantHash, NSString *errorString) {
//                if (errorMessage) {
//                    [self.defaultActivityIndicator stopAnimatingActivityIndicator];
//                    PAYUALERT(@"Error", errorMessage);
//                }
//                else{
//                    [self callSDKWithOneTap:CardTokenAndMerchantHash];
//                }
//            }];
//        }
//        else{
//            [self callSDKWithOneTap:nil];
//        }
        
        [self callSDKWithOneTap:nil];

    }
    else{
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        PAYUALERT(@"Error", errorMessage);
    }
}

-(void) callSDKWithOneTap:(NSDictionary *)oneTapDict{
    
    self.paymentParam.OneTapTokenDictionary = oneTapDict;
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    [respo callVASForMobileSDKWithPaymentParam:self.paymentParam];        //FORVAS1
    self.webServiceResponse = [PayUWebServiceResponse new];
    [self.webServiceResponse getPayUPaymentRelatedDetailForMobileSDK:self.paymentParam withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (errorMessage) {
            PAYUALERT(@"Error", errorMessage);
        }
        else{
            PayUUIPaymentOptionViewController *paymentOptionVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_OPTION];
            paymentOptionVC.paymentParam = self.paymentParam;
            paymentOptionVC.paymentRelatedDetail = paymentRelatedDetails;
            [self.navigationController pushViewController:paymentOptionVC animated:true];
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


-(void)dataReceived:(NSNotification *)noti
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *strConvertedRespone = [NSString stringWithFormat:@"%@",noti.object];
    NSLog(@"DataReceived %@",strConvertedRespone);
    
    if ([noti.name isEqual:@"paymentResponse"]) {
        //Convert the string to JSON Object
        
        NSError *serializationError;
        id JSON = [NSJSONSerialization JSONObjectWithData:[strConvertedRespone dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&serializationError];
        if (serializationError == nil) {
            NSLog(@"%@",JSON);
            PAYUALERT([JSON objectForKey:@"status"], strConvertedRespone);
            if ([[JSON objectForKey:@"status"] isEqual:@"success"]) {
                NSString *merchant_hash = [JSON valueForKey:@"merchant_hash"];
                if ([[JSON objectForKey:@"card_token"] length] >1 && merchant_hash.length >1 && self.paymentParam) {
                    
                    
                    NSLog(@"Saving merchant hash---->");
                    PayUSAOneTapToken *merchantHash = [PayUSAOneTapToken new];
                    [merchantHash saveOneTapTokenForMerchantKey:self.paymentParam.key withCardToken:[JSON objectForKey:@"card_token"] withUserCredential:self.paymentParam.userCredentials andMerchantHash:merchant_hash withCompletionBlock:^(NSString *message, NSString *errorString) {
                        //
                        if (errorString == nil) {
                            NSLog(@"Response From merchant Hash Server %@",message);
                        }
                        else{
                            NSLog(@"Error from merchant Hash Server %@", errorString);
                        }
                    }];
                    
                    
                }
            }
        }
        else
        {
            //            PAYUALERT(@"Error", serializationError.localizedDescription);
            NSLog(@"Serialization Error: %@",serializationError.localizedDescription);
        }
    }
    else{
        PAYUALERT(@"Status", strConvertedRespone);
    }
}




@end
