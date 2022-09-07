

#import "NSString+Regulars.h"

@implementation NSString (Regulars)
#pragma mark - 正则表达式

static NSString *ig_regA2Z = @"^[a-z]?$";
// 数字部分
static NSString *ig_regNumber        = @"^[0-9]+$";
static NSString *ig_regFloatNumber   = @"^\\d+.?\\d{0,6}$";
static NSString *ig_regNumberAndWord = @"^[0-9_a-zA-Z]*$";

// 常见格式
static NSString *ig_regMail = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}?$";
static NSString *ig_regZIP  = @"^[1-9]\\d{5}$";
// 手机号
static NSString *ig_regMOBILE = @"^(86){0,1}1[3-8]\\d{9}$";
static NSString *ig_regCM     = @"^(86){0,1}1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
static NSString *ig_regCU     = @"^(86){0,1}1(3[0-2]|5[256]|8[56])\\d{8}$";
static NSString *ig_regCT     = @"^(86){0,1}1((33|53|8[09])[0-9]|349)\\d{7}$";
// NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";

#pragma mark - 分发
-(BOOL)ig_isA2Z{
    return [self ig_checkWithRegular:ig_regA2Z];
}
-(BOOL)ig_isNumber{
    return [self ig_checkWithRegular:ig_regNumber];
}
-(BOOL)ig_isFloatNumber{
    return [self ig_checkWithRegular:ig_regFloatNumber];
}
-(BOOL)ig_isNumberAndWord{
    return [self ig_checkWithRegular:ig_regNumberAndWord];
}

-(BOOL)ig_isMail{
    return [self ig_checkWithRegular:ig_regMail];
}

-(BOOL)ig_isZIP{
    return [self ig_checkWithRegular:ig_regZIP];
}

-(BOOL)ig_isMobilePhoneNum{
    return [self ig_checkWithRegular:ig_regMOBILE];
}

#pragma mark - 判断部分
-(BOOL)ig_checkWithRegular:(NSString*)expression{
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
    return [regextest evaluateWithObject:self];
}

-(BOOL)ig_checkWithRegulars:(NSArray*)expressions{
    BOOL res = NO;
    if (expressions && [expressions isKindOfClass:[NSArray class]]) {
        for (NSString *expression in expressions) {
            if ([expressions isKindOfClass:[NSString class]]) {
                NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
                res = [regextest evaluateWithObject:self];
            }
            if (!res) {
                return NO;
            }
        }
    }
    return YES;
}
@end
