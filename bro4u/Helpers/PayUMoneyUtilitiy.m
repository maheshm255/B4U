//
//  PayUMoneyUtilitiy.m
//  bro4u
//
//  Created by MACBookPro on 4/10/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

#import "PayUMoneyUtilitiy.h"
#import <CommonCrypto/CommonDigest.h>

@interface PayUMoneyUtilitiy ()

@property (strong, nonatomic) PayUModelPaymentParams *paymentParamForPassing;
@property (strong, nonatomic) NSString *saltKey;
@property (nonatomic, strong) PayUCreateRequest *createRequest;
@property (nonatomic, strong) NSString *hashParameter;

@end

@implementation PayUMoneyUtilitiy


-(void)configureAllParameters{
    
    
    self.paymentParamForPassing = [PayUModelPaymentParams new];
    self.paymentParamForPassing.key = kMerchantKey;
    //    self.paymentParamForPassing.transactionID = @"Ywism0Q9XC88qvy";
    self.paymentParamForPassing.amount = @"1.0";
    self.paymentParamForPassing.productInfo = @"Plumber";
    self.paymentParamForPassing.firstName = @"Ram";
    self.paymentParamForPassing.email = @"email@testsdk1.com";
    //    self.paymentParamForPassing.userCredentials = @"ra:ra";
    self.paymentParamForPassing.phoneNumber = @"1111111111";
    self.paymentParamForPassing.SURL = kSURL;
    self.paymentParamForPassing.FURL = kFURL;
    //    self.paymentParamForPassing.udf1 = @"u1";
    //    self.paymentParamForPassing.udf2 = @"u2";
    //    self.paymentParamForPassing.udf3 = @"u3";
    //    self.paymentParamForPassing.udf4 = @"u4";
    //    self.paymentParamForPassing.udf5 = @"u5";
    self.paymentParamForPassing.Environment = ENVIRONMENT_PRODUCTION;
    //    self.paymentParamForPassing.offerKey = @"offertest@1411";
    self.saltKey =  kSaltKey;
    //create Parameter for hash
    [self initPayment];
    self.paymentParamForPassing.hashes.paymentHash = [self createSHA512:self.hashParameter];
}

- (void)openWebPayment{
    
    if ([self.paymentType  isEqual:  PAYMENT_PG_CCDC])
    {
        [self payByCCDC];
    }
    else if ([self.paymentType  isEqual:  PAYMENT_PG_NET_BANKING])
    {
        [self PayByNetBanking];
        
    }
}

- (void)PayByNetBanking{
    
    self.paymentParamForPassing.bankCode = _selectedBankCode;
    
    self.createRequest = [PayUCreateRequest new];
    __weak __typeof(self) weakSelf = self;
    [self.createRequest createRequestWithPaymentParam:self.paymentParamForPassing forPaymentType:PAYMENT_PG_NET_BANKING withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            
            if(weakSelf.callBackHandler){
                weakSelf.callBackHandler(request,weakSelf.paymentParamForPassing ,nil);
            }
        }
        else{
            if(weakSelf.callBackHandler){
                weakSelf.callBackHandler(nil,nil,error);
            }
            
        }
    }];
}

- (void)payByCCDC{
    
    self.paymentParamForPassing.expYear = self.cardExpYear;
    self.paymentParamForPassing.expMonth = self.cardExpMonth;
    //    self.paymentParamForPassing.nameOnCard = self.textFieldNameOnCard.text;
    self.paymentParamForPassing.cardNumber = self.cardNo;
    self.paymentParamForPassing.CVV = self.CVVNo;
    
    self.createRequest = [PayUCreateRequest new];
    __weak __typeof(self) weakSelf = self;
    [self.createRequest createRequestWithPaymentParam:self.paymentParamForPassing forPaymentType:self.paymentType withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            if(weakSelf.callBackHandler){
                weakSelf.callBackHandler(request,weakSelf.paymentParamForPassing ,nil);
            }
        }
        else{
            if(weakSelf.callBackHandler){
                weakSelf.callBackHandler(nil,nil,error);
            }
            
        }
    }];
    
    
}


-(void)initPayment {
    int i = arc4random() % 9999999999;
    NSString *strHash = [self createSHA512:[NSString stringWithFormat:@"%d%@",i,[NSDate date]]];// Generatehash512(rnd.ToString() + DateTime.Now);
    self.paymentParamForPassing.transactionID = [strHash substringToIndex:20];
    NSString *key = self.paymentParamForPassing.key;
    NSString *amount = self.paymentParamForPassing.amount;
    NSString *productInfo = self.paymentParamForPassing.productInfo;
    NSString *firstname = self.paymentParamForPassing.firstName;
    NSString *email = self.paymentParamForPassing.email; // Generated a fake mail id for testing
    
    self.hashParameter = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|||||||||||%@",key,self.paymentParamForPassing.transactionID,amount,productInfo,firstname,email,self.saltKey];
}

//Create hash
-(NSString *)createSHA512:(NSString *)string {
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
