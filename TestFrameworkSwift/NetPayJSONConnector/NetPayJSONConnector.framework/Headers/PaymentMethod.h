#import "CreditCard.h"
#import "Check.h"

@interface PaymentMethod : NSObject {
  NSString * type;
  CreditCard * creditCard;
  Check * check;
}

@property(nonatomic, retain) NSString * type;
@property(nonatomic, retain) CreditCard * creditCard;
@property(nonatomic, retain) Check * check;
- (void) setType:(NSString *)value;
- (void) setCreditCard:(CreditCard *)value;
- (void) setCheck:(Check *)check;
@end
