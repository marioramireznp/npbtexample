#import "PermissionList.h"
#import "PackageList.h"

@interface Role : NSObject {
  NSString * roleName;
  NSString * roleDesc;
  PermissionList * permissionList;
  NSString * userOwnerName;
  NSString * defaultMask;
  NSNumber * entityOwnerId;
  NSNumber * parentStoreId;
  PackageList * packageList;
}

@property(nonatomic, retain) PackageList * packageList;
@property(nonatomic, retain) NSNumber * parentStoreId;
@property(nonatomic, retain) NSString * roleName;
@property(nonatomic, retain) NSString * roleDesc;
@property(nonatomic, retain) PermissionList * permissionList;
@property(nonatomic, retain) NSString * userOwnerName;
@property(nonatomic, retain) NSString * defaultMask;
@property(nonatomic, retain) NSNumber * entityOwnerId;
- (void) setPackageList:(PackageList *)packageList;
- (void) setParentStoreId:(NSNumber *)parentStoreId;
- (void) setRoleName:(NSString *)value;
- (void) setRoleDesc:(NSString *)value;
- (void) setPermissionList:(PermissionList *)value;
- (void) setUserOwnerName:(NSString *)userOwnerName;
- (void) setDefaultMask:(NSString *)defaultMask;
- (void) setEntityOwnerId:(NSNumber *)entityOwnerId;
@end
