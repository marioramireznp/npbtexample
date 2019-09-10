#import "User.h"
#import "Store.h"
#import "Role.h"
#import "Zone.h"
#import "Terminal.h"
#import "Product.h"
#import "FraudRule.h"
#import "FraudRuleList.h"
#import "StoreProcParams.h"
#import "Encryption.h"
#import "Currency.h"
#import "CardType.h"
#import "Processor.h"
#import "CategoryList.h"
#import "SecurityParameter.h"
#import "KeyGenerate.h"
#import "Service.h"
#import "ConsCenter.h"
#import "Package.h"

@interface Config : NSObject {
  User * user;
  Store * store;
  Role * role;
  Zone * zone;
  Terminal * terminal;
  Product * product;
  FraudRule * fraudRule;
  FraudRuleList * fraudRuleList;
  StoreProcParams * storeProcParams;
  Encryption * encryption;
  Currency * currency;
  CardType * cardType;
  Processor * processor;
  CategoryList * categoryList;
  SecurityParameter * securityParameters;
  KeyGenerate * keyGenerate;
  Service * service;
  ConsCenter * consumptionCenter;
  Package * packages;}

@property(nonatomic, retain) Encryption * encryption;
@property(nonatomic, retain) Currency * currency;
@property(nonatomic, retain) User * user;
@property(nonatomic, retain) Store * store;
@property(nonatomic, retain) Role * role;
@property(nonatomic, retain) Zone * zone;
@property(nonatomic, retain) Terminal * terminal;
@property(nonatomic, retain) Product * product;
@property(nonatomic, retain) FraudRule * fraudRule;
@property(nonatomic, retain) FraudRuleList * fraudRuleList;
@property(nonatomic, retain) StoreProcParams * storeProcParams;
@property(nonatomic, retain) CardType * cardType;
@property(nonatomic, retain) CategoryList * categoryList;
@property(nonatomic, retain) Processor * processor;
@property(nonatomic, retain) SecurityParameter * securityParameters;
@property(nonatomic, retain) KeyGenerate * keyGenerate;
@property(nonatomic, retain) Service * service;
@property(nonatomic, retain) ConsCenter * consumptionCenter;
@property(nonatomic, retain) Package * package;
- (void) setEncryption:(Encryption *)encryption;
- (void) setCurrency:(Currency *)currency;
- (void) setUser:(User *)value;
- (void) setStore:(Store *)value;
- (void) setRole:(Role *)value;
- (void) setZone:(Zone *)value;
- (void) setTerminal:(Terminal *)value;
- (void) setProduct:(Product *)value;
- (void) setFraudRule:(FraudRule *)value;
- (void) setFraudRuleList:(FraudRuleList *)fraudRuleList;
- (void) setStoreProcParams:(StoreProcParams *)storeProcParams;
- (void) setCardType:(CardType *)cardType;
- (void) setCategoryList:(CategoryList *)categoryList;
- (void) setProcessor:(Processor *)processor;
- (void) setSecurityParameters:(SecurityParameter *)securityParameters;
- (void) setKeyGenerate:(KeyGenerate *)keyGenerate;
- (void) setService:(Service *)service;
- (void) setConsumptionCenter:(ConsCenter *)consumptionCenter;
- (void) setPackage:(Package *)packages;
@end
