#import "CardType.h"

@interface CreditCard : NSObject {  
  NSString * cardNumber;
  NSString * spanRoute;
  NSString * expDate;
  NSString * track2;
  NSString * pinBlock;
  NSString * cvv2;
  NSNumber * cardType;
  NSString * EMVTags;
  NSString * cardTypeName;
  NSString * track1;
  NSString * EMVTagsEncType;
  NSString * cardNature;
  NSNumber * bankId;
  NSString * tokens;
  NSString * Cvv2Indicator;
}

@property(nonatomic, retain) NSString * cardNumber;
@property(nonatomic, retain) NSString * expDate;
@property(nonatomic, retain) NSString * track2;
@property(nonatomic, retain) NSString * pinBlock;
@property(nonatomic, retain) NSString * cVV2;
@property(nonatomic, retain) NSNumber * cardType;
@property(nonatomic, retain) NSString * eMVTags;
@property(nonatomic, retain) NSString * spanRoute;
@property(nonatomic, retain) NSString * cardTypeName;
@property(nonatomic, retain) NSString * track1;
@property(nonatomic, retain) NSString * eMVTagsEncType;
@property(nonatomic, retain) NSString * cardNature;
@property(nonatomic, retain) NSNumber * bankId;
@property(nonatomic, retain) NSString * tokens;
@property(nonatomic, retain) NSString * cvv2Indicator;
- (void) setCardNumber:(NSString *)value;
- (void) setExpDate:(NSString *)value;
- (void) setTrack2:(NSString *)value;
- (void) setPinBlock:(NSString *)value;
- (void) setCVV2:(NSString *)value;
- (void) setCardType:(NSNumber *)cardType;
- (void) setSpanRoute:(NSString *)spanRoute;
- (void) setEMVTags:(NSString *)eMVTags;
- (void) setCardTypeName:(NSString *)cardTypeName;
- (void) setTrack1:(NSString *)track1;
- (void) setEMVTagsEncType:(NSString *)tagsEncType;
- (void) setCardNature:(NSString *)cardNature;
- (void) setBankId:(NSNumber *)bankId;
- (void) setTokens:(NSString *)tokens;
- (void) setCvv2Indicator:(NSString *)cvv2Indicator;
@end
