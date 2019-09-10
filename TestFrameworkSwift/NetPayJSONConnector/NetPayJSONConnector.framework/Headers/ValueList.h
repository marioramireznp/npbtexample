@interface ValueList : NSObject {
  NSMutableArray * value;
}

@property(nonatomic, retain, readonly) NSMutableArray * value;
@end
