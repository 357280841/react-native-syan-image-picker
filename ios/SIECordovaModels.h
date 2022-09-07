
#import <UIKit/UIKit.h>
#import "SIEJSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIECordovaTextModel : SIEJSONModel

//@property (nonatomic, copy)NSString *point;  //替换为xy, 方便安卓实现
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *color;
@property (nonatomic, assign)NSInteger font;
@property (nonatomic, assign)NSInteger bold;
@property (nonatomic, assign)NSInteger align; //文字对齐 0:左对齐, 1:右对齐, 2:居中对齐, 3:两端对齐
@property (nonatomic, assign)CGFloat alpha; //透明度, 默认1

@property (nonatomic, assign)NSInteger position;//坐标原点,0:左上角, 1:右上角, 2:右下角, 3左下角
@property (nonatomic, assign)NSInteger centerX; //x坐标, 0:不居中, 1:居中, 优先于position
@property (nonatomic, assign)NSInteger centerY; //y坐标, 0:不居中, 1:居中, 优先于position

@property (nonatomic, assign)NSInteger x;
@property (nonatomic, assign)NSInteger y;

- (NSInteger)fontSize;

/** 根据模型创建的label */
//- (UILabel *)label;

- (NSDictionary<NSAttributedStringKey, id> *)textAttribute;

- (CGRect)rectInRect:(CGRect)rect;

@end


UIKIT_EXTERN NSString *const SIECordovaImageTypeAppIcon;


@interface SIECordovaImageModel : SIEJSONModel

//@property (nonatomic, copy)NSString *rect;  //替换为xywh, 方便安卓实现

@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *type; //默认为SIECordovaImageTypeAppIcon
@property (nonatomic, assign)CGFloat alpha; //透明度, 默认1

@property (nonatomic, assign)NSInteger position;//坐标原点, 0:左上角, 1:右上角, 2:右下角, 3左下角
@property (nonatomic, assign)NSInteger centerX; //x坐标, 0:不居中, 1:居中, 优先于position
@property (nonatomic, assign)NSInteger centerY; //y坐标, 0:不居中, 1:居中, 优先于position

@property (nonatomic, assign)NSInteger x;
@property (nonatomic, assign)NSInteger y;
@property (nonatomic, assign)NSInteger w;
@property (nonatomic, assign)NSInteger h;

//通过下载器下载获得
@property (nonatomic, strong)UIImage *image;
//下载图片错误信息
@property (nonatomic, copy)NSString *errMsg;

- (NSString *)placeholdImage;
- (CGRect)rectInRect:(CGRect)rect image:(UIImage *)img;

@end


NS_ASSUME_NONNULL_END
