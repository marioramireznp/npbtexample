@interface FraudRule : NSObject {
  NSString * name;
  NSString * ruleId;
  NSString * sequence;
  NSString * adviceTo;
  NSString * status;
  NSString * alert;
  NSString * action;
  NSString * storeId;
  NSString * ruleScript;
  NSString * ruleScriptMask;
  NSString * returnMsg;
}

@property(nonatomic, retain) NSString * name;
@property(nonatomic, retain) NSString * ruleId;
@property(nonatomic, retain) NSString * sequence;
@property(nonatomic, retain) NSString * adviceTo;
@property(nonatomic, retain) NSString * status;
@property(nonatomic, retain) NSString * alert;
@property(nonatomic, retain) NSString * action;
@property(nonatomic, retain) NSString * storeId;
@property(nonatomic, retain) NSString * ruleScript;
@property(nonatomic, retain) NSString * ruleScriptMask;
@property(nonatomic, retain) NSString * returnMsg;
- (void) setName:(NSString *)name;
- (void) setRuleId:(NSString *)ruleId;
- (void) setSequence:(NSString *)sequence;
- (void) setAdviceTo:(NSString *)adviceTo;
- (void) setStatus:(NSString *)status;
- (void) setAlert:(NSString *)alert;
- (void) setAction:(NSString *)action;
- (void) setStoreId:(NSString *)storeId;
- (void) setRuleScript:(NSString *)ruleScript;
- (void) setRuleScriptMask:(NSString *)ruleScriptMask;
- (void) setReturnMsg:(NSString *)returnMsg;
@end
