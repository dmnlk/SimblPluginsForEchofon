//
//  ExtendImageServiceForEchofon.m
//  ExtendImageServiceForEchofon
//

#import <objc/runtime.h>
#import "EchofonProtocols.h"
#import "ExtendImageServiceForEchofon.h"
#import "SBJson.h"

@implementation NSObject(ExtendImageServiceForEchofon)

- (BOOL)__isImageURL
{
    BOOL result = [self __isImageURL];
    if (!result) {
        NSURL *url = [NSURL URLWithString:(NSString*)self];
        NSString<EchofonNSString>* lastPathComponent = (NSString<EchofonNSString>*)url.lastPathComponent;
        if ([url.host hasSuffix:@"p.twipple.jp"] && [lastPathComponent isAlphaNumOnly]) {
            result = YES;
        } else if ([url.host hasSuffix:@"viddy.com"] && [url.path hasPrefix:@"/video/"]) {
            result = YES;
        } else if ([url.host hasSuffix:@"yfrog.us"] && [lastPathComponent isAlphaNumOnly]) {
            result = YES;
        } else if ([url.host hasSuffix:@"campl.us"] && [lastPathComponent isAlphaNumOnly]) {
            result = YES;
        } else if ([url.host hasSuffix:@"ow.ly"] && [url.path hasPrefix:@"/i/"]) {
            result = YES;
        } else if ([url.host hasSuffix:@"miil.me"] && [url.path hasPrefix:@"/p/"]) {
            result = YES;
        } else if([url.host hasSuffix:@"via.me"]){
            result = YES;
        } else if([url.host hasSuffix:@"gyazo.com"] && [lastPathComponent isAlphaNumOnly]){
            result = YES;
        }
    }
    
    return result;
}
             
- (BOOL)__isVideoURL
{
    BOOL result = [self __isVideoURL];
    if (!result) {
        NSURL *url = [NSURL URLWithString:(NSString*)self];
        if ([url.host hasSuffix:@"viddy.com"] && [url.path hasPrefix:@"/video/"]) {
            result = YES;
        }
    }
    return result;
}
-(void)testMethod
{
    
}
- (NSString*)__getImageURL
{
    [self testMethod];
    NSString* result = [self __getImageURL];
    if (!result) {
        NSURL *url = [NSURL URLWithString:(NSString*)self];
        NSString<EchofonNSString>* lastPathComponent = (NSString<EchofonNSString>*)url.lastPathComponent;
        if ([url.host hasSuffix:@"p.twipple.jp"] && [lastPathComponent isAlphaNumOnly]) {
            result = [NSString stringWithFormat:@"http://p.twipple.jp/show/large/%@", lastPathComponent];
        } else if ([url.host hasSuffix:@"yfrog.us"] && [lastPathComponent isAlphaNumOnly]) {
            result = [NSString stringWithFormat:@"http://yfrog.com/%@:iphone", lastPathComponent];
        } else if ([url.host hasSuffix:@"campl.us"] && [lastPathComponent isAlphaNumOnly]) {
            result = [NSString stringWithFormat:@"http://campl.us/%@:800px", lastPathComponent];
        } else if ([url.host hasSuffix:@"ow.ly"] && [url.path hasPrefix:@"/i/"]) {
            result = [NSString stringWithFormat:@"http://static.ow.ly/photos/normal/%@.jpg", lastPathComponent];
        } else if ([url.host hasSuffix:@"miil.me"] && [url.path hasPrefix:@"/p/"]) {
            result = [NSString stringWithFormat:@"%@://%@/%@.jpeg?size=480", url.scheme, url.host, url.path];
        } else if([url.host hasSuffix:@"via.me"]){
            NSString *str = [lastPathComponent stringByReplacingOccurrencesOfString:@"-" withString:@""];
            result = [ExtendImageServiceForEchofon getImageURLbyloadJson:str];
        } else if([url.host hasSuffix:@"gyazo.com"] &&[lastPathComponent isAlphaNumOnly]){
            result = [[NSString stringWithFormat:[url absoluteString]] stringByAppendingString:@".png"];
        }
    }
    return result;
}

- (NSString*)__getThumbnailImageURL
{
    NSString* result = [self __getThumbnailImageURL];
    if (!result) {
        NSURL *url = [NSURL URLWithString:(NSString*)self];
        NSString<EchofonNSString>* lastPathComponent = (NSString<EchofonNSString>*)url.lastPathComponent;
        if ([url.host hasSuffix:@"p.twipple.jp"] && [lastPathComponent isAlphaNumOnly]) {
            result = [NSString stringWithFormat:@"http://p.twipple.jp/show/thumb/%@", lastPathComponent];
        } else if ([url.host hasSuffix:@"viddy.com"] && [url.path hasPrefix:@"/video/"]) {
            result = [NSString stringWithFormat:@"http://cdn.viddy.com/images/video/%@.jpg", lastPathComponent];
        } else if ([url.host hasSuffix:@"yfrog.us"] && [lastPathComponent isAlphaNumOnly]) {
            result = [NSString stringWithFormat:@"http://yfrog.com/%@:small", lastPathComponent];
        } else if ([url.host hasSuffix:@"campl.us"] && [lastPathComponent isAlphaNumOnly]) {
            result = [NSString stringWithFormat:@"http://campl.us/%@:120px", lastPathComponent];
        } else if ([url.host hasSuffix:@"ow.ly"] && [url.path hasPrefix:@"/i/"]) {
            result = [NSString stringWithFormat:@"http://static.ow.ly/photos/normal/%@.jpg", lastPathComponent];
        } else if ([url.host hasSuffix:@"miil.me"] && [url.path hasPrefix:@"/p/"]) {
            result = [NSString stringWithFormat:@"%@://%@/%@.jpeg?size=60", url.scheme, url.host, url.path];
        }else if([url.host hasPrefix:@"via.me"]){
            NSString *str = [lastPathComponent stringByReplacingOccurrencesOfString:@"-" withString:@""]; 
            result = [ExtendImageServiceForEchofon getThumbImageURLbyloadJson:str];
        }else if([url.host hasSuffix:@"gyazo.com"] &&[lastPathComponent isAlphaNumOnly]){
             result = [[NSString stringWithFormat:[url absoluteString]] stringByAppendingString:@".png"];
        }
    }
    return result;
}

@end

@implementation ExtendImageServiceForEchofon
@synthesize string;
/**
 * A special method called by SIMBL once the application has started and all classes are initialized.
 */
+ (void) load
{
    ExtendImageServiceForEchofon* plugin = [ExtendImageServiceForEchofon sharedInstance];
    // ... do whatever
    if (plugin) {
        Class from = objc_getClass("NSString");
        Class to = objc_getClass("NSObject");
        method_exchangeImplementations(class_getInstanceMethod(from, @selector(isImageURL)), 
                                       class_getInstanceMethod(to, @selector(__isImageURL)));
        method_exchangeImplementations(class_getInstanceMethod(from, @selector(isVideoURL)), 
                                       class_getInstanceMethod(to, @selector(__isVideoURL)));
        method_exchangeImplementations(class_getInstanceMethod(from, @selector(getImageURL)), 
                                       class_getInstanceMethod(to, @selector(__getImageURL)));
        method_exchangeImplementations(class_getInstanceMethod(from, @selector(getThumbnailImageURL)), 
                                       class_getInstanceMethod(to, @selector(__getThumbnailImageURL)));
    }
    
}

/**
 * @return the single static instance of the plugin object
 */
+ (ExtendImageServiceForEchofon*) sharedInstance
{
    static ExtendImageServiceForEchofon* plugin = nil;
    
    if (plugin == nil)
        plugin = [[ExtendImageServiceForEchofon alloc] init];
    
    return plugin;
}

+(NSString *)getImageURLbyloadJson:(NSString *)id
{
    NSString *url = [NSString stringWithFormat:@"https://api.via.me/v1/posts/%@?client_id=dt7wzdzwiph35lhj0b740ooiy",id];
    
    NSString *json_data = [NSString stringWithContentsOfURL:[NSURL URLWithString:url]
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil
                           ];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError **error = nil;
    NSDictionary *jsondic = [parser objectWithString:json_data error:error];
    NSString *imageURL = [[[jsondic objectForKey:@"response"] objectForKey:@"post"] objectForKey:@"media_url"];
    return  imageURL;
}

+(NSString *)getThumbImageURLbyloadJson:(NSString *)id{
    NSString *url = [NSString stringWithFormat:@"https://api.via.me/v1/posts/%@?client_id=dt7wzdzwiph35lhj0b740ooiy",id];
    
    NSString *json_data = [NSString stringWithContentsOfURL:[NSURL URLWithString:url]
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil
                           ];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSError **error = nil;
    NSDictionary *jsondic = [parser objectWithString:json_data error:error];
    NSString *thumbImageURL = [[[jsondic objectForKey:@"response"] objectForKey:@"post"] objectForKey:@"thumb_55_url"];
    return thumbImageURL;
    
}
-(void)testMethod
{
    string = @"hoge";
    NSLog(@"%@",string);
}

@end
