

#import <Foundation/Foundation.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSData.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSError.h>
#import <Foundation/NSString.h>

@interface IGJSONKIt : NSObject

@end

@interface NSString (IGJSONKitDeserializing)
- (id)ig_objectFromJSONString;
- (id)ig_objectFromJSONStringWithError:(NSError**)error;
- (id)ig_mutableObjectFromJSONString;
@end

@interface NSData (IGJSONKitDeserializing)
- (id)ig_objectFromJSONData;
- (id)ig_objectFromJSONDataWithError:(NSError**)error;
- (id)ig_mutableObjectFromJSONData;
@end

@interface NSString (IGJSONKitSerializing)
- (NSData *)ig_JSONData;
- (NSString *)ig_JSONString;
@end

@interface NSArray (IGJSONKitSerializing)
- (NSData *)ig_JSONData;
- (NSData *)ig_JSONDataWithError:(NSError**)error;
- (NSString *)ig_JSONString;
- (NSString *)ig_JSONStringWithError:(NSError**)error;
@end

@interface NSDictionary (IGJSONKitSerializing)
- (NSData *)ig_JSONData;
- (NSData *)ig_JSONDataWithError:(NSError**)error;
- (NSString *)ig_JSONString;
- (NSString *)ig_JSONStringWithError:(NSError**)error;

@end

