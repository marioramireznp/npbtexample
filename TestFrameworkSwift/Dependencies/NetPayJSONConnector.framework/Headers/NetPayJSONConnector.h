//
//  NetPayJSONConnector.h
//  NetPayJSONConnector
//
//  Created by DiegoNavarro on 2/4/13.
//  Copyright (c) 2013 DiegoNavarro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import <KeyValueObjectMapping/DCParserConfiguration.h>
#import <KeyValueObjectMapping/DCArrayMapping.h>
#import "Message.h"
#import "Value.h"
#import "ValueList.h"
#import "Element.h"
#import "ElementList.h"
#import "JSONKit.h"

@interface NetPayJSONConnector : NSObject


-(NSString*)processTransactionRequest: (NSString*) transType
                          withStoreId: (NSString*) storeId
                              andUser:(NSString*) userName
                              andPass:(NSString*) pass
                        andTerminalId:(NSString*) terminalId
                         andPromotion:(NSString*) promotion
                            andAmount:(NSString*) amount
                           andOrderId:(NSString*) orderId
                              andMode:(NSString*) mode
                        andCardNumber:(NSString*) cardNumber
                              andCVV2:(NSString*) cvv2
                           andExpDate:(NSString*) expDate
                         andCardToken:(NSString*) cardToken;

-(NSString*)customerRegistrationRequest:(NSString*) storeId
                                andUser:(NSString*) userName
                                andPass:(NSString*) pass
                             andOrderId:(NSString*) orderId
                          andCardNumber:(NSString*) cardNumber
                                andCVV2:(NSString*) cvv2
                             andExpDate:(NSString*) expDate;

-(Message*) parseJsonToMessage:(NSString*) jsonString;

@end
