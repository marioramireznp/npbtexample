//
//  NPTransaction.h
//  NetpayPOWA
//
//  Created by Zeferino Casanova on 23/10/15.
//  Copyright © 2015 Netpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPTransaction : NSObject

@property (nonatomic, retain, readwrite) NSString *host1;
@property (nonatomic, retain, readwrite) NSString *port1;
@property (nonatomic, retain, readwrite) NSString *host2;
@property (nonatomic, retain, readwrite) NSString *port2;
@property (nonatomic, retain, readwrite) NSString *device; // Isypay or Pinpad
@property (nonatomic, retain, readwrite) NSString *transType;  //AuthCash or Refund
@property (nonatomic, retain, readwrite) NSString *username;
@property (nonatomic, retain, readwrite) NSString *password;
@property (nonatomic, retain, readwrite) NSString *storeId;
@property (nonatomic, retain, readwrite) NSString *userId;
@property (nonatomic, retain, readwrite) NSString *terminalId;
@property (nonatomic, retain, readwrite) NSString *promotion;
@property (nonatomic, retain, readwrite) NSString *orderId;
@property (nonatomic, retain, readwrite) NSString *amount;
@property (nonatomic, retain, readwrite) NSString *mode;
@property (nonatomic, retain, readwrite) NSString *remTraceAudit;
@property (nonatomic, retain, readwrite) NSString *track2;
@property (nonatomic, retain, readwrite) NSString *track1;
@property (nonatomic, retain, readwrite) NSString *cvv2;
@property (nonatomic, retain, readwrite) NSString *EMVTags;
@property (nonatomic, retain, readwrite) NSString *EMVTagsEncType;
@property (nonatomic, retain, readwrite) NSString *cardholderPresentCode;
@property (nonatomic, retain, readwrite) NSString *ksn;
@property (nonatomic, retain, readwrite) NSString *serviceId;
@property (nonatomic, retain, readwrite) NSString *bankId;
@property (nonatomic, retain, readwrite) NSString *lastDigits;
@property (nonatomic, retain, readwrite) NSString *attribute1;
@property (nonatomic, retain, readwrite) NSString *attribute2;
@property (nonatomic, retain, readwrite) NSString *attribute3;
@property (nonatomic, retain, readwrite) NSString *attribute4;
@property (nonatomic, retain, readwrite) NSString *attribute5;
@property (nonatomic, retain, readwrite) NSString *attribute6;

@end