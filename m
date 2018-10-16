From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH] spi: Make GPIO CSs honour the SPI_NO_CS flag
Date: Tue, 16 Oct 2018 19:29:21 +0000
Message-ID: <1539718160.30311.10.camel@impinj.com>
References: <1539336198-84179-1-git-send-email-phil@raspberrypi.org>
         <1539628457.30311.5.camel@impinj.com> <20181016090310.GA7449@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "phil@raspberrypi.org" <phil@raspberrypi.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016090310.GA7449@sirena.org.uk>
Content-Language: en-US
Content-ID: <1E8EE9126C446A4DAB7C80A2BAA55DAA@namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gVHVlLCAyMDE4LTEwLTE2IGF0IDEwOjAzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIE9jdCAxNSwgMjAxOCBhdCAwNjozNDoxOFBNICswMDAwLCBUcmVudCBQaWVwaG8gd3Jv
dGU6DQo+IA0KPiA+IFdoYXQgYWJvdXQgdGhlIGNhbGxzIHRvIHNwaS0+Y29udHJvbGxlci0+c2V0
X2NzKCkgYWZ0ZXIgdGhpcz8gU2hvdWxkIGENCj4gPiBkcml2ZXIgcHJvdmlkZWQgc2V0X2NzIG1l
dGhvZCBiZSByZXNwb25zaWJsZSBmb3IgY2hlY2tpbmcgU1BJX05PX0NTPyANCj4gPiBPciBzaG91
bGQgaXQgbm90IGJlIGNhbGxlZCBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+IA0KPiBUaGlzIHNlZW1z
IGxpa2Ugc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlIGRvbmUgZW50aXJlbHkgaW4gdGhlIGZyYW1l
d29yaywNCj4gbm8gcG9pbnQgaW4gZXZlcnkgc2luZ2xlIGRyaXZlciBoYXZpbmcgdG8gb3BlbiBj
b2RlIHRoZSBzYW1lIHRoaW5nLg0KPiANCj4gPiBJIGltYWdpbmUgaXQgZGVwZW5kcyBvbiB3aGF0
IHNldF9jcyBuZWVkcyB0byBkbywgd2hpY2ggbWlnaHQgbm90IGJlDQo+ID4gc29sZWx5IHJlbGF0
ZWQgdG8gY2hhbmdpbmcgdGhlIENTIGxpbmUuDQo+IA0KPiBJdCBzaG91bGQgYmUuICBJZiBzb21l
dGhpbmcgaXMgaGFuZ2luZyBvdGhlciB3b3JrIG9uIHNldF9jcygpIHRoZW4gaXQncw0KPiBnb2lu
ZyB0byBicmVhay4NCg0KSUlSQywgZm9yIHNwaS1kdyBzZXR0aW5nIENTIGlzIHRoZSBvbmx5IHdh
eSB0byB0cmlnZ2VyIHRoZSBtYXN0ZXIgdG8gZG8NCmFueXRoaW5nLiAgSSB0aGluayBvcmlvbiBp
cyB0aGUgc2FtZSB3YXkuICBFdmVuIGlmIHlvdSBkb24ndCB3YW50IGEgQ1MNCmxpbmUgdGhlIGRy
aXZlciBzdGlsbCBuZWVkcyB0byBhc3NlcnQgb25lLiAgV2hpY2ggQ1MgdG8gdXNlIGFzIHRoZQ0K
ZHVtbXkgQ1MgaXMgYSBjaGFsbGVuZ2UgdGhhdCBoYXMgY29tZSB1cCBiZWZvcmUuDQoNCmJjbTI4
MzVfc3BpX3NldF9jcygpIGRvZXMgY2hlY2sgU1BJX05PX0NTLCBidXQgaXQgc3RpbGwgZG9lcyBh
IGxvdCBvZg0Kb3RoZXIgc3R1ZmYgZXZlbiBpZiB0aGF0IGlzIHNldCwgbGlrZWx5IGJlY2F1c2Ug
b2YgdGhlIGFib3ZlIGlzc3VlLg==
