@interface Total : NSObject <NSCoding>{
  NSNumber * altTax;
  NSNumber * discAmt;
  NSNumber * dutyTax;
  NSNumber * ship;
  NSNumber * subTotal;
  NSNumber * total;
  NSNumber * count;
}

@property(nonatomic, retain) NSNumber * altTax;
@property(nonatomic, retain) NSNumber * discAmt;
@property(nonatomic, retain) NSNumber * dutyTax;
@property(nonatomic, retain) NSNumber * ship;
@property(nonatomic, retain) NSNumber * subTotal;
@property(nonatomic, retain) NSNumber * total;
@property(nonatomic, retain) NSNumber * count;
- (void) setAltTax:(NSNumber *)value;
- (void) setDiscAmt:(NSNumber *)value;
- (void) setDutyTax:(NSNumber *)value;
- (void) setShip:(NSNumber *)value;
- (void) setSubTotal:(NSNumber *)value;
- (void) setTotal:(NSNumber *)value;
- (void) setCount:(NSNumber *)value;
@end
