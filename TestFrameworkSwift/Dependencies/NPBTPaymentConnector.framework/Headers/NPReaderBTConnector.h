//
//  NPReaderBTConnector.h
//  NetPayMovil
//
//  Created by Zeferino Casanova on 09/08/16.
//  Copyright © 2016 Netpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NPTransaction.h"
#import "NPMessage.h"
//#import "QPOSService.h"
#import "QPOSService.h"
#import "BTDeviceFinder.h"
//#import "NPReaderConnector.h"

@protocol NPReaderBTConnectorDelegate;


typedef enum {
    CardResult_InsertOrSwipe,
    CardResult_NoCard,
    CardResult_NotIccCard,
    CardResult_BadSwipe,
    CardResult_NoResponse,
    CardResult_UseIccCard,
    CardResult_Declined,
    CardResult_PleaseWait,
    CardResult_RemoveCard,
} CardBTResult;


@interface NPReaderBTConnector : NSObject<BluetoothDelegate2Mode,QPOSServiceListener,NPMessageDelegate,UIAlertViewDelegate>
{
    NSURLConnection *cancelTrxConnection;
}

@property (nonatomic, assign) id <NPReaderBTConnectorDelegate> delegate;

- (void) connect;
- (void) connect:(NSString*)device;
- (void) scanDevices;
- (void) disconnect;
- (void) checkBattery;
- (void) startTransaction:(NPTransaction*)transaction;
-(void)processTransaction: (NSString*) transType
                          withStoreId: (NSString*) storeId
                              andUser:(NSString*) userName
                              andPass:(NSString*) pass
                        andTerminalId:(NSString*) terminalId
                         andPromotion:(NSString*) promotion
                            andAmount:(NSString*) amount
                           andOrderId:(NSString*) orderId
                              andMode:(NSString*) mode
                            andHost1:(NSString*) host1
                            andHost2:(NSString*) host2;

-(void)processRefund: (NSString*) storeId
                  andUser:(NSString*) userName
                  andPass:(NSString*) pass
                andAmount:(NSString*) amount
               andOrderId:(NSString*) orderId
                  andTransactionId:(NSString*) transactionId
                 andHost1:(NSString*) host1
                 andHost2:(NSString*) host2;
@end

@protocol NPReaderBTConnectorDelegate <NSObject>

- (void) receivedReaderBTNPMessage:(NPMessage*)message;
- (void) viewReaderBTLog:(NSString*)message;

- (void) onReturnObjects:(NSMutableArray*)objets;
- (void) onNoDeviceBTDetected;
- (void) onDeviceBTDetected;
- (void) onBatteryBTPercent:(NSString*)percent;
- (void) onWaitingCardBT:(CardBTResult)cardResult;
- (void) didResponseTransaction;
@end
