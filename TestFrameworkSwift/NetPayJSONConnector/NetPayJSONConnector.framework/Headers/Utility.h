#import "Email.h"

@interface Utility : NSObject {
  Email * email;
  NSString * echoType;
}

@property(nonatomic, retain) Email * email;
@property(nonatomic, retain) NSString * echoType;
- (void) setEmail:(Email *)value;
- (void) setEchoType:(NSString *)echoType;
@end
