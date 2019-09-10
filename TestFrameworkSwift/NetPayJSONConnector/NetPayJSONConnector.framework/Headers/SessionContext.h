@interface SessionContext : NSObject {
  NSMutableDictionary * attributes;
}

@property(nonatomic, retain) NSMutableDictionary * attributes;
- (id) init;
- (void) setAttributes:(NSMutableDictionary *)attributes;
- (void) setAttribute:(NSString *)name value:(NSObject *)value;
- (NSObject *) getAttribute:(NSString *)keyName;
@end
