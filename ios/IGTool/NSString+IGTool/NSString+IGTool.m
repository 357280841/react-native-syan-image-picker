

#import "NSString+IGTool.h"

@implementation NSString (IGTool)

+ (NSString *)ig_notNilValue:(NSString *)string
{
    if ([NSString ig_isNilOrEmpty:string]) {
        return @"";
    }
    return string;
}

+ (BOOL)ig_isNilOrEmpty:(NSString *)str{
    if (!str || ![str isKindOfClass:[NSString class]]|| [str ig_isEmpty]) {
        return YES;
    }
    return NO;
}

- (BOOL)ig_isNilOrEmpty{
    return (!self || ![self isKindOfClass:[NSString class]]|| [self ig_isEmpty]);
}


- (NSString *)ig_notNilValue
{
    if (!self ) {
        return @"";
    }
    return self;
}

- (BOOL)ig_isEmpty
{
    return [self ig_isEmptyIgnoringWhitespace:YES];
}

- (BOOL)ig_isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace
{
    NSString *toCheck = (ignoreWhitespace) ? [self ig_stringByTrimmingWhitespace] : self;
    return toCheck.length == 0 ;
}

- (NSString *)ig_stringByTrimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)ig_stringByTrimmingEscapeCharacter
{
    if ([self rangeOfString:@"\\n"].length > 0) {
        return [[self componentsSeparatedByString:@"\\n"] componentsJoinedByString:@"\n"];
    }
    else {
        return self;
    }
}

- (NSString *)ig_stringByTrimmingSymbol {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9]+" options:0 error:nil];
    return [regex stringByReplacingMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) withTemplate:@""];
}

- (NSString *)ig_stringByTrimmingNAN {
    return [self ig_stringByKeepingNumber];
}

- (NSString *)ig_stringByKeepingNumber {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]+" options:0 error:nil];
    return [regex stringByReplacingMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) withTemplate:@""];
}

- (NSString *)ig_stringByKeepingNumberAndDecimal {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9.]+" options:0 error:nil];
    NSString *str = [regex stringByReplacingMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) withTemplate:@""];
    
    // 去除多余的小数点, 只保留第一个
//    if ([str containsString:@"."]) {
//        
//        NSMutableString *newStr = [NSMutableString string];
//        
//        NSArray<NSString *> * array = [str componentsSeparatedByString:@"."];
//        
//        [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            [newStr appendString:obj];
//            if (idx==0) {
//                [newStr appendString:@"."];
//            }
//        }];
//        return newStr;
//    }
    
    
    return str;
}

#pragma mark countWord
- (int)ig_countWord
{
    
    int i, n = (int)[self length], l = 0, a = 0, b = 0;
    
    unichar c;
    
    for(i=0;i<n;i++){
        
        c=[self characterAtIndex:i];
        
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    
    if(a==0 && l==0) return 0;
    
    return l+(int)ceilf((float)(a+b)/2.0);
    
}

#pragma mark -
//计算NSString字节长度,汉字占2个，英文占1个
-  (int)ig_convertToInt:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
    
}

#pragma mark - size
-(CGSize)ig_sizeWithFont:(UIFont*)font andMaxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{
                                        NSFontAttributeName: font
                                        }
                              context:nil].size;
}

@end

@implementation NSMutableString(IGTool)

- (void)ig_trimCharactersInSet:(NSCharacterSet *)aCharacterSet
{
    // trim front
    NSRange frontRange = NSMakeRange(0, 1);
    while ([aCharacterSet characterIsMember:[self characterAtIndex:0]])
        [self deleteCharactersInRange:frontRange];
    
    // trim back
    while ([aCharacterSet characterIsMember:[self characterAtIndex:([self length] - 1)]])
        [self deleteCharactersInRange:NSMakeRange(([self length] - 1), 1)];
}

- (void)ig_trimWhitespace
{
    [self ig_trimCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)ig_trimAllWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end



@implementation NSAttributedString (IGTool)

- (CGSize)ig_sizeWithMaxWidth:(CGFloat)maxWidth{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:options
                                     context:nil];
    return CGSizeMake(ceilf(rect.size.width)+2, ceilf(rect.size.height)+2);
}

- (CGFloat)ig_heightWithMaxWidth:(CGFloat)maxWidth{
    return [self ig_sizeWithMaxWidth:maxWidth].height;
}

- (CGSize)ig_sizeWithMaxHeight:(CGFloat)maxHeight{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
                                     options:options
                                     context:nil];
    return CGSizeMake(ceilf(rect.size.width)+2, ceilf(rect.size.height)+2);

}
- (CGFloat)ig_widthWithMaxHeight:(CGFloat)maxHeight{
    return [self ig_sizeWithMaxHeight:maxHeight].width;
}

@end
