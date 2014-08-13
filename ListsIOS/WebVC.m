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

+ (NSString *)MITLicenseDivStringGivenYear:(NSString *)year name:(NSString *)name
{
    return [NSString stringWithFormat:
            @"<div>"
            "<p>MIT License (MIT)</p>"
            ""
            "<p>Copyright (c) %@ %@</p>"
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
            "    THE SOFTWARE.</p>"
            "</div>", year, name];
}

+ (NSString *)BSD2ClauseLicenseDivStringGivenYear:(NSString *)year name:(NSString *)name
{
    return [NSString stringWithFormat:
            @"<div>"
            "<p>BSD 2-Clause License</p>"
            ""
            "<p>Copyright (c) %@, %@"
            ""
            "<p>All rights reserved.</p>"
            ""
            "<p>Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:</p>"
            ""
            "<ol>"
            "<li>Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.</li>"
            ""
            "<li>Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.</li>"
            "</ol>"
            ""
            "<p>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</p>"
            "</div>", year, name];
}

+ (NSString *)ApacheV2LicenseDivStringGivenYear:(NSString *)year name:(NSString *)name
{
    return [NSString stringWithFormat:
            @"<div>"
            "<p>Apache License, Version 2.0</p>"
            ""
            "<p>Copyright %@ %@</p>"
            ""
            "Licensed under the Apache License, Version 2.0 (the \"License\"); "
            "you may not use this file except in compliance with the License. "
            "You may obtain a copy of the License at "
            ""
            "<p>&nbsp;<a href=\"http://www.apache.org/licenses/LICENSE-2.0\">http://apache.org/LICENSE-2.0</a></p>"
            ""
            "<p>Unless required by applicable law or agreed to in writing, software "
            "distributed under the License is distributed on an \"AS IS\" BASIS, "
            "WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. "
            "See the License for the specific language governing permissions and "
            "limitations under the License.</p>"
            "</div>", year, name];
}

+ (instancetype)BButtonWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"BButton";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2013" name:@"Mathieu Bolard"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)BZGFormFieldWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"BZGFormField";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2013" name:@"Ben Guo"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)CTFeedbackWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"CTFeedback";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2013" name:@"Ryoichi Izumita"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)ECSlidingViewControllerWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"ECSlidingViewController";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2013" name:@"Mike Enriquez &lt;<a href=\"mailto:mike@enriquez.me\">mike@enriquez.me</a>&gt;"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)FacebookSDKWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"Facebook SDK";
    NSString *content = [WebVM ApacheV2LicenseDivStringGivenYear:@"2010" name:@"Facebook"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)HexColorWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"HexColor";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2012" name:@"Marius Landwehr &lt;<a href=\"mailto:mike@enriquez.me\">marius.landwehr@gmail.com</a>&gt;"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)TSMessagesWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"TSMessages";
    NSString *content = [WebVM BSD2ClauseLicenseDivStringGivenYear:@"2012" name:@"Toursprung"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

@end











