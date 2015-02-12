//
//  SampleViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UITextView *inputTextView;
@property (nonatomic, weak) IBOutlet UITextView *resultTextView;
@end

@implementation SampleViewController
#pragma mark - View management
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Configure textviews
    _inputTextView.text             = _sampleText;
    [_resultTextView setMarkedUpText:_sampleText];
}

#pragma mark - UITextViewDelegate methods
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSString *attachmentValue = [[NSString alloc] initWithData:textAttachment.contents
                                                      encoding:NSUTF8StringEncoding];
    
    // Show link value
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                    message:attachmentValue
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    return NO;
}

@end
