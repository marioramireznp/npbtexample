#import "BillTo.h"
#import "ShipTo.h"
#import "PaymentMethod.h"

@interface Customer : NSObject {
  NSString * customerId;
  NSString * email;
  NSString * birthDate;
  NSString * shipToSameAsBillTo;
  NSString * socialSecurityNumber;
  NSString * driversLicense;
  NSString * taxId;
  BillTo * billTo;
  ShipTo * shipTo;
  PaymentMethod * paymentMethod;
  NSString * customerName;
  NSString * zipCode;
  NSString * billingAddress;
  NSString * billingName;
  NSString * billingPhone;
  NSString * shipToZip;
  NSString * shipToAddress;
  NSString * shipToName;
  NSString * shipToPhone;
  NSString * shipToCountryCode;
  NSString * emailVerification;
  NSString * customerLastName;
  NSString * shipToLastName;
  NSString * orderNumber;
  NSString * customerServicesPhone;
  NSString * cardToken;
}

@property(nonatomic, retain) NSString * shipToLastName;
@property(nonatomic, retain) NSString * zipCode;
@property(nonatomic, retain) NSString * billingAddress;
@property(nonatomic, retain) NSString * billingName;
@property(nonatomic, retain) NSString * billingPhone;
@property(nonatomic, retain) NSString * shipToZip;
@property(nonatomic, retain) NSString * shipToAddress;
@property(nonatomic, retain) NSString * shipToName;
@property(nonatomic, retain) NSString * shipToPhone;
@property(nonatomic, retain) NSString * shipToCountryCode;
@property(nonatomic, retain) NSString * emailVerification;
@property(nonatomic, retain) NSString * customerId;
@property(nonatomic, retain) NSString * email;
@property(nonatomic, retain) NSString * birthDate;
@property(nonatomic, retain) NSString * shipToSameAsBillTo;
@property(nonatomic, retain) NSString * socialSecurityNumber;
@property(nonatomic, retain) NSString * driversLicense;
@property(nonatomic, retain) NSString * taxId;
@property(nonatomic, retain) BillTo * billTo;
@property(nonatomic, retain) ShipTo * shipTo;
@property(nonatomic, retain) PaymentMethod * paymentMethod;
@property(nonatomic, retain) NSString * customerName;
@property(nonatomic, retain) NSString * customerLastName;
@property(nonatomic, retain) NSString * orderNumber;
@property(nonatomic, retain) NSString * customerServicesPhone;
@property(nonatomic, retain) NSString * cardToken;
- (void) setShipToLastName:(NSString *)shipToLastName;
- (void) setZipCode:(NSString *)zipCode;
- (void) setBillingAddress:(NSString *)billingAddress;
- (void) setBillingName:(NSString *)billingName;
- (void) setBillingPhone:(NSString *)billingPhone;
- (void) setShipToZip:(NSString *)shipToZip;
- (void) setShipToAddress:(NSString *)shipToAddress;
- (void) setShipToName:(NSString *)shipToName;
- (void) setShipToPhone:(NSString *)shipToPhone;
- (void) setShipToCountryCode:(NSString *)shipToCountryCode;
- (void) setEmailVerification:(NSString *)emailVerification;
- (void) setCustomerId:(NSString *)value;
- (void) setEmail:(NSString *)value;
- (void) setBirthDate:(NSString *)value;
- (void) setShipToSameAsBillTo:(NSString *)value;
- (void) setSocialSecurityNumber:(NSString *)value;
- (void) setDriversLicense:(NSString *)value;
- (void) setTaxId:(NSString *)value;
- (void) setBillTo:(BillTo *)value;
- (void) setShipTo:(ShipTo *)value;
- (void) setPaymentMethod:(PaymentMethod *)value;
- (void) setCustomerName:(NSString *)customerName;
- (void) setCustomerLastName:(NSString *)customerLastName;
- (void) setOrderNumber:(NSString *)orderNumber;
- (void) setCustomerServicesPhone:(NSString *)customerServicesPhone;
- (void) setCardToken:(NSString *)cardToken;
@end
