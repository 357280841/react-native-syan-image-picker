

#import "SIEFontManager.h"

@interface SIEFontManager ()

@property (nonatomic,copy) NSString *activeFontName;
@property (nonatomic,copy,readonly) NSString *activeFontNameBlod;
@property (nonatomic,copy,readonly) NSString *activeFontNameItalic;

@property (nonatomic,copy,readonly) NSString *activeIconFontName;

@end

@implementation SIEFontManager

+(instancetype)defaultManager
{
    static id _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SIEFontManager alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
}

- (void)setActiveFontName:(NSString *)activeFontName{
    _activeFontName = activeFontName;
    _activeFontNameBlod = [NSString stringWithFormat:@"%@-blod",activeFontName];
    _activeFontNameItalic = [NSString stringWithFormat:@"%@-italic",activeFontName];
}

- (UIFont*)fontWithSize:(CGFloat)size{
    if (_activeFontName) {
        UIFont *tmp = [UIFont fontWithName:_activeFontName size:size];
        if (tmp) {
            return tmp;
        }
    }
    return [UIFont systemFontOfSize:size];
}

- (UIFont *)boldFontOfSize:(CGFloat)size{
    if (_activeFontNameBlod) {
        UIFont *tmp = [UIFont fontWithName:_activeFontNameBlod size:size];
        if (tmp) {
            return tmp;
        }

        if (_activeFontName) {
            return [self fontWithSize:size];
        }
    }
    return [UIFont boldSystemFontOfSize:size];
}

- (UIFont *)italicFontOfSize:(CGFloat)size {
    if (_activeFontNameItalic) {
        UIFont *tmp = [UIFont fontWithName:_activeFontNameItalic size:size];
        if (tmp) {
            return tmp;
        }
        if (_activeFontName) {
            return [self fontWithSize:size];
        }
    }
    return [UIFont italicSystemFontOfSize:size];
}

- (NSString*)currFontName{
    return _activeFontName?_activeFontName:[UIFont systemFontOfSize:10].fontName;
}
#pragma mark - ----> 字体图标
- (void)loadIconFontWithName:(NSString*)iconFontName{
    _activeIconFontName = iconFontName;
}

- (UIFont*)iconFontWithSize:(CGFloat)size{
    if (_activeIconFontName) {
        return [UIFont fontWithName:_activeIconFontName size:size];
    }else{
        return nil;
    }
}

@end
