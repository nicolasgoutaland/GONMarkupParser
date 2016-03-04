//
//  DefaultConfigurationViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "DefaultConfigurationViewController.h"

@interface DefaultConfigurationViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UILabel *inputLabel;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;
@end

@implementation DefaultConfigurationViewController
#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set a default configuration
    _inputLabel.textColor      = [@"red" representedColor];
    _inputLabel.textAlignment  = NSTextAlignmentRight;
    _resultLabel.textColor     = [@"red" representedColor];
    _resultLabel.textAlignment = NSTextAlignmentRight;

    // NSString
    NSString *inputText = @"This label is red by default, <color value=\"blue\">and default text will be displayed red.</><br/><left>Text alignment is also set by label here.</><br/><color value=\"black\">This allows you to configure style in IB for example, without setting a default parser configuration.</>";

    // Configure labels
    _inputLabel.text            = inputText;
    [_resultLabel setMarkedUpText:inputText
                           parser:[GONMarkupParser defaultMarkupParser]];
}
@end
