@interface Email : NSObject {
  NSString * msgTo;
  NSString * msgFrom;
  NSString * msgSubject;
  NSString * msgBody;
  NSString * msgStyle;
}

@property(nonatomic, retain) NSString * msgTo;
@property(nonatomic, retain) NSString * msgFrom;
@property(nonatomic, retain) NSString * msgSubject;
@property(nonatomic, retain) NSString * msgBody;
@property(nonatomic, retain) NSString * msgStyle;
- (void) setMsgTo:(NSString *)value;
- (void) setMsgFrom:(NSString *)value;
- (void) setMsgSubject:(NSString *)value;
- (void) setMsgBody:(NSString *)value;
- (void) setMsgStyle:(NSString *)value;
@end
