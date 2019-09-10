@interface StoreServiceLimits : NSObject {
  NSString * serviceId;
  NSString * storeId;
  NSString * resourceName;
  NSString * dailyTxCountLmt;
  NSString * dailyTxAmtLmt;
  NSString * monthlyTxCountLmt;
  NSString * monthlyTxAmtLmt;
}

@property(nonatomic, retain) NSString * resourceName;
@property(nonatomic, retain, readonly) NSString * id;
@property(nonatomic, retain) NSString * serviceId;
@property(nonatomic, retain) NSString * storeId;
@property(nonatomic, retain) NSString * dailyTxCountLmt;
@property(nonatomic, retain) NSString * dailyTxAmtLmt;
@property(nonatomic, retain) NSString * monthlyTxCountLmt;
@property(nonatomic, retain) NSString * monthlyTxAmtLmt;
- (void) setResourceName:(NSString *)resourceName;
- (NSString *) description;
- (void) setServiceId:(NSString *)serviceId;
- (void) setStoreId:(NSString *)storeId;
- (void) setDailyTxCountLmt:(NSString *)dailyTxCountLmt;
- (void) setDailyTxAmtLmt:(NSString *)dailyTxAmtLmt;
- (void) setMonthlyTxCountLmt:(NSString *)monthlyTxCountLmt;
- (void) setMonthlyTxAmtLmt:(NSString *)monthlyTxAmtLmt;
@end
