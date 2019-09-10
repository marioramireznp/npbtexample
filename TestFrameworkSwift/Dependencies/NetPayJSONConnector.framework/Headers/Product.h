#import "Zone.h"

@interface Product : NSObject {
  NSNumber * productId;
  NSString * productDesc;
  NSNumber * category;
  NSString * uniMed;
  NSNumber * basePrice;
  NSNumber * productNumber;
  NSNumber * productCode;
  NSNumber * altTax;
  NSNumber * taxRate;
  NSNumber * quantity;
  NSNumber * weight;
  NSNumber * total;
  Zone * zone;
  NSString * sku;
}

@property(nonatomic, retain) NSNumber * productId;
@property(nonatomic, retain) NSString * productDesc;
@property(nonatomic, retain) NSNumber * category;
@property(nonatomic, retain) NSString * uniMed;
@property(nonatomic, retain) NSNumber * basePrice;
@property(nonatomic, retain) NSNumber * productNumber;
@property(nonatomic, retain) NSNumber * productCode;
@property(nonatomic, retain) NSNumber * altTax;
@property(nonatomic, retain) NSNumber * taxRate;
@property(nonatomic, retain) NSNumber * quantity;
@property(nonatomic, retain) NSNumber * weight;
@property(nonatomic, retain) NSNumber * total;
@property(nonatomic, retain) Zone * zone;
@property(nonatomic, retain) NSString * sku;
- (void) setProductId:(NSNumber *)value;
- (void) setProductDesc:(NSString *)value;
- (void) setCategory:(NSNumber *)value;
- (void) setUniMed:(NSString *)value;
- (void) setBasePrice:(NSNumber *)value;
- (void) setProductNumber:(NSNumber *)productNumber;
- (void) setProductCode:(NSNumber *)productCode;
- (void) setAltTax:(NSNumber *)altTax;
- (void) setTaxRate:(NSNumber *)taxRate;
- (void) setQuantity:(NSNumber *)quantity;
- (void) setWeight:(NSNumber *)weight;
- (void) setTotal:(NSNumber *)total;
- (void) setZone:(Zone *)zone;
- (void) setSku:(NSString *)sku;
@end
