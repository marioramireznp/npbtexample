@interface Category : NSObject {
  NSString * id;
  NSString * categoryDesc;
}

@property(nonatomic, retain) NSString * id;
@property(nonatomic, retain) NSString * categoryDesc;
- (void) setId:(NSString *)id;
- (void) setCategoryDesc:(NSString *)categoryDesc;
@end
