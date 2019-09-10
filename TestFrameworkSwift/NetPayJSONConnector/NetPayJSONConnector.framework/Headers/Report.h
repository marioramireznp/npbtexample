#import "ValueList.h"

@interface Report : NSObject {
  NSNumber * pageNumber;
  NSNumber * pageCount;
  NSNumber * pageSize;
  ValueList * valueList;
  NSString * containerType;
}

@property(nonatomic, retain) NSNumber * pageNumber;
@property(nonatomic, retain) NSNumber * pageCount;
@property(nonatomic, retain) NSNumber * pageSize;
@property(nonatomic, retain) ValueList * valueList;
@property(nonatomic, retain) NSString * containerType;
- (void) setPageNumber:(NSNumber *)value;
- (void) setPageCount:(NSNumber *)value;
- (void) setPageSize:(NSNumber *)value;
- (void) setValueList:(ValueList *)value;
- (void) setContainerType:(NSString *)containerType;
@end
