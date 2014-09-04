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

+ (instancetype)DejalActivityViewWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"DejalActivityView";
    NSString *content = [WebVM BSD2ClauseLicenseDivStringGivenYear:@"2002-2014" name:@"Dejal Systems, LLC"];
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

+ (instancetype)KNSemiModalViewControllerWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"KNSemiModalViewController";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2012" name:@"Kent Nguyen"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)MBProgressHud
{
    WebVM *vm = [WebVM new];
    vm.title = @"MBProgressHud";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2013" name:@"Matej Bukovinski"];
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (instancetype)THCalendarDatePickerWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"THCalendarDatePicker";
    NSString *content = [WebVM MITLicenseDivStringGivenYear:@"2014" name:@"Tribus Hannes (<a href=\"http://hons82.blogspot.it\">http://hons82.blogspot.it</a>)"];
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

+ (instancetype)DefaultEULAWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"Terms of Service";
    NSString *content = @"<div>"
    "<p></p><p align=\"center\">LICENSED APPLICATION END USER LICENSE AGREEMENT"
    "</p><p></p><p>The Products transacted through the Service are licensed, not sold, to You for use only under the terms of this license, unless a Product is accompanied by a separate license agreement, in which case the terms of that separate license agreement will govern, subject to Your prior acceptance of that separate license agreement.  The licensor (“Application Provider”) reserves all rights not expressly granted to You.  The Product that is subject to this license is referred to in this license as the “Licensed Application.”"
    "    </p><p></p><p>a.  Scope of License:  This license granted to You for the Licensed Application by Application Provider is limited to a non-transferable license to use the Licensed Application on any iPhone or iPod touch that You own or control and as permitted by the Usage Rules set forth in Section 9.b. of the App Store Terms and Conditions (the “Usage Rules”).  This license does not allow You to use the Licensed Application on any iPod touch or iPhone that You do not own or control, and You may not distribute or make the Licensed Application available over a network where it could be used by multiple devices at the same time.  You may not rent, lease, lend, sell, redistribute or sublicense the Licensed Application.  You may not copy (except as expressly permitted by this license and the Usage Rules), decompile, reverse engineer, disassemble, attempt to derive the source code of, modify, or create derivative works of the Licensed Application, any updates, or any part thereof (except as and only to the extent any foregoing restriction is prohibited by applicable law or to the extent as may be permitted by the licensing terms governing use of any open sourced components included with the Licensed Application).  Any attempt to do so is a violation of the rights of the Application Provider and its licensors.  If You breach this restriction, You may be subject to prosecution and damages."
    "        The terms of the license will govern any upgrades provided by Application Provider that replace and/or supplement the original Product, unless such upgrade is accompanied by a separate license in which case the terms of that license will govern."
    "        </p><p></p><p>b.  Consent to Use of Data:  You agree that Application Provider may collect and use technical data and related information, including but not limited to technical information about Your device, system and application software, and peripherals, that is gathered periodically to facilitate the provision of software updates, product support and other services to You (if any) related to the Licensed Application.  Application Provider may use this information, as long as it is in a form that does not personally identify You, to improve its products or to provide services or technologies to You."
    "        </p><p></p><p>c.  Termination.  The license is effective until terminated by You or Application Provider.  Your rights under this license will terminate automatically without notice from the Application Provider if You fail to comply with any term(s) of this license.  Upon termination of the license, You shall cease all use of the Licensed Application, and destroy all copies, full or partial, of the Licensed Application."
    "            </p><p></p><p>d.  Services; Third Party Materials.  The Licensed Application may enable access to Application Provider’s and third party services and web sites (collectively and individually, \"Services\"). Use of the Services may require Internet access and that You accept additional terms of service."
    "</p><p></p><p>You understand that by using any of the Services, You may encounter content that may be deemed offensive, indecent, or objectionable, which content may or may not be identified as having explicit language, and that the results of any search or entering of a particular URL may automatically and unintentionally generate links or references to objectionable material. Nevertheless, You agree to use the Services at Your sole risk and that the Application Provider shall not have any liability to You for content that may be found to be offensive, indecent, or objectionable."
    "    </p><p></p><p>Certain Services may display, include or make available content, data, information, applications or materials from third parties (“Third Party Materials”) or provide links to certain third party web sites. By using the Services, You acknowledge and agree that the Application Provider is not responsible for examining or evaluating the content, accuracy, completeness, timeliness, validity, copyright compliance, legality, decency, quality or any other aspect of such Third Party Materials or web sites.  The Application Provider does not warrant or endorse and does not assume and will not have any liability or responsibility to You or any other person for any third-party Services, Third Party Materials or web sites, or for any other materials, products, or services of third parties. Third Party Materials and links to other web sites are provided solely as a convenience to You. Financial information displayed by any Services is for general informational purposes only and is not intended to be relied upon as investment advice. Before executing any securities transaction based upon information obtained through the Services, You should consult with a financial professional. Location data provided by any Services is for basic navigational purposes only and is not intended to be relied upon in situations where precise location information is needed or where erroneous, inaccurate or incomplete location data may lead to death, personal injury, property or environmental damage.  Neither the Application Provider, nor any of its content providers, guarantees the availability, accuracy, completeness, reliability, or timeliness of stock information or location data displayed by any Services."
    "        </p><p></p><p>You agree that any Services contain proprietary content, information and material that is protected by applicable intellectual property and other laws, including but not limited to copyright, and that You will not use such proprietary content, information or materials in any way whatsoever except for permitted use of the Services. No portion of the Services may be reproduced in any form or by any means. You agree not to modify, rent, lease, loan, sell, distribute, or create derivative works based on the Services, in any manner, and You shall not exploit the Services in any unauthorized way whatsoever, including but not limited to, by trespass or burdening network capacity. You further agree not to use the Services in any manner to harass, abuse, stalk, threaten, defame or otherwise infringe or violate the rights of any other party, and that the Application Provider is not in any way responsible for any such use by You, nor for any harassing, threatening, defamatory, offensive or illegal messages or transmissions that You may receive as a result of using any of the Services."
    "            </p><p></p><p>In addition, third party Services and Third Party Materials that may be accessed from, displayed on or linked to from the iPhone or iPod touch are not available in all languages or in all countries.  The Application Provider makes no representation that such Services and Materials are appropriate or available for use in any particular location. To the extent You choose to access such Services or Materials, You do so at Your own initiative and are responsible for compliance with any applicable laws, including but not limited to applicable local laws.  The Application Provider, and its licensors, reserve the right to change, suspend, remove, or disable access to any Services at any time without notice. In no event will the Application Provider be liable for the removal of or disabling of access to any such Services.  The Application Provider may also impose limits on the use of or access to certain Services, in any case and without notice or liability."
    "                </p><p></p><p>e.  NO WARRANTY:  YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT USE OF THE LICENSED APPLICATION IS AT YOUR SOLE RISK AND THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY AND EFFORT IS WITH YOU. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE LICENSED APPLICATION AND ANY SERVICES PERFORMED OR PROVIDED BY THE LICENSED APPLICATION (\"SERVICES\") ARE PROVIDED \"AS IS\" AND “AS AVAILABLE”, WITH ALL FAULTS AND WITHOUT WARRANTY OF ANY KIND, AND APPLICATION PROVIDER HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THE LICENSED APPLICATION AND ANY SERVICES, EITHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF MERCHANTABILITY, OF SATISFACTORY QUALITY, OF FITNESS FOR A PARTICULAR PURPOSE, OF ACCURACY, OF QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD PARTY RIGHTS.  APPLICATION PROVIDER DOES NOT WARRANT AGAINST INTERFERENCE WITH YOUR ENJOYMENT OF THE LICENSED APPLICATION, THAT THE FUNCTIONS CONTAINED IN, OR SERVICES PERFORMED OR PROVIDED BY, THE LICENSED APPLICATION WILL MEET YOUR REQUIREMENTS, THAT THE OPERATION OF THE LICENSED APPLICATION OR SERVICES WILL BE UNINTERRUPTED OR ERROR-FREE, OR THAT DEFECTS IN THE LICENSED APPLICATION OR SERVICES WILL BE CORRECTED. NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY APPLICATION PROVIDER OR ITS AUTHORIZED REPRESENTATIVE SHALL CREATE A WARRANTY. SHOULD THE LICENSED APPLICATION OR SERVICES PROVE DEFECTIVE, YOU ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION. SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF IMPLIED WARRANTIES OR LIMITATIONS ON APPLICABLE STATUTORY RIGHTS OF A CONSUMER, SO THE ABOVE EXCLUSION AND LIMITATIONS MAY NOT APPLY TO YOU."
    "                </p><p></p><p>f.  Limitation of Liability. TO THE EXTENT NOT PROHIBITED BY LAW, IN NO EVENT SHALL APPLICATION PROVIDER BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, LOSS OF DATA, BUSINESS INTERRUPTION OR ANY OTHER COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR INABILITY TO USE THE LICENSED APPLICATION, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT, TORT OR OTHERWISE) AND EVEN IF APPLICATION PROVIDER HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. SOME JURISDICTIONS DO NOT ALLOW THE LIMITATION OF LIABILITY FOR PERSONAL INJURY, OR OF INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THIS LIMITATION MAY NOT APPLY TO YOU. In no event shall Application Provider’s total liability to you for all damages (other than as may be required by applicable law in cases involving personal injury) exceed the amount of fifty dollars ($50.00).  The foregoing limitations will apply even if the above stated remedy fails of its essential purpose."
    "                    </p><p></p><p>g. You may not use or otherwise export or re-export the Licensed Application except as authorized by United States law and the laws of the jurisdiction in which the Licensed Application was obtained. In particular, but without limitation, the Licensed Application may not be exported or re-exported (a) into any U.S. embargoed countries or (b) to anyone on the U.S. Treasury Department's list of Specially Designated Nationals or the U.S. Department of Commerce Denied Person’s List or Entity List. By using the Licensed Application, you represent and warrant that you are not located in any such country or on any such list. You also agree that you will not use these products for any purposes prohibited by United States law, including, without limitation, the development, design, manufacture or production of nuclear, missiles, or chemical or biological weapons."
    "                    </p><p></p><p>h. The Licensed Application and related documentation are \"Commercial Items\", as that term is defined at 48 C.F.R. §2.101, consisting of \"Commercial Computer Software\" and \"Commercial Computer Software Documentation\", as such terms are used in 48 C.F.R. §12.212 or 48 C.F.R. §227.7202, as applicable.  Consistent with 48 C.F.R. §12.212 or 48 C.F.R. §227.7202-1 through 227.7202-4, as applicable, the Commercial Computer Software and Commercial Computer Software Documentation are being licensed to U.S. Government end users (a) only as Commercial Items and (b) with only those rights as are granted to all other end users pursuant to the terms and conditions herein. Unpublished-rights reserved under the copyright laws of the United States."
    "                    </p><p></p><p>i. The laws of the State of California, excluding its conflicts of law rules, govern this license and your use of the Licensed Application.  Your use of the Licensed Application may also be subject to other local, state, national, or international laws."
    "                    </p></div>";
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

+ (id)DefaultAcknowledgementsWebVM
{
    WebVM *vm = [WebVM new];
    vm.title = @"Acknowledgements";
    NSString *content = @"<div>"
    "Icon Credits"
    "<ul>"
    "<li><a href=\"http://medialoot.com/\">Medialoot</a></li>"
    "<li><a href=\"http://icons8.com/\">Icons8</a>"
    "</ul>"
    "</div>";
    vm.htmlString = [WebVM htmlStringWithContent:content];
    return vm;
}

@end










