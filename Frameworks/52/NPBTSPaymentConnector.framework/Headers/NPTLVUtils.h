//
//  NPTLVUtils.h
//  TOKS
//
//  Created by DiegoNavarro on 10/24/13.
//  Copyright (c) 2013 NetPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPTLVUtils : NSObject

+ (NSMutableDictionary*)processTLV:(NSString*)tlvString;

+ (NSString*)convertToTLV:(NSMutableDictionary*)tagList;

+ (NSString*)hexToString:(NSString*)hexString;

@end
