//
//  UIImage+Filter.h
//  BlurFilter
//
//  Created by Ronnie Liew on 6/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(Filter)
//Filters
+ (UIImage *) sampleFilter:(UIImage *)original;

//Utilities
- (int) normalisePixelValue:(int)value {
@end

