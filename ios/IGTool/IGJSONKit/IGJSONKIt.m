

#import "IGJSONKIt.h"

@implementation IGJSONKIt

@end


@implementation NSString (IGJSONKitDeserializing)
- (id)ig_objectFromJSONString{
    NSError *error = nil;
    return [self ig_objectFromJSONStringWithError:&error];
}

- (id)ig_objectFromJSONStringWithError:(NSError**)error{
    id obj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:error];
    if (*error) {
        if ([*error userInfo] &&
            [*error userInfo][@"NSDebugDescription"] &&
            [(NSString*)[*error userInfo][@"NSDebugDescription"] hasPrefix:@"Unescaped control character"]) {
            obj = [self tryFixUnescapedControlCharacter];
            if (obj) {
                return obj;
            }
        }
        NSLog(@"string [%@] trans to JSONObject Failed: %@",self,*error);
    }else{
        return obj;
    }
    return nil;
}

- (id)tryFixUnescapedControlCharacter{
    id obj = nil;
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    if (![self isEqualToString:string]) {
        obj = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        if (obj) {
            return obj;
        }
    }
    return nil;
}

- (id)ig_mutableObjectFromJSONString{
    NSError *error = nil;
    // NSJSONSerialization 返回的obj全部系可变的
    return [self ig_objectFromJSONStringWithError:&error];
}

@end

@implementation NSData (IGJSONKitDeserializing)
- (id)ig_objectFromJSONData{
    NSError *error = nil;
    return [self ig_objectFromJSONDataWithError:&error];
}
- (id)ig_objectFromJSONDataWithError:(NSError**)error{
    id obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:error];
    if (*error) {
        NSLog(@"data [%@] trans to JSONObject Failed: %@",self,*error);
    }else{
        return obj;
    }
    return nil;
}
- (id)ig_mutableObjectFromJSONData{
    NSError *error = nil;
    return [self ig_objectFromJSONDataWithError:&error];
}

@end


@implementation NSString (IGJSONKitSerializing)
- (NSData *)ig_JSONData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
- (NSString *)ig_JSONString{
    return self;
}
@end

@implementation NSArray (IGJSONKitSerializing)
- (NSData *)ig_JSONData{
    NSError *error = nil;
    return [self ig_JSONDataWithError:&error];
}
- (NSData *)ig_JSONDataWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"array [%@] trans to JSONData failed : %@",self,*error);
        }else{
            return jsonData;
        }
    }else{
        NSLog(@"array [%@] trans to JSONData failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;

}
- (NSString *)ig_JSONString{
    NSError *error = nil;
    return [self ig_JSONStringWithError:&error];
}
- (NSString *)ig_JSONStringWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"array [%@] trans to JSONString failed : %@",self,*error);
        }else{
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }else{
        NSLog(@"array [%@] trans to JSONString failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;
}
@end

@implementation NSDictionary (IGJSONKitSerializing)
- (NSData *)ig_JSONData{
    NSError *error = nil;
    return [self ig_JSONDataWithError:&error];
}
- (NSData *)ig_JSONDataWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"dict [%@] trans to JSONData failed : %@",self,*error);
        }else{
            return jsonData;
        }
    }else{
        NSLog(@"dict [%@] trans to JSONData failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;
    
}
- (NSString *)ig_JSONString{
    NSError *error = nil;
    return [self ig_JSONStringWithError:&error];
}
- (NSString *)ig_JSONStringWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"dict [%@] trans to JSONString failed : %@",self,*error);
        }else{
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }else{
        NSLog(@"dict [%@] trans to JSONString failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;
}

@end
