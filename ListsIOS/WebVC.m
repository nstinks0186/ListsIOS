//
//  WebVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebVC

- (void)awakeFromNib
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.webVM.title;
    
    if (self.webVM.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.webVM.url]];
    }else{
        [self.webView loadHTMLString:self.webVM.htmlString baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate Methods

@end

@implementation WebVM

+ (NSString *)htmlStringWithContent:(NSString *)content
{
    return [NSString stringWithFormat:@""
    "<html>"
    "<style>"
    "body{ font-family: \"Helvetica Neue\"; padding:10px; }"
    "h3{ text-align:center; }"
    "</style>"
    "<body>"
    "%@"
    "</body>"
    "</html>",content];
}

+ (instancetype)BButtonWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"BButton";
    NSString *content = @""
    "<p>The MIT License (MIT)</p>"
    ""
    "<p>Copyright (c) 2013 Mathieu Bolard</p>"
    ""
    "<p>Permission is hereby granted, free of charge, to any person obtaining a copy "
    "of this software and associated documentation files (the \"Software\"), to deal "
    "in the Software without restriction, including without limitation the rights "
    "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell "
    "copies of the Software, and to permit persons to whom the Software is "
    "furnished to do so, subject to the following conditions:</p>"
    ""
    "    <p>The above copyright notice and this permission notice shall be included in "
    "    all copies or substantial portions of the Software.</p>"
    ""
    "    <p>THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR "
    "    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, "
    "    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE "
    "    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER "
    "    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, "
    "    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN "
    "    THE SOFTWARE.</p>";
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)BZGFormFieldWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"BZGFormField";
    vm.url = [NSURL URLWithString:@"https://google.com"];
    vm.htmlString = @"";
    return vm;
}

+ (instancetype)CTFeedbackWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"CTFeedback";
    vm.url = [NSURL URLWithString:@"https://google.com"];
    vm.htmlString = @"";
    return vm;
}

+ (instancetype)ECSlidingViewControllerWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"ECSlidingViewController";
    vm.url = [NSURL URLWithString:@"https://google.com"];
    vm.htmlString = @"";
    return vm;
}

+ (instancetype)HexColorWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"HexColor";
    vm.url = [NSURL URLWithString:@"https://google.com"];
    vm.htmlString = @"";
    return vm;
}

+ (instancetype)TSMessagesWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"TSMessages";
    vm.url = [NSURL URLWithString:@"https://google.com"];
    vm.htmlString = @"";
    return vm;
}

@end











