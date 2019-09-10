#import "ProductList.h"

@interface Zone : NSObject {
  NSString * zoneName;
  NSString * zoneDesc;
  ProductList * productList;
  NSString * attribute1;
  NSString * attribute2;
  NSString * attribute3;
  NSString * attribute4;
  NSString * effectiveDate;
}

@property(nonatomic, retain) NSString * zoneName;
@property(nonatomic, retain) NSString * zoneDesc;
@property(nonatomic, retain) ProductList * productList;
@property(nonatomic, retain) NSString * attribute1;
@property(nonatomic, retain) NSString * attribute2;
@property(nonatomic, retain) NSString * attribute3;
@property(nonatomic, retain) NSString * attribute4;
@property(nonatomic, retain) NSString * effectiveDate;
- (void) setZoneName:(NSString *)value;
- (void) setZoneDesc:(NSString *)value;
- (void) setProductList:(ProductList *)value;
- (void) setAttribute1:(NSString *)attribute1;
- (void) setAttribute2:(NSString *)attribute2;
- (void) setAttribute3:(NSString *)attribute3;
- (void) setAttribute4:(NSString *)attribute4;
- (void) setEffectiveDate:(NSString *)effectiveDate;
@end
