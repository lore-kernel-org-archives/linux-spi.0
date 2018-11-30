From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from driver
 data struct
Date: Fri, 30 Nov 2018 18:10:26 +0000
Message-ID: <1543601425.18519.108.camel@impinj.com>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
 <1543598496.18519.101.camel@impinj.com>
 <20181130175004.iiduvgzwwij3fvof@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "marex@denx.de" <marex@denx.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181130175004.iiduvgzwwij3fvof@pengutronix.de>
Content-Language: en-US
Content-ID: <20F18A88CE1A2740B8C43971C6C5FCB8@namprd06.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

T24gRnJpLCAyMDE4LTExLTMwIGF0IDE4OjUwICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gSGVsbG8gVHJlbnQsDQo+IA0KPiBPbiBGcmksIE5vdiAzMCwgMjAxOCBhdCAwNToyMTo0
MFBNICswMDAwLCBUcmVudCBQaWVwaG8gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDE4LTExLTMwIGF0
IDA3OjQ3ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gPiA+IFRoZSBkcml2ZXIg
ZGF0YSdzIG1lbWJlciB2YXJpYWJsZSBqdXN0IGNhY2hlcyB0aGUgdHJhbnNmZXIncyBzcGVlZF9o
eg0KPiA+ID4gbWVtYmVyLiBBbGwgdXNlcnMgb2YgdGhlIGZvcm1lciBub3cgaGF2ZSBhY2Nlc3Mg
ZGlyZWN0bHkgdG8gdGhlIGxhdHRlci4NCj4gPiA+IFNvIGZpeCB0aGVtIHRvIHVzZSB0aGUgdW5j
YWNoZWQgdmFsdWUgYW5kIHJlbW92ZSB0aGUgY2FjaGUuDQo+ID4gDQo+ID4gV2hhdCBzaG91bGQg
aGF2ZSBiZWVuIGRvbmUgd2l0aCB0aGlzIGlzIHRvIGNvbXBhcmUgdGhlIG5leHQgdHJhbnNmZXIn
cw0KPiA+IHNwZWVkX2h6IHRvIHRoaXMgY2FjaGVkIHZhbHVlLCBhbmQgbm90IHByZXByb2dyYW0g
dGhlIGNsb2NrIGlmIGl0IGhhcw0KPiA+IG5vdCBjaGFuZ2VkLiAgU2luY2UgdXN1YWxseSBpdCBk
b2Vzbid0IGNoYW5nZSBiZXR3ZWVuIHRyYW5zZmVycy4NCj4gDQo+IEhtbSwgeWVzLCB0aGlzIGNv
dWxkIGJlIGRvbmUsIGJ1dCBJJ20gbm90IHN1cmUgdGhlIGFkZGl0aW9uYWwgZWZmb3J0DQo+IGJy
aW5ncyBhIHBlcmZvcm1hbmNlIGFkdmFudGFnZS4gSWYgeW91IGhhdmUgdGhlIGVuZXJneSB0byBk
byB0ZXN0IHRoYXQsDQo+IGZlZWwgZnJlZSB0byBpbXBsZW1lbnQgaXQsIHByZWZlcmFibHkgb24g
dG9wIG9mIG15IGNsZWFudXAgY29tbWl0Lg0KDQpJIGRpZCB0aGlzIGZvciB0aGUgaW14MjMgc3Bp
IGRyaXZlclsxXSwgY29tbWl0IGE1NjA5NDNlYWQsIGFuZCBpdCBtb3JlDQp0aGFuIGRvdWJsZSB0
aGUgdHJhbnNmZXIgc3BlZWQuICBUaGF0J3MgYSBtdWNoIHNsb3dlciBDUFUgdGhhbg0KaW14Ni83
LzgsIGJ1dCBpdCBjb3VsZCBzdGlsbCBiZSBhIHByZXR0eSBnb29kIGltcHJvdmVtZW50IG9uIHNv
bWV0aGluZw0Kc2xvdyBsaWtlIGlteDI3Lg0KDQpbMV0gQ29uZnVzaW5nbHksIGlteDIzIGFuZCBp
bXgyOCBhcmUgdG90YWxseSBkaWZmZXJlbnQgY2hpcHMgdGhhdCBvdGhlcg0KaW14IGNoaXBzLCBs
aWtlIGlteDIxIGFuZCBpbXgyNy4gIFRoZSBmb3JtZXIgYXJlICJteHMiIGRlc2lnbnMgdGhhdA0K
RnJlZXNjYWxlIGJvdWdodCBmcm9tIHNvbWVvbmUgZWxzZSAoSSB0aGluayBTVC1NaWNybz8pLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
