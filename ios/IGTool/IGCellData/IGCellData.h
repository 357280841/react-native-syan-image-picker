

#import <UIKit/UIKit.h>

typedef void(^IGCellDataActionBlock)();

@interface IGCellData : NSObject
@property (nonatomic,assign) NSInteger      type;
@property (nonatomic,strong) UIImage  *icon;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,strong) NSObject *value;
@property (nonatomic,copy) NSString *desc;

@property (nonatomic,strong) id extraObj;

@property (nonatomic,copy) IGCellDataActionBlock actionBlock;



+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle;
+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle vaule:(NSObject*)avalue;

+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle subTitle:(NSString*)asubtitle;
+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle subTitle:(NSString*)asubtitle vaule:(NSObject*)avalue;

+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle icon:(UIImage*)aicon;
+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle icon:(UIImage*)aicon vaule:(NSObject*)avalue;

+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle icon:(UIImage*)aicon subTitle:(NSString*)asubtitle;
+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle icon:(UIImage*)aicon subTitle:(NSString*)asubtitle vaule:(NSObject*)avalue;

+(instancetype)dataWithType:(NSInteger)type andTitle:(NSString*)atitle icon:(UIImage*)aicon subTitle:(NSString*)asubtitle desc:(NSString*)aDesc vaule:(NSObject*)avalue;

@end
