#import "Customer.h"
#import "Transaction.h"
#import "ProductListOrder.h"

@interface Order : NSObject {
  NSString * orderId;
  NSString * groupId;
  NSString * comments;
  NSString * dateTime;
  NSString * mode;
  Customer * customer;
  Transaction * transaction;
  NSNumber * weightShip;
  NSNumber * quantityShip;
  ProductListOrder * productListOrder;
  NSString * timeZone;
  NSString * promotion;
  NSString * IPAddress;
  NSString * hostName;
  NSString * status;
    NSString * ticketID;
}

@property(nonatomic, retain) NSString * status;
@property(nonatomic, retain) NSString * orderId;
@property(nonatomic, retain) NSString * groupId;
@property(nonatomic, retain) NSString * comments;
@property(nonatomic, retain) NSString * dateTime;
@property(nonatomic, retain) NSString * mode;
@property(nonatomic, retain) Customer * customer;
@property(nonatomic, retain) Transaction * transaction;
@property(nonatomic, retain) NSNumber * weightShip;
@property(nonatomic, retain) NSNumber * quantityShip;
@property(nonatomic, retain) ProductListOrder * productListOrder;
@property(nonatomic, retain) NSString * timeZone;
@property(nonatomic, retain) NSString * promotion;
@property(nonatomic, retain) NSString * iPAddress;
@property(nonatomic, retain) NSString * hostName;
@property(nonatomic, retain) NSString * ticketID;
- (void) setStatus:(NSString *)status;
- (void) setOrderId:(NSString *)value;
- (void) setGroupId:(NSString *)value;
- (void) setComments:(NSString *)value;
- (void) setDateTime:(NSString *)value;
- (void) setMode:(NSString *)value;
- (void) setCustomer:(Customer *)value;
- (void) setTransaction:(Transaction *)value;
- (void) setWeightShip:(NSNumber *)weightShip;
- (void) setQuantityShip:(NSNumber *)quantityShip;
- (void) setProductListOrder:(ProductListOrder *)productListOrder;
- (void) setTimeZone:(NSString *)timeZone;
- (void) setPromotion:(NSString *)promotion;
- (void) setIPAddress:(NSString *)IPAddress;
- (void) setHostName:(NSString *)hostName;
- (void) setTicketID:(NSString *)ticketID;
@end
