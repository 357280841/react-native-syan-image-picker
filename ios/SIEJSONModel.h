

#import "Mantle.h"

@interface SIEJSONModel : MTLModel<MTLJSONSerializing>

- (id)transModelToDictionary;

- (NSDictionary*)toNonullDictionary;

@end
