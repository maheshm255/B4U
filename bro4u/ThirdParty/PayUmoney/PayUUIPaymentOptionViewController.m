//
//  PayUUIPaymentOptionViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIPaymentOptionViewController.h"
#import "PayUUICCDCViewController.h"
#import "PayUUINetBankingViewController.h"
#import "PayUUIStoredCardViewController.h"
#import "PayUUIEMIViewController.h"
#import "PayUUIConstants.h"
#import "PayUUIPaymentUIWebViewController.h"

//#import "PayUSharedDataManager.h"

@interface PayUUIPaymentOptionViewController ()

@end

@implementation PayUUIPaymentOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableForPaymentOption.delegate = self;
    self.tableForPaymentOption.dataSource = self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.paymentRelatedDetail.availablePaymentOptionsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_PAYMENT_OPTION];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_PAYMENT_OPTION];
    }
    cell.textLabel.text = [self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row]  isEqual: PAYMENT_PG_ONE_TAP_STOREDCARD]) {
        [self payByOneTapStoredCard];
    }
    if ([[self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row]  isEqual: PAYMENT_PG_STOREDCARD]) {
        [self payByStoredCard];
    }
    if ([[self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row]  isEqual: PAYMENT_PG_CCDC]) {
        [self payByCCDC];
    }
    if ([[self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row]  isEqual: PAYMENT_PG_NET_BANKING]) {
        [self payByNetBanking];
    }
    if ([[self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row]  isEqual: PAYMENT_PG_CASHCARD]) {
        [self payByCashCard];
    }
    if ([[self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row]  isEqual: PAYMENT_PG_EMI]) {
        [self payByEMI];
    }
    if ([[self.paymentRelatedDetail.availablePaymentOptionsArray objectAtIndex:indexPath.row]  isEqual: PAYMENT_PG_PAYU_MONEY]) {
        [self payByPayUMoney];
    }
}

-(void)payByOneTapStoredCard{
    PayUUIStoredCardViewController *SCVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_STORED_CARD];
    SCVC.paymentType = PAYMENT_PG_ONE_TAP_STOREDCARD;
    SCVC.paymentParam = [self.paymentParam copy];
    SCVC.paymentRelatedDetail = self.paymentRelatedDetail;

    if (self.paymentRelatedDetail.oneTapStoredCardArray.count == 1) {

        [SCVC configurePaymentParamWithIndex:0];
//        [SCVC PayBySC:nil];
        PayUCreateRequest *createRequest = [PayUCreateRequest new];
        
        [createRequest createRequestWithPaymentParam:[SCVC getPaymentParam] forPaymentType:PAYMENT_PG_ONE_TAP_STOREDCARD withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
            NSLog(@"Post Param of SC%@",postParam);
            if (error == nil) {
                PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
                webView.paymentRequest = request;
                webView.paymentParam = self.paymentParam;
                [self.navigationController pushViewController:webView animated:true];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                
            }
        }];
    }
    else{
        [self.navigationController pushViewController:SCVC animated:true];
    }
}

- (void)payByCCDC{
    PayUUICCDCViewController *CCDCVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_CCDC];
    CCDCVC.paymentParam = [self.paymentParam copy];
    [self.navigationController pushViewController:CCDCVC animated:true];
}
- (void)payByNetBanking{

    PayUUINetBankingViewController *NBVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_NET_BANKING];
    NBVC.paymentParam = [self.paymentParam copy];
    NBVC.paymentRelatedDetail = self.paymentRelatedDetail;
    [self.navigationController pushViewController:NBVC animated:true];
}

- (void)payByStoredCard{
    PayUUIStoredCardViewController *SCVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_STORED_CARD];
    SCVC.paymentParam = [self.paymentParam copy];
    SCVC.paymentRelatedDetail = self.paymentRelatedDetail;
    [self.navigationController pushViewController:SCVC animated:true];
}

- (void)payByPayUMoney{
//    PayUUIPaymentUIWebViewController *webView;// = [PayUUIPaymentUIWebViewController new];
    PayUCreateRequest *createRequest = [PayUCreateRequest new];
    [createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:PAYMENT_PG_PAYU_MONEY withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
        webView.paymentRequest = request;
        webView.paymentParam = self.paymentParam;
        [self.navigationController pushViewController:webView animated:true];
    }];
}

- (void)payByEMI{
    PayUUIEMIViewController *EMIVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_EMI];
    EMIVC.paymentParam = [self.paymentParam copy];
    EMIVC.paymentRelatedDetail = self.paymentRelatedDetail;
    [self.navigationController pushViewController:EMIVC animated:true];
}

- (void)payByCashCard{
    PayUUINetBankingViewController *NBVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_NET_BANKING];
    NBVC.paymentParam = [self.paymentParam copy];
    NBVC.paymentRelatedDetail = self.paymentRelatedDetail;
    NBVC.paymentType = PAYMENT_PG_CASHCARD;
    [self.navigationController pushViewController:NBVC animated:true];
}
-(void)dealloc{
    NSLog(@"Inside Dealloc of PaymentOption");
}
@end
