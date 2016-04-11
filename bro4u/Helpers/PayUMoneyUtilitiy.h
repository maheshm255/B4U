//
//  PayUMoneyUtilitiy.h
//  bro4u
//
//  Created by MACBookPro on 4/10/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayU_iOS_CoreSDK.h"
#import "PaymentsSDK.h"

typedef void (^CallBackHandler)(NSMutableURLRequest *payUCreateRequest,PayUModelPaymentParams *paymentParamForPassing, NSString *error);
typedef void (^PaytmCallBackHandler)(PGOrder *order, PGMerchantConfiguration *merchantConfiguration);

@interface PayUMoneyUtilitiy : NSObject

@property (nonatomic, strong) NSString *paymentType;
@property (nonatomic, strong) NSString *selectedBankCode;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, strong) NSString *cardExpYear;
@property (nonatomic, strong) NSString *cardExpMonth;
@property (nonatomic, strong) NSString *nameOnCard;
@property (nonatomic, strong) NSString *cardNo;
@property (nonatomic, strong) NSString *CVVNo;
@property (nonatomic, copy) CallBackHandler callBackHandler;
@property (nonatomic, copy) PaytmCallBackHandler paytmCallBackHandler;
@property (nonatomic, strong) NSString *txnID;
@property (nonatomic, strong) NSString *sURL;
@property (nonatomic, strong) NSString *fURL;

@property (nonatomic, strong) PGMerchantConfiguration *mc;
@property (nonatomic, strong) NSMutableDictionary *orderDict;

+(NSString*)generateOrderIDWithPrefix:(NSString *)prefix;
-(void)createOrder;

-(void)configureAllParameters;
- (void)openWebPayment;

@end
