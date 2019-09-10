@interface ProcParam : NSObject {
  NSString * paramName;
  NSString * paramValue;
  NSString * paramType;
}

@property(nonatomic, retain) NSString * paramType;
@property(nonatomic, retain) NSString * paramName;
@property(nonatomic, retain) NSString * paramValue;
- (void) setParamType:(NSString *)paramType;
- (void) setParamName:(NSString *)paramName;
- (void) setParamValue:(NSString *)paramValue;
@end
