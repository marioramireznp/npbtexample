//
//  List.h
//  demoAlsea
//
//  Created by Zeferino Alberto Casanova on 20/09/12.
//  Copyright (c) 2012 NetPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface List : NSObject{
    NSString *name;
}

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) NSMutableDictionary *pdict;

- (id) initWithName: (NSString *)name;

- (void)copyFileToDocumentDirectory;

- (void)readPlist;

- (void)writePlist;

- (void)removePlist:(NSString *)plist;

@end
