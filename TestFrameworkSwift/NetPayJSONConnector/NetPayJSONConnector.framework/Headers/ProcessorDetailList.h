@interface ProcessorDetailList : NSObject {
  NSMutableArray * procParam;
  NSMutableArray * procCardType;
}

@property(nonatomic, retain, readonly) NSMutableArray * procParam;
@property(nonatomic, retain, readonly) NSMutableArray * procCardType;
@end
