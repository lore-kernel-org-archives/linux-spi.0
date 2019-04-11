From: Flavio Suligoi <f.suligoi@asem.it>
Subject: RE: [PATCH 1/2] spi: pxa2xx: fix SCR (divisor) calculation
Date: Thu, 11 Apr 2019 13:10:04 +0000
Message-ID: <3ceba8bc20f8496a9c72653fd450d729@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <34b8442a-15ac-dea2-a088-fde8b1966e1e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <34b8442a-15ac-dea2-a088-fde8b1966e1e@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgSmFya2tvLA0KDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYyBi
L2RyaXZlcnMvc3BpL3NwaS1weGEyeHguYw0KPiA+IGluZGV4IGY3MDY4Y2MuLmM5NTYwYTEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLXB4YTJ4eC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9zcGkvc3BpLXB4YTJ4eC5jDQo+ID4gQEAgLTg4NCwxMCArODg0LDE1IEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgc3NwX2dldF9jbGtfZGl2KHN0cnVjdA0KPiBkcml2ZXJfZGF0YSAqZHJ2X2RhdGEs
IGludCByYXRlKQ0KPiA+DQo+ID4gICAJcmF0ZSA9IG1pbl90KGludCwgc3NwX2NsaywgcmF0ZSk7
DQo+ID4NCj4gPiArCS8qDQo+ID4gKwkgKiBDYWxjdWxhdGUgdGhlIGRpdmlzb3IgZm9yIHRoZSBT
Q1IgKFNlcmlhbCBDbG9jayBSYXRlKSwgYXZvaWRpbmcNCj4gPiArCSAqIHRoYXQgdGhlIFNTUCB0
cmFuc21pc3Npb24gcmF0ZSBjYW4gYmUgZ3JlYXRlciB0aGFuIHRoZSBkZXZpY2UNCj4gcmF0ZQ0K
PiA+ICsJICovDQo+ID4gICAJaWYgKHNzcC0+dHlwZSA9PSBQWEEyNXhfU1NQIHx8IHNzcC0+dHlw
ZSA9PSBDRTQxMDBfU1NQKQ0KPiA+IC0JCXJldHVybiAoc3NwX2NsayAvICgyICogcmF0ZSkgLSAx
KSAmIDB4ZmY7DQo+ID4gKwkJcmV0dXJuIChzc3BfY2xrIC8gKDIgKiByYXRlKSAtIDEgKw0KPiA+
ICsJCQkoc3NwX2NsayAlICgyICogcmF0ZSkgPyAxIDogMCkpICYgMHhmZjsNCj4gPiAgIAllbHNl
DQo+ID4gLQkJcmV0dXJuIChzc3BfY2xrIC8gcmF0ZSAtIDEpICYgMHhmZmY7DQo+ID4gKwkJcmV0
dXJuIChzc3BfY2xrIC8gcmF0ZSAtIDEgKyAoc3NwX2NsayAlIHJhdGUgPyAxIDogMCkpICYNCj4g
MHhmZmY7DQo+ID4gICB9DQo+ID4NCj4gSSB0aGluayBESVZfUk9VTkRfVVAoKSAtIDEgd291bGQg
YWxzbyBmaXggdGhpcz8NCj4gDQo+IEkgcmVhbGl6ZWQgd2UgaGF2ZSBhbHNvIGFub3RoZXIgaXNz
dWUgaGVyZSB3aXRoIHRoZSBsb3cgcmF0ZXMuDQo+IENhbGN1bGF0ZWQgZGl2aWRlciB3aWxsIHVu
ZGVyZmxvdyBkdWUgbWFza2luZyB3aXRoIDB4ZmYgb3IgMHhmZmYgd2hlbg0KPiB0aGUgcmF0ZSBp
cyBsb3cgZW5vdWdoLg0KPiANCj4gV291bGQgeW91IHdhbnQgdG8gZml4IHRoYXQgYnkgc2V0dGlu
ZyB0aGUgY3Rsci0+bWluX3NwZWVkX2h6IHNvIHRoYXQgc3BpDQo+IGNvcmUgY2FuIHZhbGlkYXRl
IHRoZSByYXRlPyBJJ20gYXNraW5nIHNpbmNlIGl0IGdvZXMgd2VsbCB0b2dldGhlciB3aXRoDQo+
IHlvdXIgZml4LiBNYXliZSBvbmUgcGF0Y2ggc2V0dGluZyB0aGUgbWluX3NwZWVkX2h6IGFuZCBn
ZXR0aW5nIG1hc2tpbmcNCj4gb2ZmIGZyb20gaGVyZSBhbmQgdGhlbiBhbm90aGVyIGZpeGluZyB0
aGUgcmF0ZSBjYWxjdWxhdGlvbi4NCg0KT2sgZm9yIHRoZSB0d28gc2VwYXJhdGUgcGF0Y2hlcywg
SSBwcmVwYXJlIHRoZW0gYXMgc29vbiBhcyBJIGNhbi4NCg0KVGhhbmtzLA0KDQpGbGF2aW8NCg==
