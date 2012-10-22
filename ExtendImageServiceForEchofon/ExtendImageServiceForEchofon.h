//
//  ExtendImageServiceForEchofon.h
//  ExtendImageServiceForEchofon
//

#import <Foundation/Foundation.h>
@interface ExtendImageServiceForEchofon : NSObject
{
    NSString *string;
}
@property (nonatomic,strong)NSString *string;
-(void)testMethod;
+(NSString *)getImageURLbyloadJson:(NSString *)id;
+(NSString *)getThumbImageURLbyloadJson:(NSString *)id;
@end
