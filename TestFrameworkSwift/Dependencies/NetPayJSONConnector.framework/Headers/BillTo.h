#import "Location.h"

@interface BillTo : NSObject {
  NSMutableArray * location;
}

@property(nonatomic, retain, readonly) NSMutableArray * location;
- (void) addLocation:(Location *)loc;
@end
