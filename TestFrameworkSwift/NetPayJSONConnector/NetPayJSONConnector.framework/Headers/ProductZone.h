@interface ProductZone : NSObject {
  NSString * attribute1;
  NSString * attribute2;
  NSString * attribute3;
  NSString * attribute4;
  NSNumber * productId;
  NSString * zoneName;
  NSString * zoneNameDesc;
}

@property(nonatomic, retain) NSString * attribute1;
@property(nonatomic, retain) NSString * attribute2;
@property(nonatomic, retain) NSString * attribute3;
@property(nonatomic, retain) NSString * attribute4;
@property(nonatomic, retain) NSNumber * productId;
@property(nonatomic, retain) NSString * zoneName;
@property(nonatomic, retain) NSString * zoneNameDesc;
- (void) setAttribute1:(NSString *)value;
- (void) setAttribute2:(NSString *)value;
- (void) setAttribute3:(NSString *)attribute3;
- (void) setAttribute4:(NSString *)attribute4;
- (void) setProductId:(NSNumber *)productId;
- (void) setZoneName:(NSString *)zoneName;
- (void) setZoneNameDesc:(NSString *)zoneNameDesc;
@end
