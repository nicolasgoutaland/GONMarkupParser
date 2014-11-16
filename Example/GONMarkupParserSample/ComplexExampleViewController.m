//
//  ComplexExampleViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 11/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "ComplexExampleViewController.h"
#import "ResultViewController.h"

#define COMPLEX_EXAMPLE_INPUT_FILE  @"ComplexExample"

@interface ComplexExampleViewController ()
// Data
@property (nonatomic, strong) GONMarkupParser *parser;

// View controllers
@property (nonatomic, strong) ResultViewController *resultViewController;

// Outlets
@property (nonatomic, weak  ) IBOutlet UITextView      *inputTextView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *validateButton;
@end

@implementation ComplexExampleViewController
#pragma mark - View management
- (void)viewDidLoad {
    [super viewDidLoad];

    // Validate button
    self.navigationItem.rightBarButtonItem = _validateButton;

    // Load default text for a complex example
    NSString *defaultString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:COMPLEX_EXAMPLE_INPUT_FILE ofType:nil]
                                                        encoding:NSUTF8StringEncoding error:nil];
    self.inputTextView.text = defaultString;

    [self configureParser];
}

#pragma mark - Parser configuration
- (void)configureParser
{
    // Create a new parser
    _parser = [GONMarkupParser defaultMarkupParser];

    // Set your custom configuration here
#ifdef DEBUG
    _parser.debugEnabled = YES; // Fuck yeah, error logging
#endif

    // Set default text configuration
    [_parser.defaultConfiguration setObject:[UIFont systemFontOfSize:25.0]
                                     forKey:NSFontAttributeName];

    // Add a custom markup, that will center text when used, and display it in pink.
    NSMutableParagraphStyle *defaultParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    defaultParagraphStyle.alignment = NSTextAlignmentCenter;
    [_parser addMarkup:[GONMarkupSimple simpleMarkup:@"pwet"
                                               style:@{
                                                        NSParagraphStyleAttributeName : defaultParagraphStyle,
                                                        NSForegroundColorAttributeName : [@"pink" representedColor] // NSString+Color
                                                       }
                                     mergingStrategy:GONMarkupSimpleMergingStrategyMergeAll]];
    
    // Add add font markup, to display small text when encountered
    [_parser addMarkup:[GONMarkupNamedFont namedFontMarkup:[UIFont systemFontOfSize:12.0] forTag:@"small"]];

    // Add a convenient tag for red color
    [_parser addMarkup:[GONMarkupNamedColor namedColorMarkup:[UIColor redColor]
                                                      forTag:@"red"]];

    // Custom markup, based on block
    GONMarkupBlock *markupBlock = [GONMarkupBlock blockMarkup:@"custom"];
    markupBlock.openingMarkupBlock = ^(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context, NSDictionary *dicAttributes) {
        [configurationDictionary setObject:[UIFont boldSystemFontOfSize:69.0]
                                    forKey:NSFontAttributeName];
        [configurationDictionary setObject:[@"brown" representedColor]
                                    forKey:NSForegroundColorAttributeName];
    };

    [_parser addMarkup:markupBlock];

    // Finally registering a custom font. You can refer to it using its key
    [_parser registerFont:[UIFont fontWithName:@"AmericanTypewriter" size:22]
                   forKey:@"customfont"];
}

#pragma mark - UI Actions
- (IBAction)showResult
{
    // Parse string
    self.resultViewController.resultAttributedString = [_parser attributedStringFromString:_inputTextView.text];

    // Show results
    [self.navigationController pushViewController:self.resultViewController
                                         animated:YES];
}

LAZY_PROPERTY(resultViewController);
@end
