@interface FraudRuleListDetail {
  NSString * detailId;
  NSString * listId;
  NSString * itemDesc;
  NSString * itemValue;
}

@property(nonatomic, retain) NSString * detailId;
@property(nonatomic, retain) NSString * listId;
@property(nonatomic, retain) NSString * itemDesc;
@property(nonatomic, retain) NSString * itemValue;
- (void) setDetailId:(NSString *)detailId;
- (void) setListId:(NSString *)listId;
- (void) setItemDesc:(NSString *)itemDesc;
- (void) setItemValue:(NSString *)itemValue;
@end
