@interface Permission : NSObject {
  NSString * resourceName;
  NSString * permissionName;
}

@property(nonatomic, retain) NSString * resourceName;
@property(nonatomic, retain) NSString * permissionName;
- (void) setResourceName:(NSString *)value;
- (void) setPermissionName:(NSString *)value;
@end
