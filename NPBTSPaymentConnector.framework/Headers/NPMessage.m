//
//  NPMessage.m
//  NetpayPOWA
//
//  Created by Zeferino Casanova on 23/10/15.
//  Copyright © 2015 Netpay. All rights reserved.
//

#import "NPMessage.h"

@interface NPMessage()

@property (nonatomic, retain) NSString *AuthCode;
@property (nonatomic, retain) NSString *ResponseCode;
@property (nonatomic, retain) NSString *ResponseMsg;
@property (nonatomic, retain) NSString *ResponseText;
@property (nonatomic, retain) NSString *MerchantId;
@property (nonatomic, retain) NSString *BankName;
@property (nonatomic, retain) NSString *BankId;
@property (nonatomic, retain) NSString *CardTypeId;
@property (nonatomic, retain) NSString *CardNature;
@property (nonatomic, retain) NSString *CardTypeName;
@property (nonatomic, retain) NSString *TransactionId;
@property (nonatomic, retain) NSString *OrderId;
@property (nonatomic, retain) NSString *Attribute1;
@property (nonatomic, retain) NSString *Attribute2;
@property (nonatomic, retain) NSString *Attribute3;
@property (nonatomic, retain) NSString *Attribute4;
@property (nonatomic, retain) NSString *Attribute5;
@property (nonatomic, retain) NSString *Attribute6;
@property (nonatomic, retain) NSString *Attribute7;
@property (nonatomic, retain) NSString *Attribute8;
@property (nonatomic, retain) NSString *Attribute9;
@property (nonatomic, retain) NSString *Attribute10;

@property (nonatomic, retain) NSString *IssuerAuthData;

@property (nonatomic, retain) NSString *LastDigits;
@property (nonatomic, retain) NSString *AppPrefName;
@property (nonatomic, retain) NSString *AppLabel;
@property (nonatomic, retain) NSString *CustomerName;
@property (nonatomic, retain) NSString *ARQC;
@property (nonatomic, retain) NSString *AID;
@property (nonatomic, retain) NSString *ARPC;

@property (nonatomic, retain) NSDictionary *NormalMsg;
@property (nonatomic, retain) NSDictionary *ReverseMsg;

@property (nonatomic, assign) BOOL secondaryHost;

@property (nonatomic, retain) NPTransaction *transaction;
@property (nonatomic, retain) LWMessage *reader;




@end

@implementation NPMessage

#pragma mark - Internal

- (void) setResponse:(NSString*) resCode resMsg:(NSString*)resMsg authCode:(NSString*)authCode resTxt:(NSString*)resTxt attr1:(NSString*) attribute1 attr2:(NSString*) attribute2{
    
    self.ResponseMsg = resMsg;
    self.ResponseCode = resCode;
    self.ResponseText = resTxt;
    self.AuthCode = authCode;
    self.Attribute1 = attribute1;
    self.Attribute2 = attribute2;
    
}

//- (void) sendTransaction:(NPTransaction *)transaction ResponseReader:(LWMessage *)reader {
//
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//    self.transaction = transaction;
//    self.reader = reader;
//    self.secondaryHost = NO;
//
//    NSDictionary *prvReverse = [defaults objectForKey:@"Reverse"];
//
//    if(prvReverse != nil){
//        NSLog(@"Si hay Reverso");
//        [self connectToHost:self.transaction.host1 withMsg:prvReverse isReverse:YES];
//
//    }

//
//    self.NormalMsg = [[NSDictionary alloc]init];
//    self.ReverseMsg = [[NSDictionary alloc]init];
//
//    self.NormalMsg = [self createReaderJsonDictResource];
//    self.ReverseMsg = [self createReverseJsonDictResource];
//
//    [defaults setObject:self.ReverseMsg forKey:@"Reverse"];
//    [defaults synchronize];
//
//    [self connectToHost:self.transaction.host1 withMsg:self.NormalMsg isReverse:NO];
//
//}

//- (void) sendSaveSale:(NSString*)orderId :(NSString*)totalAmount :(NSString*)imageTicket  {
//
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//     self.secondaryHost = NO;
//    
//
//    self.NormalMsg = [[NSDictionary alloc]init];
//    
//    self.NormalMsg = [self createSaveSignJsonDictResource:orderId :totalAmount :imageTicket];
//    
//    [defaults synchronize];
//    
//    [self connectToHostSignature:self.transaction.host1 withMsg:self.NormalMsg isReverse:NO];
//    
//}

//- (void)connectToHost: (NSString*)host withMsg:(NSDictionary*) dict isReverse:(BOOL) reverse{
//    // 1
//    NSURL *url = [NSURL URLWithString:host];
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
//
//    // 2
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
//                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                                            timeoutInterval:30.0];
//    request.HTTPMethod = @"POST";
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    // 3
//    NSError *error = nil;
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict
//                                                   options:kNilOptions error:&error];
//
//    NSString* jsonRqst = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"jsonRqst:'%@'", jsonRqst);
//
//    if (!error) {
//        // 4
//        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
//                                                                   fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
//
//                                                                       //NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
//
//                                                                       if(!error){
//
//                                                                           [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Reverse"];
//
//                                                                           NSString *resp = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                                                                           NSLog(@"Response:'%@'", resp);
//
//
//                                                                           NetPayJSONConnector *nparser = [[NetPayJSONConnector alloc] init];
//
//                                                                           Message *msg = [nparser parseJsonToMessage:resp];
//
//                                                                           self.ResponseCode = msg.response.responseCode;
//                                                                           self.ResponseMsg = msg.response.responseMsg;
//                                                                           self.ResponseText = msg.response.responseText;
//                                                                           self.AuthCode = msg.order.transaction.authCode;
//
//                                                                           if([self.reader.device isEqualToString:@"BT"]){
//                                                                               self.ARQC = msg.order.transaction.attribute3;
//                                                                           }
//
//                                                                           if(msg.order.transaction.issuerAuthData!=nil)
//                                                                           {
//
//                                                                               NSString *unencodedUrlString = [msg.order.transaction.issuerAuthData stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                                                                               NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:unencodedUrlString options:0];
//                                                                               NSString *dString = [self dataToHex:decodedData] ;
//                                                                               self.ARPC = [dString uppercaseString];
//
//                                                                           }
//                                                                           else{
//                                                                               self.ARPC = @"";
//                                                                           }
//
//
//                                                                           self.TransactionId = msg.order.transaction.transactionId;
//                                                                           self.OrderId = msg.order.orderId;
//                                                                           if(!reverse){
//
//                                                                               [self.delegate didResponseTransaction];
//                                                                           }
//
//                                                                       }else{
//
//                                                                            if (!self.secondaryHost && !reverse) {
//
//                                                                                NSLog(@"Sendodary Host");
//                                                                                self.secondaryHost = YES;
//                                                                                [self connectToHost:self.transaction.host2 withMsg:self.NormalMsg isReverse:NO];
//
//                                                                            }else{
//
//                                                                                NSLog(@"Sin comunicación");
//                                                                                self.ResponseCode = @"";
//                                                                                self.ResponseMsg = @"Sin Comunicación";
//                                                                                self.ResponseText = @"";
//                                                                                self.AuthCode = @"";
//
//                                                                                if(!reverse){
//                                                                                    [self.delegate didResponseTransaction];
//                                                                                }
//                                                                            }
//
//                                                                       }
//
//
//
//                                                                   }];
//
//        // 5
//        [uploadTask resume];
//    }
//}


//
//- (void)connectToHostSignature: (NSString*)host withMsg:(NSDictionary*) dict isReverse:(BOOL) reverse{
//    // 1
//    NSURL *url = [NSURL URLWithString:host];
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
//
//    // 2
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
//                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                                            timeoutInterval:30.0];
//    request.HTTPMethod = @"POST";
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    // 3
//    NSError *error = nil;
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict
//                                                   options:kNilOptions error:&error];
//
//    NSString* jsonRqst = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"jsonRqst:'%@'", jsonRqst);
//
//    if (!error) {
//        // 4
//        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
//                                                                   fromData:data completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
//
//                                                                       //NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
//
//                                                                       if(!error){
//
//                                                                           [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Reverse"];
//
//                                                                           NSString *resp = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                                                                           NSLog(@"Response:'%@'", resp);
//
//
//                                                                           NetPayJSONConnector *nparser = [[NetPayJSONConnector alloc] init];
//
//                                                                           Message *msg = [nparser parseJsonToMessage:resp];
//
//                                                                           self.ResponseCode = msg.response.responseCode;
//                                                                           self.ResponseMsg = msg.response.responseMsg;
//                                                                           self.ResponseText = msg.response.responseText;
//                                                                           self.AuthCode = msg.order.transaction.authCode;
//
//                                                                           if([self.reader.device isEqualToString:@"BT"]){
//                                                                               self.ARQC = msg.order.transaction.attribute3;
//                                                                           }
//
//                                                                           if(msg.order.transaction.issuerAuthData!=nil)
//                                                                           {
//
//                                                                               NSString *unencodedUrlString = [msg.order.transaction.issuerAuthData stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                                                                               NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:unencodedUrlString options:0];
//                                                                               NSString *dString = [self dataToHex:decodedData] ;
//                                                                               self.ARPC = [dString uppercaseString];
//
//                                                                           }
//                                                                           else{
//                                                                               self.ARPC = @"";
//                                                                           }
//
//
//                                                                           self.TransactionId = msg.order.transaction.transactionId;
//                                                                           self.OrderId = msg.order.orderId;
//                                                                           if(!reverse){
//
//                                                                               [self.delegate didResponseSignature];
//                                                                           }
//
//                                                                       }else{
//
//                                                                           if (!self.secondaryHost && !reverse) {
//
//                                                                               NSLog(@"Sendodary Host");
//                                                                               self.secondaryHost = YES;
//                                                                               [self connectToHostSignature:self.transaction.host2 withMsg:self.NormalMsg isReverse:NO];
//
//                                                                           }else{
//
//                                                                               NSLog(@"Sin comunicación");
//                                                                               self.ResponseCode = @"";
//                                                                               self.ResponseMsg = @"Sin Comunicación";
//                                                                               self.ResponseText = @"";
//                                                                               self.AuthCode = @"";
//
//                                                                               if(!reverse){
//                                                                                   [self.delegate didResponseSignature];
//                                                                               }
//                                                                           }
//
//                                                                       }
//
//
//
//                                                                   }];
//
//        // 5
//        [uploadTask resume];
//    }
//}

- (NSDictionary *) createReaderJsonDictResource{
    
    self.AppPrefName = self.reader.appPrefData;
    self.AppLabel = self.reader.appLabelData;
    self.CustomerName = self.reader.customerName;
    self.AID = self.reader.AID;
    self.ARQC = self.reader.ARQC;
    self.LastDigits = self.reader.lastDigits;
    
    NSMutableDictionary *security = [[NSMutableDictionary alloc] init];
    [security setValue:self.transaction.storeId forKey:@"storeId"];
    [security setValue:self.transaction.username forKey:@"userName"];
    [security setValue:self.transaction.password forKey:@"password"];
    
    NSMutableDictionary *total = [[NSMutableDictionary alloc] init];
    [total setValue:self.transaction.amount forKey:@"total"];
    
    NSMutableDictionary *transaction = [[NSMutableDictionary alloc] init];
    [transaction setValue:total forKey:@"total"];
    [transaction setValue:self.transaction.terminalId forKey:@"terminalId"];
    if ([self isSetParam:self.transaction.promotion]) [transaction setValue:self.transaction.promotion forKey:@"promotion"];
    
    [transaction setValue:self.transaction.attribute1 forKey:@"attribute1"];
    
    if ([self isSetParam:self.reader.KSN]){
        [transaction setValue:self.reader.KSN forKey:@"ksn"];
        [transaction setValue:@"2" forKey:@"cardholderPresentCode"];
    }else{
        [transaction setValue:@"5" forKey:@"cardholderPresentCode"];
    }
    
    NSMutableDictionary *creditCard = [[NSMutableDictionary alloc] init];
    if ([self isSetParam:self.reader.track1]) [creditCard setValue:self.reader.track1 forKey:@"track1"];
    if ([self isSetParam:self.reader.track2]) [creditCard setValue:self.reader.track2 forKey:@"track2"];
    if ([self isSetParam:self.reader.CVV2])[creditCard setValue:self.reader.CVV2 forKey:@"cvv2"];
    if ([self isSetParam:self.reader.EMVTags])[creditCard setValue:self.reader.EMVTags forKey:@"EMVTags"];
    
    if([self.reader.device isEqualToString:@"BT"]){
        [self isSetParam:self.reader.KSN] ? [creditCard setValue:@"DSPREADMSR" forKey:@"EMVTagsEncType"] : [creditCard setValue:@"DSPREADICC" forKey:@"EMVTagsEncType"];
    }else{
        [self isSetParam:self.reader.KSN] ? [creditCard setValue:@"DMOBMSR" forKey:@"EMVTagsEncType"] : [creditCard setValue:@"DMOBICC" forKey:@"EMVTagsEncType"];
    }
    
    
    NSMutableDictionary *paymentMethod = [[NSMutableDictionary alloc] init];
    [paymentMethod setValue:creditCard forKey:@"creditCard"];
    
    NSMutableDictionary *customer = [[NSMutableDictionary alloc] init];
    [customer setValue:paymentMethod forKey:@"paymentMethod"];
    
    NSMutableDictionary *order = [[NSMutableDictionary alloc] init];
    [order setValue:self.transaction.mode forKey:@"mode"];
    [order setValue:self.transaction.orderId forKey:@"orderId"];
    
    [order setValue:customer forKey:@"customer"];
    [order setValue:transaction forKey:@"transaction"];
    
    NSMutableDictionary *message = [[NSMutableDictionary alloc] init];
    [message setValue:@"Transaction" forKey:@"contentType"];
    [message setValue:self.transaction.transType forKey:@"resourceName"];
    [message setValue:security forKey:@"security"];
    [message setValue:order forKey:@"order"];
    
    return message;
    
}



- (NSDictionary *) createSaveSignJsonDictResource :(NSString*)orderId :(NSString*)totalAmount :(NSString*)imageTicket {
    

    
    NSMutableDictionary *security = [[NSMutableDictionary alloc] init];
    [security setValue:self.transaction.storeId forKey:@"storeId"];
    [security setValue:self.transaction.username forKey:@"userName"];
    [security setValue:self.transaction.password forKey:@"password"];
 
    
    NSMutableDictionary *order = [[NSMutableDictionary alloc] init];
     [order setValue:orderId forKey:@"orderId"];
    [order setValue:imageTicket forKey:@"signature"];
    
    [order setValue:totalAmount forKey:@"totalAmount"];

    
    NSMutableDictionary *value = [[NSMutableDictionary alloc] init];
    [value setValue:@"Monto" forKey:@"productName"];
    [value setValue:totalAmount forKey:@"productPrice"];
    [value setValue:@"1" forKey:@"amount"];
    [value setValue:@"1" forKey:@"total"];
    [value setValue:@"1" forKey:@"attribute1"];
    [value setValue:@"0" forKey:@"productID"];
    
    NSMutableArray * valueArray = [[NSMutableArray alloc]init];
    [valueArray addObject:value];

    NSMutableDictionary *valueList = [[NSMutableDictionary alloc] init];
    [valueList setObject:valueArray forKey:@"value"];

    NSMutableDictionary *report = [[NSMutableDictionary alloc] init];
    [report setObject:valueList forKey:@"valueList"];

 
    
    NSMutableDictionary *message = [[NSMutableDictionary alloc] init];
    [message setValue:@"Report" forKey:@"contentType"];
    [message setValue:@"SaveSale" forKey:@"resourceName"];
    [message setValue:security forKey:@"security"];
    [message setValue:order forKey:@"order"];
    [message setValue:report forKey:@"report"];

    
    return message;
    
}

- (NSDictionary *) createReverseJsonDictResource{
    
    self.AppPrefName = self.reader.appPrefData;
    self.AppLabel = self.reader.appLabelData;
    self.CustomerName = self.reader.customerName;
    self.AID = self.reader.AID;
    self.ARQC = self.reader.ARQC;
    
    NSMutableDictionary *security = [[NSMutableDictionary alloc] init];
    [security setValue:self.transaction.storeId forKey:@"storeId"];
    [security setValue:self.transaction.username forKey:@"userName"];
    [security setValue:self.transaction.password forKey:@"password"];
    
    NSMutableDictionary *total = [[NSMutableDictionary alloc] init];
    [total setValue:self.transaction.amount forKey:@"total"];
    
    NSMutableDictionary *transaction = [[NSMutableDictionary alloc] init];
    [transaction setValue:total forKey:@"total"];
    [transaction setValue:self.transaction.terminalId forKey:@"terminalId"];
    if ([self isSetParam:self.transaction.promotion]) [transaction setValue:self.transaction.promotion forKey:@"promotion"];
    
    [transaction setValue:self.transaction.attribute1 forKey:@"attribute1"];
    
    if ([self isSetParam:self.reader.KSN]){
        [transaction setValue:self.reader.KSN forKey:@"ksn"];
        [transaction setValue:@"2" forKey:@"cardholderPresentCode"];
    }else{
        [transaction setValue:@"5" forKey:@"cardholderPresentCode"];
    }
    
    NSMutableDictionary *creditCard = [[NSMutableDictionary alloc] init];
    if ([self isSetParam:self.reader.track1]) [creditCard setValue:self.reader.track1 forKey:@"track1"];
    if ([self isSetParam:self.reader.track2]) [creditCard setValue:self.reader.track2 forKey:@"track2"];
    if ([self isSetParam:self.reader.CVV2])[creditCard setValue:self.reader.CVV2 forKey:@"cvv2"];
    if ([self isSetParam:self.reader.EMVTags])[creditCard setValue:self.reader.EMVTags forKey:@"EMVTags"];
    
    if([self.reader.device isEqualToString:@"BT"]){
        [self isSetParam:self.reader.KSN] ? [creditCard setValue:@"DSPREADMSR" forKey:@"EMVTagsEncType"] : [creditCard setValue:@"DSPREADICC" forKey:@"EMVTagsEncType"];
    }else{
        [self isSetParam:self.reader.KSN] ? [creditCard setValue:@"DMOBMSR" forKey:@"EMVTagsEncType"] : [creditCard setValue:@"DMOBICC" forKey:@"EMVTagsEncType"];
    }
    
    
    NSMutableDictionary *paymentMethod = [[NSMutableDictionary alloc] init];
    [paymentMethod setValue:creditCard forKey:@"creditCard"];
    
    NSMutableDictionary *customer = [[NSMutableDictionary alloc] init];
    [customer setValue:paymentMethod forKey:@"paymentMethod"];
    
    NSMutableDictionary *order = [[NSMutableDictionary alloc] init];
    [order setValue:self.transaction.mode forKey:@"mode"];
    [order setValue:self.transaction.orderId forKey:@"orderId"];
    
    [order setValue:customer forKey:@"customer"];
    [order setValue:transaction forKey:@"transaction"];
    
    NSMutableDictionary *message = [[NSMutableDictionary alloc] init];
    [message setValue:@"Transaction" forKey:@"contentType"];
    [message setValue:@"Reverse" forKey:@"resourceName"];
    [message setValue:security forKey:@"security"];
    [message setValue:order forKey:@"order"];
    
    return message;
    
}

-(BOOL) isSetParam: (NSString*) param{
    
    if ([param length] == 0) {
        return NO;
    }else{
        return YES;
    }
    
    
}

- (NSString *) stringToHex:(NSString *)str
{
    NSUInteger len = [str length];
    unichar *chars = malloc(len * sizeof(unichar));
    [str getCharacters:chars];
    
    NSMutableString *hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendFormat:@"%02x", chars[i]];
    }
    free(chars);
    
    return hexString;
}
- (NSString *)dataToHex:(NSData*)data {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

@end
