@interface PackageList : NSObject {
  NSMutableArray * packages;
}

@property(nonatomic, retain, readonly) NSMutableArray * packages;
@end
