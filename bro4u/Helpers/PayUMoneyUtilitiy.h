//
//  PayUMoneyUtilitiy.h
//  bro4u
//
//  Created by MACBookPro on 4/10/16.
//  Copyright © 2016 AppLearn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayU_iOS_CoreSDK.h"

typedef void (^CallBackHandler)(NSMutableURLRequest *payUCreateRequest,PayUModelPaymentParams *paymentParamForPassing, NSString *error);

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
@property (nonatomic, strong) NSString *txnID;
@property (nonatomic, strong) NSString *sURL;
@property (nonatomic, strong) NSString *fURL;

-(void)configureAllParameters;
- (void)openWebPayment;

@end
