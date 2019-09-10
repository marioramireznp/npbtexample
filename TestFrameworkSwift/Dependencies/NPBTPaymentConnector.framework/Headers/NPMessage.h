//
//  NPMessage.h
//  NetpayPOWA
//
//  Created by Zeferino Casanova on 23/10/15.
//  Copyright © 2015 Netpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NetPayJSONConnector/NetPayJSONConnector.h>
#import "NPTransaction.h"
#import "LWMessage.h"

@protocol NPMessageDelegate;

@class PPMessage;

@interface NPMessage : NSObject

@property (nonatomic, assign) id <NPMessageDelegate> delegate;

@property (nonatomic, retain, readonly) NSString *AuthCode;
@property (nonatomic, retain, readonly) NSString *ResponseCode;
@property (nonatomic, retain, readonly) NSString *ResponseMsg;
@property (nonatomic, retain, readonly) NSString *ResponseText;
@property (nonatomic, retain, readonly) NSString *MerchantId;
@property (nonatomic, retain, readonly) NSString *BankName;
@property (nonatomic, retain, readonly) NSString *BankId;
@property (nonatomic, retain, readonly) NSString *CardTypeId;
@property (nonatomic, retain, readonly) NSString *CardNature;
@property (nonatomic, retain, readonly) NSString *CardTypeName;
@property (nonatomic, retain, readonly) NSString *TransactionId;
@property (nonatomic, retain, readonly) NSString *OrderId;
@property (nonatomic, retain, readonly) NSString *Attribute1;
@property (nonatomic, retain, readonly) NSString *Attribute2;
@property (nonatomic, retain, readonly) NSString *Attribute3;
@property (nonatomic, retain, readonly) NSString *Attribute4;
@property (nonatomic, retain, readonly) NSString *Attribute5;
@property (nonatomic, retain, readonly) NSString *Attribute6;
@property (nonatomic, retain, readonly) NSString *Attribute7;
@property (nonatomic, retain, readonly) NSString *Attribute8;
@property (nonatomic, retain, readonly) NSString *Attribute9;
@property (nonatomic, retain, readonly) NSString *Attribute10;
@property (nonatomic, retain, readonly) NSString *IssuerAuthData;

@property (nonatomic, retain, readonly) NSString *LastDigits;
@property (nonatomic, retain, readonly) NSString *AppPrefName;
@property (nonatomic, retain, readonly) NSString *AppLabel;
@property (nonatomic, retain, readonly) NSString *CustomerName;
@property (nonatomic, retain, readonly) NSString *ARQC;
@property (nonatomic, retain, readonly) NSString *AID;
@property (nonatomic, retain, readonly) NSString *ARPC;


- (void) setResponse:(NSString*) resCode resMsg:(NSString*)resMsg authCode:(NSString*)authCode resTxt:(NSString*)resTxt attr1:(NSString*) attribute1 attr2:(NSString*) attribute2;
- (void) sendTransaction:(NPTransaction*) transaction ResponseReader:(LWMessage*) reader;

@end


@protocol NPMessageDelegate <NSObject>
- (void) didResponseTransaction;
@end
