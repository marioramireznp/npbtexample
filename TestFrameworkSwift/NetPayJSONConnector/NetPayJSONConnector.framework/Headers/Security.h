@interface Security : NSObject <NSCoding>{
  NSString * userName;
  NSString * password;
  NSString * roleName;
  NSNumber * storeId;
  NSNumber * userId;
}

@property(nonatomic, retain) NSString * userName;
@property(nonatomic, retain) NSString * password;
@property(nonatomic, retain) NSNumber * storeId;
@property(nonatomic, retain) NSString * roleName;
@property(nonatomic, retain) NSNumber * userId;
- (void) setUserName:(NSString *)value;
- (void) setPassword:(NSString *)value;
- (void) setStoreId:(NSNumber *)value;
- (void) setRoleName:(NSString *)roleName;
- (void) setUserId:(NSNumber *)userId;



@end
