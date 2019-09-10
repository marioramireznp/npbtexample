//
//  PPMessage.h
//  NetpayPOWA
//
//  Created by Zeferino Casanova on 22/10/15.
//  Copyright © 2015 Netpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPMessage.h"

@protocol PPMessageDelegate;

@class NPMessage;

@interface PPMessage : NSObject

@property (nonatomic, assign) id <PPMessageDelegate> delegate;

@property (nonatomic, retain, readonly) NSString *amountG;
@property (nonatomic, retain, readonly) NSString *amountFmt;
@property (nonatomic, retain, readonly) NSString *responseCodeData;
@property (nonatomic, retain, readonly) NSString *authCodeData;
@property (nonatomic, retain, readonly) NSString *responseMsgData;
@property (nonatomic, retain, readonly) NSString *responseTextData;

@property (nonatomic, retain, readonly) NSString *track2Data;
@property (nonatomic, retain, readonly) NSString *track1Data;
@property (nonatomic, retain, readonly) NSString *appPrefNameData;
@property (nonatomic, retain, readonly) NSString *appLabelData;
@property (nonatomic, retain, readonly) NSString *customerNameData;
@property (nonatomic, retain, readonly) NSString *arqcData;
@property (nonatomic, retain, readonly) NSString *posEntryModeData;
@property (nonatomic, retain, readonly) NSString *cvmData;
@property (nonatomic, retain, readonly) NSString *aidData;
@property (nonatomic, retain, readonly) NSString *cvv2Data;
@property (nonatomic, retain, readonly) NSString *emvTags;
@property (nonatomic, retain, readonly) NSString *tokensData;

@property (nonatomic, assign, readonly) BOOL isAmex;
@property (nonatomic, retain, readonly) NSString *flgInitKeyHost;
@property (nonatomic, retain, readonly) NSString *flgInitBinHost;
@property (nonatomic, retain, readonly) NSString *tokenET;
@property (nonatomic, retain, readonly) NSString *cryptogram;

@property (nonatomic, assign, readonly) BOOL isSendAdq;
@property (nonatomic, assign, readonly) BOOL isLoadKey;
@property (nonatomic, assign, readonly) BOOL isLoadKeyEnd;
@property (nonatomic, assign, readonly) BOOL isLoadBin;
@property (nonatomic, assign, readonly) BOOL isConfirmTrans;

- (id)init;

- (NSData*) createStartMessage:(NSString*)amount TransType:(NSString*)transtype;
- (NSData*) sendACK;
- (NSData*) sendInitKey;
- (NSData*) sendInitBin:(NSString*)tokenET;
- (NSData*) confirmTransaction:(NSString*) responseCode AuthCode:(NSString*)authCode Issuer:(NSString*) issuerData;
- (NSData*) confirmTransactionLoadKeyInit:(NSString*) responseCode AuthCode:(NSString*)authCode Issuer:(NSString*) issuerData;
- (NSData*) sendGetBines;

- (void) readTerminalResponse:(NSData*) responseData;


@end

@protocol PPMessageDelegate <NSObject>
- (void) didReadResponseData;
@end
