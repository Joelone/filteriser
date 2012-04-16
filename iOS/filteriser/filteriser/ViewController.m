/*

DESCRIPTION
Use these UIImage additions to render the filters you want to use. Use the python tool to extract
the polynomial values that are used in the sampleFilter method.


See http://www.weemoapps.com/creating-retro-and-analog-image-filters-in-mobile-apps 
for the theory behind this method.

AUTHOR
email: vassilis@weemoapps.com
twitter: @weemoapps

LICENSE
Do whatever you want, but please mention this code in your code if you modify it.

VERSION
0.1
*/

#import "ViewController.h"
#import "UIImage+Filterise.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize originalImageView;
@synthesize filteredImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setOriginalImageView:nil];
    [self setFilteredImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)takePicture:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		UIImagePickerController *UIPicker = [[UIImagePickerController alloc] init];
		UIPicker.allowsEditing = YES;
		UIPicker.delegate = self;
		UIPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:UIPicker animated:YES];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not load" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[alert show];
	}
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
	originalImageView.image = image;
    filteredImageView.image = [UIImage sampleFilter:image];
    [picker dismissModalViewControllerAnimated:YES];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}

@end
