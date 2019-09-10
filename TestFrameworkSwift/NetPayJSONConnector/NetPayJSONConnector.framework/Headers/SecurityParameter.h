@interface SecurityParameter : NSObject {
  NSString * userBlockTime;
  NSString * mininumPasswordLength;
  NSString * passwordHistory;
  NSString * applyPolicy;
  NSString * passwordStrength;
  NSString * expirePassword;
  NSString * blockingUser;
  NSString * failedLoginAttempts;
  NSString * passwordExpirationDays;
}

@property(nonatomic, retain) NSString * failedLoginAttempts;
@property(nonatomic, retain) NSString * passwordExpirationDays;
@property(nonatomic, retain) NSString * userBlockTime;
@property(nonatomic, retain) NSString * applyPolicy;
@property(nonatomic, retain) NSString * mininumPasswordLength;
@property(nonatomic, retain) NSString * passwordHistory;
@property(nonatomic, retain) NSString * passwordStrength;
@property(nonatomic, retain) NSString * expirePassword;
@property(nonatomic, retain) NSString * blockingUser;
- (void) setFailedLoginAttempts:(NSString *)failedLoginAttempts;
- (void) setPasswordExpirationDays:(NSString *)passwordExpirationDays;
- (void) setUserBlockTime:(NSString *)userBlockTime;
- (void) setApplyPolicy:(NSString *)applyPolicy;
- (void) setMininumPasswordLength:(NSString *)mininumPasswordLength;
- (void) setPasswordHistory:(NSString *)passwordHistory;
- (void) setPasswordStrength:(NSString *)passwordStrength;
- (void) setExpirePassword:(NSString *)expirePassword;
- (void) setBlockingUser:(NSString *)blockingUser;
@end
