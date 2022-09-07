

#import <UIKit/UIKit.h>
#import "NSString+Regulars.h"       // 正则表达式验证相关


// Number转字符串
#define IGStringFromInteger(aInteger)     [NSString stringWithFormat:@"%i",aInteger]
#define IGStringFromLongLong(aLong)     [NSString stringWithFormat:@"%lli",aLong]
#define IGStringFromFloat(aFloat)     [NSString stringWithFormat:@"%.2f",aFloat]


@interface NSString (IGTool)

+ (BOOL)ig_isNilOrEmpty:(NSString *)str;
- (BOOL)ig_isEmpty;
- (BOOL)ig_isNilOrEmpty;
- (BOOL)ig_isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace;

+ (NSString *)ig_notNilValue:(NSString *)string;
- (NSString *)ig_stringByTrimmingWhitespace;
- (NSString *)ig_stringByTrimmingEscapeCharacter;
- (NSString *)ig_notNilValue;

//吴波
- (NSString *)ig_stringByTrimmingSymbol; //保留数字和字母
- (NSString *)ig_stringByTrimmingNAN;  // 去除非数字, (只保留数字)
- (NSString *)ig_stringByKeepingNumber;// 保留数字
- (NSString *)ig_stringByKeepingNumberAndDecimal; // 保留数字和小数点

#pragma mark - countWord
- (int)ig_countWord;
- (int)ig_convertToInt:(NSString*)strtemp;

#pragma mark - size
-(CGSize)ig_sizeWithFont:(UIFont*)font andMaxSize:(CGSize)maxSize;

@end

@interface NSMutableString(IGTool)

- (void)ig_trimCharactersInSet:(NSCharacterSet *)aCharacterSet;
- (void)ig_trimWhitespace;
- (NSString *)ig_trimAllWhitespace;

@end


@interface NSAttributedString (IGTool)

- (CGSize)ig_sizeWithMaxWidth:(CGFloat)maxWidth;
- (CGFloat)ig_heightWithMaxWidth:(CGFloat)maxWidth;

- (CGSize)ig_sizeWithMaxHeight:(CGFloat)maxHeight;
- (CGFloat)ig_widthWithMaxHeight:(CGFloat)maxHeight;


@end
