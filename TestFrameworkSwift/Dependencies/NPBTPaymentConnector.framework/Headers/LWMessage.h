//
//  LWMessage.h
//  NetpayPOWA
//
//  Created by Zeferino Casanova on 10/11/15.
//  Copyright © 2015 Netpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWMessage : NSObject


@property (nonatomic, retain, readwrite) NSString *track2;
@property (nonatomic, retain, readwrite) NSString *track1;
@property (nonatomic, retain, readwrite) NSString *CVV2;
@property (nonatomic, retain, readwrite) NSString *EMVTags;
@property (nonatomic, retain, readwrite) NSString *EMVTagsEncType;
@property (nonatomic, retain, readwrite) NSString *customerName;
@property (nonatomic, retain, readwrite) NSString *KSN;
@property (nonatomic, retain, readwrite) NSString *ARQC;
@property (nonatomic, retain, readwrite) NSString *expDate;
@property (nonatomic, retain, readwrite) NSString *PAN;
@property (nonatomic, retain, readwrite) NSString *appLabelData;
@property (nonatomic, retain, readwrite) NSString *appPrefData;
@property (nonatomic, retain, readwrite) NSString *AID;
@property (nonatomic, retain, readwrite) NSString *lastDigits;
@property (nonatomic, retain, readwrite) NSString *device;

@end
