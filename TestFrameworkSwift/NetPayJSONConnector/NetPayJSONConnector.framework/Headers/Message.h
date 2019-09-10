#import "Security.h"
#import "Order.h"
#import "Report.h"
#import "Config.h"
#import "Utility.h"
#import "Response.h"
#import "SessionContext.h"
#import "Check.h"

@interface Message : NSObject <NSCoding>{
  NSString * contentType;
  NSString * resourceName;
  NSString * IPAddress;
  NSString * hostName;
  Security * security;
  Order * order;
  Report * report;
  Config * config;
  Utility * utility;
  Response * response;
  SessionContext * sessionContext;
  Check * Check;
}

@property(nonatomic, retain) NSString * contentType;
@property(nonatomic, retain) NSString * resourceName;
@property(nonatomic, retain) NSString * iPAddress;
@property(nonatomic, retain) Security * security;
@property(nonatomic, retain) Order * order;
@property(nonatomic, retain) Report * report;
@property(nonatomic, retain) Config * config;
@property(nonatomic, retain) Utility * utility;
@property(nonatomic, retain) Response * response;
@property(nonatomic, retain) SessionContext * sessionContext;
@property(nonatomic, retain) NSString * hostName;
@property(nonatomic, retain) Check * check;
- (void) setContentType:(NSString *)value;
- (void) setResourceName:(NSString *)value;
- (void) setIPAddress:(NSString *)value;
- (void) setSecurity:(Security *)value;
- (void) setOrder:(Order *)value;
- (void) setReport:(Report *)value;
- (void) setConfig:(Config *)value;
- (void) setUtility:(Utility *)value;
- (void) setSessionContext:(SessionContext *)sessionContext;
- (void) setResponse:(Response *)value;
- (void) setHostName:(NSString *)hostName;
- (void) setCheck:(Check *)Check;
@end
