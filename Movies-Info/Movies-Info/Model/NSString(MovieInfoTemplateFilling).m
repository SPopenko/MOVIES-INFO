//
//  NSString(MovieInfoTempolateFilling).m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString(MovieInfoTemplateFilling).h"
#import "NSDataAdditions.m"

@implementation NSString(MovieInfoTemplateFilling)

#define OpenKeyFieldBracket @"["
#define CloseKeyFieldBracket @"]"

#pragma mark fillTemplateDictionary additional methods
+ (NSString*) base64StringFromImageUrlString:(NSString*)imageUrlString withStyleClass:(NSString*)styleClass
{
    UIImage* image = [MovieCache getImageFromCache:imageUrlString];
    NSData*  imageData = UIImagePNGRepresentation(image);
    NSString* result = nil;
    if (styleClass != nil)
    {
        result =[NSString stringWithFormat:@"<img class=\"%@\" src=\"data:image/png;base64,%@\">", styleClass, [imageData base64Encoding]];
    }
    else
    {
        result = [NSString stringWithFormat:@"<img src=\"data:image/png;base64,%@\">",[imageData base64Encoding]];
    }
    return result;
}


//Converting string to object
+ (NSString*) stringFromObject:(id) object withObjectName:(NSString*)objectName
{
    NSString* result = nil;
    
    [object     retain];
    [objectName retain];
    
    if (object != nil)
    {
        if ([object isKindOfClass:[NSString class]]) {
            if ([objectName isEqualToString:@"poster"])
            {
                result = [[NSString alloc] initWithFormat:@"%@", [self base64StringFromImageUrlString:object withStyleClass:objectName]];
            }
            else
            {
                result = [[NSString alloc] initWithString:object];
            }
        }
        else if ([object isKindOfClass:[NSNumber class]])
        {
            if ([objectName isEqualToString:@"fanRating"])
            {
                result = [[NSString alloc] initWithFormat:@"%2.1f", [object doubleValue]];
            }
            else
            {
                result = [[NSString alloc] initWithFormat:@"%d", [object intValue]];
            }
        }
        else if([object isKindOfClass:[NSDate class]])
        {
            NSDateFormatter* df = [[NSDateFormatter alloc] init];
            [df setDateStyle:NSDateFormatterLongStyle];
            result = [[NSString alloc] initWithString:[df stringFromDate:object]];
            [df release];
        }
        else if([object isKindOfClass:[Poster class]])
        {
            if([((Poster*)object).image.type isEqualToString:objectName] && 
               [((Poster*)object).image.size isEqualToString:@"thumb"])
            {
                result = [[NSString alloc] initWithFormat:@"%@", [self base64StringFromImageUrlString:((Poster*)object).image.url withStyleClass:objectName]];
            }
        }
        else if([object isKindOfClass:[Person class]])
        {
            result = [[NSString alloc] initWithString:((Person*)object).name];
        }
        else
        {
            result = [[NSString alloc] initWithString:[object description]];
        }
    }
    
    [object     release];
    [objectName release];
    
    return [result autorelease];
}

+ (NSMutableDictionary*) keyFieldsFromTemplateString:(NSString*)templateString
{
    NSMutableDictionary* result = nil;
    [templateString retain];
    if (templateString)
    {
        NSScanner *scanner = [[NSScanner alloc] initWithString:templateString];
        // open search
        [scanner scanUpToString:OpenKeyFieldBracket intoString:nil];
        while (![scanner isAtEnd]) {
            [scanner scanString:OpenKeyFieldBracket intoString:nil];
            // close search
            NSString *tag = nil;
            [scanner scanUpToString:CloseKeyFieldBracket intoString:&tag];
            if (tag)
            {
                if (result == nil)
                {
                    result = [[NSMutableDictionary alloc] init];
                }
                [result setObject:@"" forKey:tag];
            }
            else
            {
                break;
            }
            [scanner scanUpToString:OpenKeyFieldBracket intoString:nil];
        }
        [scanner release];
    }
    
    [templateString release];
    
    return [result autorelease];
}

+ (void) removeUnnecessaryFieldsFromDictionary:(NSMutableDictionary*)fieldsDictionary
                                     withClass:(Class) templateClass
{
    [fieldsDictionary retain];
    NSMutableDictionary* classProperties = [[NSMutableDictionary alloc] init];
    NSMutableArray* keysForDelete = [[NSMutableArray alloc]init];
    
    do
    {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(templateClass, &propertyCount);
        
        for (unsigned int i = 0; i < propertyCount; i++)
        {
            NSString *property = [[NSString alloc] initWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
            [classProperties setObject:@"" forKey:property];
            [property release];
        }
        
        free(properties);
        templateClass = [templateClass superclass];
    }while (templateClass != [NSObject class]);
    
    for (NSString* key in fieldsDictionary)
    {
        id obj = [classProperties objectForKey:key];
        if (obj == nil)
        {
            [keysForDelete addObject:key];
        }
    }
    
    for (id obj in keysForDelete)
    {
        [fieldsDictionary removeObjectForKey:obj];
    }
    
    [keysForDelete release];
    [fieldsDictionary release];
    [classProperties release];
}

+ (void) fillTemplateDictionary:(NSMutableDictionary*)fieldsDictionary 
          withDetailedMovieInfo:(DetailedMovieInfo*) movieInfo
{
    NSArray* keys = [fieldsDictionary allKeys];
    for (NSString* key in keys)
    {
        
        id object = [movieInfo valueForKey:key];
        [object retain];
        if ([object isKindOfClass:[NSArray class]])
        {
            NSString* separator = nil;
            NSMutableString* value = nil;
            if ([key isEqualToString:@"cast"])
            {
                separator = [[NSString alloc] initWithString:@", "];
            }
            for (id obj in object)
            {
                NSString* append = [self stringFromObject:obj withObjectName:[key substringToIndex:(key.length-1)]];
                if (append != nil)
                {
                    if (value == nil)
                    {
                        value = [[NSMutableString alloc] initWithString:append];
                    }
                    else
                    {
                        if (separator != nil) [value appendString:separator];
                        [value appendString:append];
                    }
                }
            }
            if (value != nil)[fieldsDictionary setObject:value forKey:key];
            [value release];
            [separator release];
        }
        else
        {
            NSString* value = [self stringFromObject:object withObjectName:key];
            if (value == nil) value = @"";
            [fieldsDictionary setObject:value forKey:key];
        }
        
        [object release];
    }
}

+ (NSString*) replaceKeysInTemplateString:(NSString*)templateString
                     withFieldsDictionary:(NSMutableDictionary*) fieldsDictionary
{
    if (templateString == nil) return nil;
    
    NSMutableString* result = [[[NSMutableString alloc] initWithString:templateString] autorelease];
    
    for (NSString* key in fieldsDictionary)
    {
        NSString* obj = [fieldsDictionary objectForKey:key];
        [result replaceOccurrencesOfString:[NSString stringWithFormat:@"[%@]", key]
                                withString:obj
                                   options:NSCaseInsensitiveSearch 
                                     range:[result rangeOfString:result]];
    }
    
    return [[[result substringFromIndex:0] copy] autorelease];
}

+ (NSString*) stringWithTemplateString:(NSString*)templateString filledDetailedMovieInfo:(DetailedMovieInfo*) movieInfo
{
    NSString*            result              = nil;
    NSMutableDictionary* keyFieldsDictionary = nil;
    
    keyFieldsDictionary = [self keyFieldsFromTemplateString:templateString];
    
    [self removeUnnecessaryFieldsFromDictionary:keyFieldsDictionary withClass:[DetailedMovieInfo class]];
    
    [self fillTemplateDictionary:keyFieldsDictionary withDetailedMovieInfo:movieInfo];
    
    result = [self replaceKeysInTemplateString:templateString withFieldsDictionary:keyFieldsDictionary];
    
    return result;
}

@end
