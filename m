From: "Chen, Alvin" <alvin.chen@intel.com>
Subject: RE: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark
 X1000
Date: Wed, 8 Oct 2014 01:32:09 +0000
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E997C63@SHSMSX101.ccr.corp.intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
	 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
 <1411981378.11022.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Eric Miao <eric.y.miao@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Westerberg, Mika" <mika.westerberg@intel.com>,
	"Kweh, Hock Leong" <hock.leong.kweh@intel.com>,
	"Ong, Boon Leong" <boon.leong.ong@intel.com>,
	"Tan, Raymond" <raymond.tan@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411981378.11022.1.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

PiA+IFRoZSBTUEkgbWVtb3J5IG1hcHBlZCBJL08gcmVnaXN0ZXJzIHN1cHBvcnRlZCBieSBRdWFy
ayBhcmUgZGlmZmVyZW50DQo+ID4gZnJvbSB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiwgYW5k
IFF1YXJrIG9ubHkgc3VwcG9ydHMgdGhlIHJlZ2lzdGVycw0KPiA+IG9mICdTU0NSMCcsICdTU0NS
MScsICdTU1NSJywgJ1NTRFInLCBhbmQgJ0REU19SQVRFJy4gVGhpcyBwYXRjaCBpcyB0bw0KPiA+
IGVuYWJsZSB0aGUgU1BJIGZvciBJbnRlbCBRdWFyayBYMTAwMC4NCj4gPg0KPiA+IFRoaXMgcGll
Y2Ugb2Ygd29yayBpcyBkZXJpdmVkIGZyb20gRGFuIE8nRG9ub3ZhbidzIGluaXRpYWwgd29yayBm
b3INCj4gPiBJbnRlbCBRdWFyaw0KPiA+IFgxMDAwIFNQSSBlbmFibGluZy4NCj4gDQo+IE1pbm9y
IGNvbW1lbnRzIGFyZSBiZWxvdy4NCj4gDQo+IEFmdGVyIGFkZHJlc3NpbmcgdGhlbQ0KPiBSZXZp
ZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b20+DQo+IA0KT0suDQo+ID4gKwljYXNlIFFVQVJLX1gxMDAwX1NTUDoNCj4gPiArCQlyZXR1cm4g
UlhfVEhSRVNIX1FVQVJLX1gxMDAwX0RGTFQ7DQo+ID4gIAlkZWZhdWx0Og0KPiA+ICAJCXJldHVy
biBSWF9USFJFU0hfREZMVDsNCj4gPiAgCX0NCj4gPiArDQo+IA0KPiBSZWR1bmRhbnQgZW1wdHkg
bGluZS4NCj4gDQpPSy4gSSB3aWxsIHJlbW92ZSBpdC4NCg0KPiA+ICBzdGF0aWMgdm9pZCBweGEy
eHhfc3BpX2NsZWFyX3J4X3RocmUoY29uc3Qgc3RydWN0IGRyaXZlcl9kYXRhICpkcnZfZGF0YSwN
Cj4gPiAtCQkJCSAgICAgdTMyICpzY2NyMV9yZWcpDQo+ID4gKwkJCQkJICB1MzIgKnNjY3IxX3Jl
ZykNCj4gDQo+IFVubmVjZXNzYXJ5IGNoYW5nZS4NCj4gDQpJbXByb3ZlIGl0IGluIHRoZSBmaXJz
dCBwYXRjaC4NCj4gPiAgc3RhdGljIHZvaWQgcHhhMnh4X3NwaV9zZXRfcnhfdGhyZShjb25zdCBz
dHJ1Y3QgZHJpdmVyX2RhdGEgKmRydl9kYXRhLA0KPiA+IC0JCQkJICAgdTMyICpzY2NyMV9yZWcs
IHUzMiB0aHJlc2hvbGQpDQo+ID4gKwkJCQkJdTMyICpzY2NyMV9yZWcsIHUzMiB0aHJlc2hvbGQp
DQo+IA0KPiBEaXR0by4NCj4gDQo+IE9yIHlvdSBtYXkgZG8gdGhhdCBpbiB0aGUgZmlyc3QgcGF0
Y2guDQo+IA0KSW1wcm92ZSBpdCBpbiB0aGUgZmlyc3QgcGF0Y2guDQo+ID4NCj4gPiAgCQkJcHhh
Mnh4X3NwaV9zZXRfcnhfdGhyZShkcnZfZGF0YSwgJnNjY3IxX3JlZywNCj4gPiAtCQkJCQkgICAg
ICAgcnhfdGhyZSk7DQo+ID4gKwkJCQkJCSAgICByeF90aHJlKTsNCj4gDQo+IERpdHRvLg0KPiAN
CkltcHJvdmUgaXQgaW4gdGhlIGZpcnN0IHBhdGNoLg0KPiA+ICsJaWYgKGlzX3F1YXJrX3gxMDAw
X3NzcChkcnZfZGF0YSkgJiYNCj4gPiArCSAgICAocmVhZF9ERFNfUkFURShyZWcpICE9IGNoaXAt
PmRkc19yYXRlKSkNCj4gDQo+IENvdWxkIGl0IGJlIG9uZSBsaW5lPw0KPiANCk5vLCBpdCBpcyBi
ZXlvbmQgODAgY2hhcmFjdGVycyBpZiBpdCBpcyBpbiBvbmUgbGluZS4NCg==
