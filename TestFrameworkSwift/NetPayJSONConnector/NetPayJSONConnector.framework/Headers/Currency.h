@interface Currency : NSObject {
  NSString * currencyCD;
  NSString * currencyAlpha;
  NSString * cntryName;
  NSString * currencyUnit;
  NSString * currencySymbol;
  NSString * currencySubDivision;
}

@property(nonatomic, retain) NSString * currencyCD;
@property(nonatomic, retain) NSString * currencyAlpha;
@property(nonatomic, retain) NSString * cntryName;
@property(nonatomic, retain) NSString * currencyUnit;
@property(nonatomic, retain) NSString * currencySymbol;
@property(nonatomic, retain) NSString * currencySubDivision;
- (void) setCurrencyCD:(NSString *)currencyCD;
- (void) setCurrencyAlpha:(NSString *)currencyAlpha;
- (void) setCntryName:(NSString *)cntryName;
- (void) setCurrencyUnit:(NSString *)currencyUnit;
- (void) setCurrencySymbol:(NSString *)currencySymbol;
- (void) setCurrencySubDivision:(NSString *)currencySubDivision;
@end
