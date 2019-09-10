#import "ProcessorDetailList.h"

@interface Processor : NSObject {
  NSString * procName;
  NSString * status;
  NSString * settleLevel;
  NSString * component;
  ProcessorDetailList * processorDetailList;
  NSString * componentSttl;
  NSString * statusSttl;
}

@property(nonatomic, retain) NSString * componentSttl;
@property(nonatomic, retain) NSString * statusSttl;
@property(nonatomic, retain) ProcessorDetailList * processorDetailList;
@property(nonatomic, retain) NSString * procName;
@property(nonatomic, retain) NSString * status;
@property(nonatomic, retain) NSString * settleLevel;
@property(nonatomic, retain) NSString * component;
- (void) setComponentSttl:(NSString *)componentSttl;
- (void) setStatusSttl:(NSString *)statusSttl;
- (void) setProcessorDetailList:(ProcessorDetailList *)processorDetailList;
- (void) setProcName:(NSString *)procName;
- (void) setStatus:(NSString *)status;
- (void) setSettleLevel:(NSString *)settleLevel;
- (void) setComponent:(NSString *)component;
@end
