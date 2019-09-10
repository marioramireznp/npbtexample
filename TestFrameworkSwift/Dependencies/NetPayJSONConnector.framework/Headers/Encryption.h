@interface Encryption : NSObject {
  NSString * keyHolder;
  NSString * firstComponent;
  NSString * secondComponent;
  NSString * thirdComponent;
  NSString * fourthComponent;
}

@property(nonatomic, retain) NSString * fourthComponent;
@property(nonatomic, retain) NSString * keyHolder;
@property(nonatomic, retain) NSString * firstComponent;
@property(nonatomic, retain) NSString * secondComponent;
@property(nonatomic, retain) NSString * thirdComponent;
- (void) setFourthComponent:(NSString *)fourthComponent;
- (void) setKeyHolder:(NSString *)keyHolder;
- (void) setFirstComponent:(NSString *)firstComponent;
- (void) setSecondComponent:(NSString *)secondComponent;
- (void) setThirdComponent:(NSString *)thirdComponent;
@end
