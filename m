From: Robin Gong <yibin.gong@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 07/15] spi: imx: remove ERR009165 workaround
 on i.mx6ul
Date: Fri, 26 Apr 2019 09:32:29 +0000
Message-ID: <1556270773.32214.5.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
 <1556265512-9130-8-git-send-email-yibin.gong@nxp.com>
 <1556269796.2584.25.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, "plyatov@gmail.com"
 <plyatov@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556269796.2584.25.camel@pengutronix.de>
Content-Language: en-US
Content-ID: <F4809C4EB129E94C9772A7F15C79E018@eurprd04.prod.outlook.com>
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

T24gMjAxOS0wNC0yNiBhdCAxMTowOSArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+wqANCj4g
PiDCoHN0YXRpYyBpbmxpbmUgaW50IGlzX2lteDUzX2Vjc3BpKHN0cnVjdCBzcGlfaW14X2RhdGEg
KmQpDQo+ID4gQEAgLTU4NSw5ICs1ODcsMTYgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBh
cmVfdHJhbnNmZXIoc3RydWN0DQo+ID4gc3BpX2lteF9kYXRhICpzcGlfaW14LA0KPiA+IMKgwqDC
oMKgwqDCoGN0cmwgfD0gbXg1MV9lY3NwaV9jbGtkaXYoc3BpX2lteCwgdC0+c3BlZWRfaHosICZj
bGspOw0KPiA+IMKgwqDCoMKgwqDCoHNwaV9pbXgtPnNwaV9idXNfY2xrID0gY2xrOw0KPiA+IA0K
PiA+IC3CoMKgwqDCoMKgLyogRVJSMDA5MTY1OiB3b3JrIGluIFhIQyBtb2RlIGFzIFBJTyAqLw0K
PiA+IC3CoMKgwqDCoMKgaWYgKHNwaV9pbXgtPnVzZWRtYSkNCj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01DOw0KPiA+ICvCoMKgwqDCoMKg
LyoNCj4gPiArwqDCoMKgwqDCoMKgKiBFUlIwMDkxNjU6IHdvcmsgaW4gWEhDIG1vZGUgaW5zdGVh
ZCBvZiBTTUMgYXMgUElPIG9uIHRoZQ0KPiA+IGNoaXBzDQo+ID4gK8KgwqDCoMKgwqDCoCogYmVm
b3JlIGkubXg2dWwuDQo+ID4gK8KgwqDCoMKgwqDCoCovDQo+ID4gK8KgwqDCoMKgwqBpZiAoc3Bp
X2lteC0+dXNlZG1hKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHNwaV9p
bXgtPmRldnR5cGVfZGF0YS0+ZGV2dHlwZSA9PSBJTVg2VUxfRUNTUEkpDQo+ID4gDQo+ID4gPSwg
b3RoZXJ3aXNlIHRoZSB3b3JrYXJvdW5kIG1pZ2h0IGJlIGFwcGxpZWQgdG8gbGF0ZXIgZ2VuZXJh
dGlvbnMNCj4gPiBvZg0KPiB0aGUgY29yZSBpZiBtb3JlIGFyZSBhZGRlZCBsYXRlci4NCj4gDQo+
IFJlZ2FyZHMsDQo+IEx1Y2FzDQpVbmRlcnN0b29kIHlvdXIgcG9pbnQsIGJ1dCBmb3Igbm93IGNo
b29zZSBkaWZmZXJlbnQgY29tcGF0aWJsZSBuYW1lDQpjb3VsZCBhcHBseSB0aGlzIHdvcmthcm91
bmQgb3Igbm90LiBJIHByZWZlciB0byBsZWF2ZSBpdCBmb3IgbmV4dCBlY3NwaQ0KSVAgdXBncmFk
ZSBpZiBpdCByZWFsbHkgY29tZSBpbiB0aGUgZnV0dXJlLCBvdGhlcndpc2UgdGhhdCAnPj0nIGJy
aW5nDQphIGxpdHRsZSBiaXQgY29uZnVzZSBpZiB0aGVyZSBpcyBubyB1cGRhdGUgZm9yIGVjc3Bp
IElQLi4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
