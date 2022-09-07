

#import "SIECordovaModels.h"
#import "SIEFontManager.h"
#import "NSString+IGTool.h"
#import "Colours.h"

 NSString *const SIECordovaImageTypeAppIcon = @"AppIcon";

@implementation SIECordovaTextModel


- (CGFloat)alpha {
    if (_alpha<=0 || _alpha>1) {
        _alpha = 1.0;
    }
    return _alpha;
}

- (NSDictionary<NSAttributedStringKey,id> *)textAttribute {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    NSTextAlignment align;
    if (_align==1) {
        align = NSTextAlignmentRight;
    }
    else if (_align==2) {
        align = NSTextAlignmentCenter;
    } else if (_align==3) {
        align = NSTextAlignmentJustified;
    } else {
        align = NSTextAlignmentLeft;
    }
    paragraphStyle.alignment = align;
    
    UIColor *color;
    if (self.color.length>0) {
        color = [UIColor colorFromHexString:self.color];
    }
    if (!color) {
        color = [UIColor whiteColor];
    }
    
    return @{NSFontAttributeName:[self cdv_font],
             NSForegroundColorAttributeName:color,
             NSParagraphStyleAttributeName:paragraphStyle
             };
}


- (NSInteger)fontSize {
    return self.font<=0 ? 14 : self.font;
}

- (UIFont *)cdv_font {
    NSInteger size = self.fontSize + 20;
    return self.bold==0 ? SIEFontWithSize(size) : [UIFont boldSystemFontOfSize:size];
}


- (CGRect)rectInRect:(CGRect)rect {
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    
    CGFloat x = MAX(0, self.x);
    CGFloat y = MAX(0, self.y);
    CGFloat textX = x;
    CGFloat textY = y;
    
    CGSize size;
    
    if (_centerX || _centerY) {
        size = [self.text ig_sizeWithFont:[self cdv_font] andMaxSize:CGSizeMake(w, MAXFLOAT)];
        if (_centerX) {
            textX = (w-size.width) * 0.5;
        }
        if (_centerY) {
            textY = (h-size.height) * 0.5;
        }
    }
    
    else {
        CGFloat margin = 10;
        size = [self.text ig_sizeWithFont:[self cdv_font] andMaxSize:CGSizeMake(w-x-margin, MAXFLOAT)];
        
        //0:左上角, 1:右上角, 2:右下角, 3左下角
        if (_position==0) {
            
        }
        else if (_position==1) {
            textX = w-x-size.width-margin;
        }
        else if (_position==2) {
            textX = w-x-size.width-margin;
            textY = h-y-size.height;
        }
        else if (_position==3) {
            textY = h-y-size.height;
        }
    }
    
    CGRect textRect = CGRectMake(textX, textY, size.width, size.height);
    return textRect;
}


@end


@implementation SIECordovaImageModel




- (CGFloat)alpha {
    if (_alpha<=0 || _alpha>1) {
        _alpha = 1.0;
    }
    return _alpha;
}


- (NSString *)placeholdImage {
    NSString *pl;
    
    //需要做占位图片使用  就打开注释
    if ([self.type isEqualToString:SIECordovaImageTypeAppIcon]) {
//        pl = SkinConfig.VPImageAppIcon;
        pl = @"新日丰安全卫士";
    }
    
    else {
        pl = @"";
    }
    
    return pl;
}

- (CGRect)rectInRect:(CGRect)rect image:(UIImage *)img {
    
    //处理0值
    if (self.w<=0 || self.h<=0) {
        CGFloat imgW = img.size.width;
        CGFloat imgH = img.size.height;
        CGFloat r = imgH/imgW;
        
        if (_w<=0) {
            if (_h<=0) {
                imgW = MIN(100, imgW);
                _h = imgW * r;
            }
            _w = _h / r;
        }
        
        if (_h<=0) {
            if (_w<=0) {
                imgW = MIN(100, imgW);
                _w = imgW;
            }
            _h = imgW * r;
        }
        
    }
    
    CGRect ori_rect = CGRectMake(MAX(0, self.x), MAX(0, self.y), MAX(0, self.w), MAX(0, self.h));
    
    
    
    //重新计算position
    CGFloat imgX = ori_rect.origin.x;
    CGFloat imgY = ori_rect.origin.y + 30;
    CGFloat imgW = ori_rect.size.width;
    CGFloat imgH = ori_rect.size.height;
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    if (_centerX || _centerY) {
        if (_centerX) {
            imgX = (w-imgW) * 0.5;
        }
        if (_centerY) {
            imgY = (h-imgH) * 0.5;
        }
    }
    else {
        
        //0:左上角, 1:右上角, 2:右下角, 3左下角
        if (_position==0) {
            
        }
        else if (_position==1) {
            imgX = w-imgX-imgW;
        }
        else if (_position==2) {
            imgX = w-imgX-imgW;
            imgY = h-imgY-imgH;
        }
        else if (_position==3) {
            imgY = h-imgY-imgH;
        }
    }
    
    CGRect imgRect = CGRectMake(imgX, imgY, imgW, imgH);
    return imgRect;
}


@end
