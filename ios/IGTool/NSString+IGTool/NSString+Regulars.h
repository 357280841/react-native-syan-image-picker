

#import <Foundation/Foundation.h>

@interface NSString (Regulars)
-(BOOL)ig_isA2Z;
-(BOOL)ig_isNumber;
-(BOOL)ig_isFloatNumber;
-(BOOL)ig_isNumberAndWord;
-(BOOL)ig_isMail;
-(BOOL)ig_isZIP;
-(BOOL)ig_isMobilePhoneNum;
-(BOOL)ig_checkWithRegular:(NSString*)expression;
-(BOOL)ig_checkWithRegulars:(NSArray*)expressions;

@end
