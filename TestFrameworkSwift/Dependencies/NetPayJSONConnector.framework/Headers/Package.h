#import "PermissionList.h"

@interface Package : NSObject {
  NSString * packageId;
  NSString * packageName;
  NSString * active;
  PermissionList * permissionList;
  NSString * storeType;
}

@property(nonatomic, retain) NSString * packageId;
@property(nonatomic, retain) NSString * packageName;
@property(nonatomic, retain) NSString * active;
@property(nonatomic, retain) PermissionList * permissionList;
@property(nonatomic, retain) NSString * storeType;
- (void) setPackageId:(NSString *)packageId;
- (void) setPackageName:(NSString *)packageName;
- (void) setActive:(NSString *)active;
- (void) setPermissionList:(PermissionList *)permissionList;
- (void) setStoreType:(NSString *)storeType;
@end
