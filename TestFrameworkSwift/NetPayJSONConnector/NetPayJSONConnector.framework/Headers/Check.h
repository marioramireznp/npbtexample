@interface Check : NSObject {
  NSString * accountNumber;
  NSString * accountType;
  NSString * authType;
  NSString * checkNumber;
  NSString * checkType;
  NSString * entryClass;
  NSString * routingAccountNumber;
  NSString * routingNumber;
  NSString * routingReference;
  NSString * routingTransId;
  NSString * bankId;
  NSString * bankName;
}

@property(nonatomic, retain) NSString * accountNumber;
@property(nonatomic, retain) NSString * accountType;
@property(nonatomic, retain) NSString * authType;
@property(nonatomic, retain) NSString * checkNumber;
@property(nonatomic, retain) NSString * checkType;
@property(nonatomic, retain) NSString * entryClass;
@property(nonatomic, retain) NSString * routingAccountNumber;
@property(nonatomic, retain) NSString * routingNumber;
@property(nonatomic, retain) NSString * routingReference;
@property(nonatomic, retain) NSString * routingTransId;
@property(nonatomic, retain) NSString * bankId;
@property(nonatomic, retain) NSString * bankName;
- (void) setAccountNumber:(NSString *)accountNumber;
- (void) setAccountType:(NSString *)accountType;
- (void) setAuthType:(NSString *)authType;
- (void) setCheckNumber:(NSString *)checkNumber;
- (void) setCheckType:(NSString *)checkType;
- (void) setEntryClass:(NSString *)entryClass;
- (void) setRoutingAccountNumber:(NSString *)routingAccountNumber;
- (void) setRoutingNumber:(NSString *)routingNumber;
- (void) setRoutingReference:(NSString *)routingReference;
- (void) setRoutingTransId:(NSString *)routingTransId;
- (void) setBankId:(NSString *)bankId;
- (void) setBankName:(NSString *)bankName;
@end
