@interface ConsCenter : NSObject {
  NSString * centerId;
  NSString * centerName;
  NSString * centerDesc;
  NSString * actionFlag;
}

@property(nonatomic, retain) NSString * centerId;
@property(nonatomic, retain) NSString * centerName;
@property(nonatomic, retain) NSString * centerDesc;
@property(nonatomic, retain) NSString * actionFlag;
- (void) setCenterId:(NSString *)centerId;
- (void) setCenterName:(NSString *)centerName;
- (void) setCenterDesc:(NSString *)centerDesc;
- (void) setActionFlag:(NSString *)actionFlag;
@end
