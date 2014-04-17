//
//  URDAAPDecoder.m
//  DAAPDecoder
//
//  Created by Rick on 2014-04-17.
//  Copyright (c) 2014 Rick. All rights reserved.
//

#import "URDAAPDecoder.h"

@interface URDAAPDecoder()

@property (nonatomic) int offset;

@property (nonatomic, retain) NSDictionary *dispatcher;

@end

typedef NS_ENUM(NSInteger, DispatchType){
    DispatchTypeList = 1,
    DispatchTypeInt  = 2,
    DispatchTypeString = 3,
    DispatchTypeByte  = 4,
    DispatchTypeLong = 5,
    DispatchTypeVersion = 6,
    DispatchTypeShort = 7,
    DispatchTypeDate = 8,
};

static const NSString * serverURL = @"http://192.168.1.153:3689";

@implementation URDAAPDecoder

-(id)init{
    self = [super init];
    if (self) {
        self.dispatcher = @{@"mdcl" : [NSNumber numberWithInt:DispatchTypeList],
                            @"mstt" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"miid" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"minm" : [NSNumber numberWithInt:DispatchTypeString],
                            @"mikd" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"mper" : [NSNumber numberWithInt:DispatchTypeLong],
                            @"mcon" : [NSNumber numberWithInt:DispatchTypeList],
                            @"mcti" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"mpco" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"msts" : [NSNumber numberWithInt:DispatchTypeString],
                            @"mimc" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"mrco" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"mtco" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"mlcl" : [NSNumber numberWithInt:DispatchTypeList],
                            @"mlit" : [NSNumber numberWithInt:DispatchTypeList],
                            @"mbcl" : [NSNumber numberWithInt:DispatchTypeList],
                            @"mdcl" : [NSNumber numberWithInt:DispatchTypeList],
                            @"msrv" : [NSNumber numberWithInt:DispatchTypeList],
                            @"msaud" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"mslr" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"mpro" : [NSNumber numberWithInt:DispatchTypeVersion],
                            @"apro" : [NSNumber numberWithInt:DispatchTypeVersion],
                            @"msal" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"msup" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"mspi" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"msex" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"msbr" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"msqy" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"msix" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"msrs" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"mstm" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"msdc" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"mccr" : [NSNumber numberWithInt:DispatchTypeList],
                            @"mcnm" : [NSNumber numberWithInt:DispatchTypeString],
                            @"mcna" : [NSNumber numberWithInt:DispatchTypeString],
                            @"mcty" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"mlog" : [NSNumber numberWithInt:DispatchTypeList],
                            @"mlid" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"mupd" : [NSNumber numberWithInt:DispatchTypeList],
                            @"msur" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"muty" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"mudl" : [NSNumber numberWithInt:DispatchTypeList],
                            @"avdb" : [NSNumber numberWithInt:DispatchTypeList],
                            @"abro" : [NSNumber numberWithInt:DispatchTypeList],
                            @"abal" : [NSNumber numberWithInt:DispatchTypeList],
                            @"abar" : [NSNumber numberWithInt:DispatchTypeList],
                            @"abcp" : [NSNumber numberWithInt:DispatchTypeList],
                            @"abgn" : [NSNumber numberWithInt:DispatchTypeList],
                            @"adbs" : [NSNumber numberWithInt:DispatchTypeList],
                            @"asal" : [NSNumber numberWithInt:DispatchTypeString],
                            @"asar" : [NSNumber numberWithInt:DispatchTypeString],
                            @"asbt" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"asbr" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"ascm" : [NSNumber numberWithInt:DispatchTypeString],
                            @"asco" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"asda" : [NSNumber numberWithInt:DispatchTypeDate],
                            @"asdm" : [NSNumber numberWithInt:DispatchTypeDate],
                            @"asdc" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"asdn" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"asdb" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"aseq" : [NSNumber numberWithInt:DispatchTypeString],
                            @"asfm" : [NSNumber numberWithInt:DispatchTypeString],
                            @"asgn" : [NSNumber numberWithInt:DispatchTypeString],
                            @"asdt" : [NSNumber numberWithInt:DispatchTypeString],
                            @"asrv" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"assr" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"assz" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"asst" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"assp" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"astm" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"astc" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"astn" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"asur" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"asyr" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"asdk" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"asul" : [NSNumber numberWithInt:DispatchTypeString],
                            @"aply" : [NSNumber numberWithInt:DispatchTypeList],
                            @"abpl" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"apso" : [NSNumber numberWithInt:DispatchTypeList],
                            @"prsv" : [NSNumber numberWithInt:DispatchTypeList],
                            @"arif" : [NSNumber numberWithInt:DispatchTypeList],
                            @"aeNV" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"aeSP" : [NSNumber numberWithInt:DispatchTypeByte],
                            @"aeSV" : [NSNumber numberWithInt:DispatchTypeInt],
                            @"ated" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"asgr" : [NSNumber numberWithInt:DispatchTypeShort],
                            @"msml" : [NSNumber numberWithInt:DispatchTypeString],
                            @"mstc" : [NSNumber numberWithInt:DispatchTypeDate],
                            @"msas" : [NSNumber numberWithInt:DispatchTypeInt],
                            
                            };
        NSMutableURLRequest *serverInfoReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[serverURL stringByAppendingString:@"/content-codes"]]];
        [serverInfoReq setValue:@"1" forHTTPHeaderField:@"Viewer-Only-Client"];
        NSURLResponse *resp;
        NSError *err;
        NSData *data = [NSURLConnection sendSynchronousRequest:serverInfoReq returningResponse:&resp error:&err];
        if (err) {
            NSLog(@"%@", err);
        }
        if (data) {
            NSMutableString *output = [NSMutableString new];
            [output appendString:@"\n"];
            NSMutableString *append = [NSMutableString new];
            [self dispatcher:data output:output append:append];
            NSLog(@"%@", output);
        }

    }
    return self;
}

/**Handles the parsing of data. Output is a mutable string to which the result of the parsing is appended. Append is a set of characters that should be appended at the beginning of each line (Such as tabs for indentation).
 */
-(void)dispatcher:(NSData *)data output:(NSMutableString *) output append:(NSMutableString *) append{
    NSString *tag = [self readTag:data];
    [output appendString:append];
    [output appendFormat:@"%@ : ", tag];
    DispatchType dispatch = [[self.dispatcher objectForKey:tag] integerValue];
    switch (dispatch) {
        case DispatchTypeInt:{
            //Do this one extra time since they actually send the length of an int...
            [self handleInt:data];
            int integer = [self handleInt:data];
            [output appendFormat:@"%d", integer];
            break;
        }
        case DispatchTypeList:
            [output appendString:@"\n"];
            [append appendString:@"\t"];
            [self handleList:data output:output append:append];
            [append deleteCharactersInRange:NSMakeRange(append.length - 1, 1)];
            break;
        case DispatchTypeVersion:{
            [self handleInt:data]; //Throw away length
            int version = [self handleInt:data];
            [output appendFormat:@"%d", version];
            break;
        }
        case DispatchTypeString:{
            int length = [self handleInt:data];
            NSString *string = [self handleString:data ofLength:length];
            [output appendFormat:@"%@", string];
            break;
        }
        case DispatchTypeByte:{
            int length = [self handleInt:data];
            char byte = [self handleByte:data];
            [output appendFormat:@"%d", byte];
            break;
        }
        case DispatchTypeLong:{
            NSLog(@"Can not handle long at the moment.");
            break;
        }
        case DispatchTypeDate:{
            NSLog(@"Can not handle dates at the moment.");
            break;
        }
        case DispatchTypeShort:{
            int length = [self handleInt:data];
            short s = [self handleShort:data];
            [output appendFormat:@"%d", s];
            break;
        }
        default:{
            int length = [self handleInt:data];
            NSLog(@"Unknown type: %@ Skipping %d bytes", tag, length);
            self.offset += length;
            break;
        }
    }
    [output appendString:@"\n"];
}

-(void)handleList:(NSData*)data output:(NSMutableString *)output append:(NSMutableString *)append{
    NSUInteger length = [self handleInt:data];
    NSUInteger startOffset = self.offset;
    while (self.offset < startOffset + length){
        [self dispatcher:data output:output append:append];
    }
}

-(short)handleShort:(NSData *)data{
    short s;
    [data getBytes:&s range:NSMakeRange(self.offset, 2)];
    self.offset += 2;
    return CFSwapInt16BigToHost(s);
}

-(char)handleByte:(NSData *)data{
    char c;
    [data getBytes:&c range:NSMakeRange(self.offset, 1)];
    self.offset++;
    return c;
}

-(NSString *)handleString:(NSData *)data ofLength:(NSUInteger) length{
    NSUInteger startOffset = self.offset;
    NSMutableString *output = [NSMutableString new];
    while (self.offset < startOffset + length) {
        [output appendFormat:@"%c", [self handleByte:data]];
    }
    return [NSString stringWithString:output];
}

-(int)handleInt:(NSData *)data{
    int length;
    [data getBytes:&length range:NSMakeRange(self.offset, 4)];
    self.offset+=4;
    return CFSwapInt32BigToHost(length);
}

-(NSString *)readTag:(NSData*)data{
    return [self handleString:data ofLength:4];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Error %@", error);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"Got some data");
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Got resp: %@", response);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Loaded");
}


@end
