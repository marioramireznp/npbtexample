@interface StoreProcParams : NSObject {
  NSString * storeId;
  NSString * merchantId;
  NSString * procName;
  NSString * description;
  NSString * defaultProc;
  NSString * terminalId;
  NSString * term;
  NSString * currencyCode;
  NSString * promotions;
  NSString * bankNumber;
  NSString * user;
  NSString * password;
  NSString * securityCode;
  NSString * storeService;
}

@property(nonatomic, retain) NSString * storeId;
@property(nonatomic, retain) NSString * merchantId;
@property(nonatomic, retain) NSString * procName;
@property(nonatomic, retain) NSString * description;
@property(nonatomic, retain) NSString * defaultProc;
@property(nonatomic, retain) NSString * terminalId;
@property(nonatomic, retain) NSString * term;
@property(nonatomic, retain) NSString * currencyCode;
@property(nonatomic, retain) NSString * promotions;
@property(nonatomic, retain) NSString * bankNumber;
@property(nonatomic, retain) NSString * user;
@property(nonatomic, retain) NSString * password;
@property(nonatomic, retain) NSString * securityCode;
@property(nonatomic, retain) NSString * storeService;
- (void) setStoreId:(NSString *)storeId;
- (void) setMerchantId:(NSString *)merchantId;
- (void) setProcName:(NSString *)procName;
- (void) setDescription:(NSString *)description;
- (void) setDefaultProc:(NSString *)defaultProc;
- (void) setTerminalId:(NSString *)terminalId;
- (void) setTerm:(NSString *)term;
- (void) setCurrencyCode:(NSString *)currencyCode;
- (void) setPromotions:(NSString *)promotions;
- (void) setBankNumber:(NSString *)bankNumber;
- (void) setUser:(NSString *)user;
- (void) setPassword:(NSString *)password;
- (void) setSecurityCode:(NSString *)securityCode;
- (void) setStoreService:(NSString *)storeService;
@end
