#import <Foundation/Foundation.h>

@interface Location : NSObject {
  NSString * id;
  NSString * fax;
  NSString * phone;
  NSString * city;
  NSString * state;
  NSString * company;
  NSString * country;
  NSString * name;
  NSString * zipCode;
  NSString * street1;
  NSString * street2;
  NSString * street3;
}

@property(nonatomic, retain) NSString * id;
@property(nonatomic, retain) NSString * fax;
@property(nonatomic, retain) NSString * phone;
@property(nonatomic, retain) NSString * city;
@property(nonatomic, retain) NSString * state;
@property(nonatomic, retain) NSString * company;
@property(nonatomic, retain) NSString * country;
@property(nonatomic, retain) NSString * name;
@property(nonatomic, retain) NSString * zipCode;
@property(nonatomic, retain) NSString * street1;
@property(nonatomic, retain) NSString * street2;
@property(nonatomic, retain) NSString * street3;
- (void) setId:(NSString *)value;
- (void) setFax:(NSString *)value;
- (void) setPhone:(NSString *)value;
- (void) setCity:(NSString *)value;
- (void) setState:(NSString *)value;
- (void) setCompany:(NSString *)value;
- (void) setCountry:(NSString *)value;
- (void) setName:(NSString *)value;
- (void) setZipCode:(NSString *)value;
- (void) setStreet1:(NSString *)value;
- (void) setStreet2:(NSString *)value;
- (void) setStreet3:(NSString *)value;
@end
