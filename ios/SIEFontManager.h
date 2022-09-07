

#import <Foundation/Foundation.h>

#define SIEFont [SIEFontManager defaultManager]

#define SIEFontWithSize(size) [[SIEFontManager defaultManager] fontWithSize:size]

#define SIEIconFontWithSize(size) [[SIEFontManager defaultManager] iconFontWithSize:size]


@interface SIEFontManager : NSObject

+(instancetype)defaultManager;

#pragma mark - ----> 获取字体
- (UIFont*)fontWithSize:(CGFloat)size;
- (UIFont*)boldFontOfSize:(CGFloat)fontSize;
- (UIFont*)italicFontOfSize:(CGFloat)fontSize;

- (NSString*)currFontName;

#pragma mark - ----> 字体图标
- (void)loadIconFontWithName:(NSString*)iconFontName;
- (UIFont*)iconFontWithSize:(CGFloat)size;

@end
