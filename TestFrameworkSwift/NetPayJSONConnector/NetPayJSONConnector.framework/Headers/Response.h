@interface Response : NSObject <NSCoding>{
  BOOL approved;
  NSString * responseCode;
  NSString * responseMsg;
  NSString * responseText;
  NSString * responseException;
  NSString * timeIn;
  NSString * timeOut;
  NSString * type;
}

@property(nonatomic, retain) NSString * type;
@property(nonatomic, retain) NSString * responseCode;
@property(nonatomic, retain) NSString * responseMsg;
@property(nonatomic, retain) NSString * responseText;
@property(nonatomic, retain) NSString * responseException;
@property(nonatomic) BOOL approved;
@property(nonatomic, retain) NSString * timeIn;
@property(nonatomic, retain) NSString * timeOut;
- (void) setType:(NSString *)type;
- (void) setResponseCode:(NSString *)value;
- (void) setResponseMsg:(NSString *)value;
- (void) setResponseText:(NSString *)value;
- (void) setResponseException:(NSString *)value;
- (void) setApproved:(BOOL)approved;
- (void) setTimeIn:(NSString *)timeIn;
- (void) setTimeOut:(NSString *)timeOut;
@end
