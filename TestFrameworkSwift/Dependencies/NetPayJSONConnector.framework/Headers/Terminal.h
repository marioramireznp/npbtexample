@interface Terminal : NSObject {
  NSString * terminalId;
  NSString * description;
  NSString * status;
  NSString * IPAddress;
  NSNumber * storeId;
  NSString * terminalTypeId;
}

@property(nonatomic, retain) NSString * terminalId;
@property(nonatomic, retain) NSString * description;
@property(nonatomic, retain) NSString * status;
@property(nonatomic, retain) NSString * iPAddress;
@property(nonatomic, retain) NSNumber * storeId;
@property(nonatomic, retain) NSString * terminalTypeId;
- (void) setTerminalId:(NSString *)terminalId;
- (void) setDescription:(NSString *)description;
- (void) setStatus:(NSString *)status;
- (void) setIPAddress:(NSString *)IPAddress;
- (void) setStoreId:(NSNumber *)storeId;
- (void) setTerminalTypeId:(NSString *)terminalTypeId;
@end
