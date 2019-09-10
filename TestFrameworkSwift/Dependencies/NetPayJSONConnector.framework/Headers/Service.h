#import "ProductList.h"

@interface Service : NSObject {
  NSString * serviceId;
  NSString * name;
  NSString * alias;
  NSString * description;
  NSString * status;
  NSString * valFields;
  NSString * minLength;
  NSString * maxLength;
  NSString * minAmount;
  NSString * maxAmount;
  NSString * valMod10;
  NSString * valMod97;
  NSString * fieldDataType;
  NSString * transType;
  NSString * procName;
  NSString * operDays;
  ProductList * productList;
}

@property(nonatomic, retain) NSString * serviceId;
@property(nonatomic, retain) NSString * name;
@property(nonatomic, retain) NSString * status;
@property(nonatomic, retain) NSString * valFields;
@property(nonatomic, retain) NSString * minLength;
@property(nonatomic, retain) NSString * maxLength;
@property(nonatomic, retain) NSString * minAmount;
@property(nonatomic, retain) NSString * maxAmount;
@property(nonatomic, retain) NSString * transType;
@property(nonatomic, retain) NSString * procName;
@property(nonatomic, retain) NSString * operDays;
@property(nonatomic, retain) NSString * alias;
@property(nonatomic, retain) NSString * description;
@property(nonatomic, retain) NSString * valMod10;
@property(nonatomic, retain) NSString * valMod97;
@property(nonatomic, retain) NSString * fieldDataType;
@property(nonatomic, retain) ProductList * productList;
- (void) setServiceId:(NSString *)serviceId;
- (void) setName:(NSString *)name;
- (void) setStatus:(NSString *)status;
- (void) setValFields:(NSString *)valFields;
- (void) setMinLength:(NSString *)minLength;
- (void) setMaxLength:(NSString *)maxLength;
- (void) setMinAmount:(NSString *)minAmount;
- (void) setMaxAmount:(NSString *)maxAmount;
- (void) setTransType:(NSString *)transType;
- (void) setProcName:(NSString *)procName;
- (void) setOperDays:(NSString *)operDays;
- (void) setAlias:(NSString *)alias;
- (void) setDescription:(NSString *)description;
- (void) setValMod10:(NSString *)valMod10;
- (void) setValMod97:(NSString *)valMod97;
- (void) setFieldDataType:(NSString *)fieldDataType;
- (void) setProductList:(ProductList *)productList;
@end
