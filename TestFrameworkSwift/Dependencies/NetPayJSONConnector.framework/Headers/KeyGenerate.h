@interface KeyGenerate : NSObject {
  NSString * key1;
  NSString * key2;
  NSString * key3;
}

@property(nonatomic, retain) NSString * key1;
@property(nonatomic, retain) NSString * key2;
@property(nonatomic, retain) NSString * key3;
- (void) setKey1:(NSString *)key1;
- (void) setKey2:(NSString *)key2;
- (void) setKey3:(NSString *)key3;
@end
