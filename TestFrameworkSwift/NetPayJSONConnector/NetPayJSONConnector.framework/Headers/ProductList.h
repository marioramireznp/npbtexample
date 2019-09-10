@interface ProductList : NSObject {
  NSMutableArray * productZone;
  NSMutableArray * productId;
}

@property(nonatomic, retain, readonly) NSMutableArray * productZone;
@property(nonatomic, retain, readonly) NSMutableArray * productId;
@end
