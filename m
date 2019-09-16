From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Date: Mon, 16 Sep 2019 13:04:42 +0000
Message-ID: <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
         <20190913114550.956-4-alexandru.ardelean@analog.com>
         <20190916122505.GC4352@sirena.co.uk>
         <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
         <20190916124707.GD4352@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "bcm-kernel-feedback-list@broadcom.com"
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916124707.GD4352@sirena.co.uk>
Content-Language: en-US
Content-ID: <D9A871C55AD7F64187978CE710CCCF5B@namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDEzOjQ3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAxOSBhdCAxMjozNzoxMlBNICswMDAw
LCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiANCj4gPiA+IFRoaXMgYnJlYWtzIHRoZSBi
dWlsZCBhcyB0aGVyZSBpcyBhIHVzZXIgb2YgdGhpcyBpbnRlcmZhY2UuDQo+ID4gQWNrLg0KPiA+
IEpvbmF0aGFuIHBvaW50ZWQgdGhpcyBvdXQuDQo+ID4gVGhlcmUncyBhIFYzIHRoYXQgY2hhbmdl
cyBib3RoIHRoaXMgYW5kIGl0J3MgdXNlciAoaW4gSUlPKS4NCj4gDQo+IFRoYXQgdjMgc2VlbXMg
dG8gYmUgYSBzbWFsbCBzdWJzZXQgb2YgdGhpcyBzZXJpZXM/DQoNCkFjay4NClYzIGlzIHRoZSBm
aXJzdCA0IHBhdGNoZXMgZnJvbSB0aGlzIHNlcmllcy4NCldlbGwsIHBhdGNoZXMgMyAmIDQgYXJl
IHNxdWFzaGVkLg0KDQpJIGFtIDEwMCUgY29udmluY2VkIHRoYXQgdGhlIGVudGlyZSBzZXJpZXMg
aXMgYSBnb29kIGlkZWEuDQpJbiB0aGUgc2Vuc2UgdGhhdCBhIGBzdHJ1Y3Qgc3BpX2RlbGF5YCBt
YXkgYmUgYSBnb29kIGlkZWEsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lLCBpdCBtYXkgYmUgdW4tbmVl
ZGVkLg0KDQpBbGwgSSB3YW50ZWQgdG8gZG8sIHdhcyB0byBhZGQgYW5vdGhlciBkZWxheSBzb21l
d2hlcmUsIGFuZCBnb3QgbG9zdCBpbiB0aGUgcmV3b3JrIG9mIGN1cnJlbnQgZGVsYXlzLg0KSSB0
aG91Z2h0IGFib3V0IHByb3Bvc2luZyBqdXN0IHRoZSBmaXJzdCA0IHBhdGNoZXMgW29uIHRoZWly
IG93bl0sIGJ1dCBJIHRob3VnaHQgdGhhdCBzaG93aW5nIHRoZSBjdXJyZW50IHNlcmllcyBhcy1p
cw0Kbm93LCBtYXkgYmUgYSBnb29kIGlkZWEgYXMgd2VsbCBbdG8gZ2F0aGVyIHNvbWUgZmVlZGJh
Y2tdLg0K
