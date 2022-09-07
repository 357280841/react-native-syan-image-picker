

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IGSectionData : NSObject

@property (nonatomic,assign) NSInteger section;

@property (nonatomic,assign) CGFloat headHeight;
@property (nonatomic,copy) NSString *headTitle;

@property (nonatomic,assign) CGFloat footHeight;
@property (nonatomic,copy) NSString *footTitle;

@end
