/*  

A sample framework for making obj-c image processing filters (like Instagram or Camera+)
by using .acv files from Photoshop. You dont even have to have Photoshop installed.
 

//Usage//
Download the Python Tool we made to exctract the curves from the photoshop files.
Link

 

//A bit of theory//
The basic theory behind this framework can be read here: 
 
 
//Licence// 
No Copyright 2011 Weemo Labs
Do-whatever-you-want-to-do-with-it 1.0, but please attribute with a link. Or not. But if you don't a kitten may
die. Thanks.
*/

#import "UIImage+Filter.h"

@implementation UIImage(Filter)


+ (UIImage *) sampleFilter:(UIImage *)original {
    
    CFDataRef dataref=CGDataProviderCopyData(CGImageGetDataProvider(original.CGImage));
    int length=CFDataGetLength(dataref);
    UInt8 *data=(UInt8 *)CFDataGetBytePtr(dataref);    
    
    double newBValue;
    double newGValue;
    double newRValue;

	for(int index=0;index<length;index+=4){
        
        //dont forget : format is BGRA
        //NSLog(@"%d 0",data[index]);
        //NSLog(@"%d 1",data[index+1]);
        //NSLog(@"%d 2",data[index+2]);
        //NSLog(@"%d 3",data[index+3]);
        newBValue = 0.0000045*data[index]*data[index]*data[index]-0.0024166*data[index]*data[index]+1.3826987*data[index];
        newGValue = -0.0002338*data[index+1]*data[index+1]+1.0596073*data[index+1];
        newRValue = 0.0010321*data[index+2]*data[index+2]+0.7368212*data[index+2];

        //change B
        if(newBValue < 0){
				data[index]=0;
			}else{
				if(newBValue>255){
					data[index]=255;
				}else{
					data[index]= newBValue;
				}
			}
		
        if(newGValue < 0){
            data[index+1]=0;
        }else{
            if(newGValue>255){
                data[index+1]=255;
            }else{
                data[index+1]= newGValue;
            }
        }

        
        if(newRValue < 0){
            data[index+2]=0;
        }else{
            if(newRValue>255){
                data[index+2]=255;
            }else{
                data[index+2]= newRValue;
            }
        }

        
		
	} //end of main loop
    
	size_t width=CGImageGetWidth(original.CGImage);
	size_t height=CGImageGetHeight(original.CGImage);
	size_t bitsPerComponent=CGImageGetBitsPerComponent(original.CGImage);
	size_t bitsPerPixel=CGImageGetBitsPerPixel(original.CGImage);
	size_t bytesPerRow=CGImageGetBytesPerRow(original.CGImage);
	CGColorSpaceRef colorspace=CGImageGetColorSpace(original.CGImage);
	CGBitmapInfo bitmapInfo=CGImageGetBitmapInfo(original.CGImage);
	CFDataRef newData=CFDataCreate(NULL,data,length);
	CGDataProviderRef provider=CGDataProviderCreateWithCFData(newData);
	CGImageRef newImg=CGImageCreate(width,height,bitsPerComponent,bitsPerPixel,bytesPerRow,colorspace,bitmapInfo,provider,NULL,true,kCGRenderingIntentDefault);
    UIImage *resultUIImage = [UIImage imageWithCGImage:newImg];

    CFRelease(newData);
    CGImageRelease(newImg);
    CGDataProviderRelease(provider);
    CFRelease(dataref);
    
    return resultUIImage; 
}


- (int) normalisePixelValue:(int)value {

}

@end
