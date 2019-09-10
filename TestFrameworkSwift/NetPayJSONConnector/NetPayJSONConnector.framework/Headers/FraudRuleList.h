@interface FraudRuleList {
  NSString * listId;
  NSString * description;
  NSString * status;
  NSMutableArray * fraudRuleListDetail;
}

@property(nonatomic, retain) NSString * listId;
@property(nonatomic, retain) NSString * description;
@property(nonatomic, retain) NSString * status;
@property(nonatomic, retain) NSMutableArray * fraudRuleListDetail;
- (void) setListId:(NSString *)listId;
- (void) setDescription:(NSString *)description;
- (void) setStatus:(NSString *)status;
- (void) setFraudRuleListDetail:(NSMutableArray *)fraudRuleListDetail;
@end
