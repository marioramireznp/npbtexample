@interface ProcCardType : NSObject {
  NSString * procName;
  NSString * cardTypeCd;
}

@property(nonatomic, retain) NSString * procName;
@property(nonatomic, retain) NSString * cardTypeCd;
- (void) setProcName:(NSString *)procName;
- (void) setCardTypeCd:(NSString *)cardTypeCd;
@end
