//
//  PaytmViewController.m
//  SegmentControlDemo
//
//  Created by Rahul on 27/02/16.
//  Copyright © 2016 MSP-User3. All rights reserved.
//

#import "PaytmViewController.h"

@interface PaytmViewController ()


@end

@implementation PaytmViewController


+(NSString*)generateOrderIDWithPrefix:(NSString *)prefix
{
    srand ( (unsigned)time(NULL) );
    int randomNo = rand(); //just randomizing the number
    NSString *orderID = [NSString stringWithFormat:@"%@%d", prefix, randomNo];
    return orderID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createOrder];
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

-(void)showController:(PGTransactionViewController *)controller
{
    if (self.navigationController != nil)
        [self.navigationController pushViewController:controller animated:YES];
    else
        [self presentViewController:controller animated:YES
                         completion:^{
                             
                         }];
}

-(void)removeController:(PGTransactionViewController *)controller
{
    if (self.navigationController != nil)
        [self.navigationController popViewControllerAnimated:YES];
    else
        [controller dismissViewControllerAnimated:YES
                                       completion:^{
                                       }];
}

-(void)createOrder{
    
    //Step 1: Create a default merchant config object
    _mc = [PGMerchantConfiguration defaultConfiguration];
    //Step 2: If you have your own checksum generation and validation url set this here. Otherwise use the default Paytm urls
    
    _mc.checksumGenerationURL = @"http://v2.20160301.testing.bro4u.com/api_v2/index.php/order/paytm_checksum_generation";
    _mc.checksumValidationURL = @"http://v2.20160301.testing.bro4u.com/api_v2/index.php/order/paytm_checksum_validation";

    //Step 2: If you have your own checksum generation and validation url set this here. Otherwise use the default Paytm urls
    
    //    _mc.checksumGenerationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumGenerator.jsp";
    //    _mc.checksumValidationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumVerify.jsp";

    //Step 3: Create the order with whatever params you want to add. But make sure that you include the merchant mandatory params
    _orderDict = [NSMutableDictionary new];
    //Merchant configuration in the order object
    //    orderDict[@"MID"] = @"Bro4uo37940487669580";
    //    orderDict[@"WEBSITE"] = @"Bro4uwap";
    
    _orderDict[@"MID"] = @"NquJkw58790567615778";
    _orderDict[@"CHANNEL_ID"] = @"WAP";
    _orderDict[@"INDUSTRY_TYPE_ID"] = @"Retail";
    _orderDict[@"WEBSITE"] = @"brofouruwap";
    _orderDict[@"TXN_AMOUNT"] = @"1";
    _orderDict[@"ORDER_ID"] = [PaytmViewController generateOrderIDWithPrefix:@""];
    //    _orderDict[@"REQUEST_TYPE"] = @"DEFAULT";
    _orderDict[@"CUST_ID"] = @"1234567890";
    
    
    //Step 3: Create the order with whatever params you want to add. But make sure that you include the merchant mandatory params
//    _orderDict = [NSMutableDictionary new];
    //Merchant configuration in the order object
    //    orderDict[@"MID"] = @"Bro4uo37940487669580";
    //    orderDict[@"WEBSITE"] = @"Bro4uwap";
    
//    _orderDict[@"MID"] = @"WorldP64425807474247";
//    _orderDict[@"CHANNEL_ID"] = @"WAP";
//    _orderDict[@"INDUSTRY_TYPE_ID"] = @"Retail";
//    _orderDict[@"WEBSITE"] = @"worldpressplg";
    //Order configuration in the order object
    _orderDict[@"TXN_AMOUNT"] = @"1";
    _orderDict[@"ORDER_ID"] = [PaytmViewController generateOrderIDWithPrefix:@""];
//    _orderDict[@"REQUEST_TYPE"] = @"DEFAULT";
    _orderDict[@"CUST_ID"] = @"1234567890";
    //    orderDict[@"EMAIL"] = @"abcd@gmail.com";
    //    orderDict[@"MOBILE_NO"] = @"9343999888";
    //    orderDict[@"THEME"] = @"merchant";
    
    
    PGOrder *order = [PGOrder orderWithParams:_orderDict];
    PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
    txnController.serverType = eServerTypeStaging;
    txnController.merchant = _mc;
    txnController.delegate = self;
    [self showController:txnController];

    //Step 4: Choose the PG server. In your production build dont call selectServerDialog. Just create a instance of the
    //PGTransactionViewController and set the serverType to eServerTypeProduction
    //    [PGServerEnvironment selectServerDialog:self.view completionHandler:^(ServerType type)
    //     {
    //         PGTransactionViewController *txnController = [[PGTransactionViewController alloc] initTransactionForOrder:order];
    //         if (type != eServerTypeNone) {
    //             txnController.serverType = type;
    //             txnController.merchant = mc;
    //             txnController.delegate = self;
    //             [self showController:txnController];
    //         }
    //     }];

}


#pragma mark PGTransactionViewController delegate

- (void)didSucceedTransaction:(PGTransactionViewController *)controller
                     response:(NSDictionary *)response
{
    DEBUGLOG(@"ViewController::didSucceedTransactionresponse= %@", response);
    NSString *title = [NSString stringWithFormat:@"Your order  was completed successfully. \n %@", response[@"ORDERID"]];
    [[[UIAlertView alloc] initWithTitle:title message:[response description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    [self removeController:controller];
}

- (void)didFailTransaction:(PGTransactionViewController *)controller error:(NSError *)error response:(NSDictionary *)response
{
    DEBUGLOG(@"ViewController::didFailTransaction error = %@ response= %@", error, response);
    if (response)
    {
        [[[UIAlertView alloc] initWithTitle:error.localizedDescription message:[response description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else if (error)
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    [self removeController:controller];
}

- (void)didCancelTransaction:(PGTransactionViewController *)controller error:(NSError*)error response:(NSDictionary *)response
{
    DEBUGLOG(@"ViewController::didCancelTransaction error = %@ response= %@", error, response);
    NSString *msg = nil;
    if (!error) msg = [NSString stringWithFormat:@"Successful"];
    else msg = [NSString stringWithFormat:@"UnSuccessful"];
    
    [[[UIAlertView alloc] initWithTitle:@"Transaction Cancel" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self removeController:controller];
}

- (void)didFinishCASTransaction:(PGTransactionViewController *)controller response:(NSDictionary *)response
{
    DEBUGLOG(@"ViewController::didFinishCASTransaction:response = %@", response);
}


@end
