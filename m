From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Date: Mon, 16 Sep 2019 12:37:12 +0000
Message-ID: <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
         <20190913114550.956-4-alexandru.ardelean@analog.com>
         <20190916122505.GC4352@sirena.co.uk>
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
In-Reply-To: <20190916122505.GC4352@sirena.co.uk>
Content-Language: en-US
Content-ID: <7A207019A739BF4BB5EC44846BC146A6@namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDEzOjI1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIFNlcCAxMywgMjAxOSBhdCAwMjo0NTozOFBNICswMzAw
LCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+IA0KPiA+IC0JdTE2CQljc19jaGFuZ2VfZGVs
YXk7DQo+ID4gLQl1OAkJY3NfY2hhbmdlX2RlbGF5X3VuaXQ7DQo+ID4gKwlzdHJ1Y3Qgc3BpX2Rl
bGF5CWNzX2NoYW5nZV9kZWxheTsNCj4gDQo+IFRoaXMgYnJlYWtzIHRoZSBidWlsZCBhcyB0aGVy
ZSBpcyBhIHVzZXIgb2YgdGhpcyBpbnRlcmZhY2UuDQoNCg0KQWNrLg0KSm9uYXRoYW4gcG9pbnRl
ZCB0aGlzIG91dC4NClRoZXJlJ3MgYSBWMyB0aGF0IGNoYW5nZXMgYm90aCB0aGlzIGFuZCBpdCdz
IHVzZXIgKGluIElJTykuDQoNClYzOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlv
LzIwMTkwOTE2MDcxMDI0LjIxNDQ3LTEtYWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20vVC8j
dA0KDQpWMjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlpby8yMDE5MDkxMzExNTU0
OS4zODIzLTEtYWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20vVC8jdA0KDQpbIGFyY2hpdmUg
aXMgZnJvbSB0aGUgSUlPIGxpc3QgXQ0KDQpXZWxsLCBJJ20gaG9waW5nIHlvdSBhcmUgcmVmZXJy
aW5nIHRvIHRoZSBzYW1lIHVzZXIuDQoNCk9uIGEgZ2VuZXJhbCBub3RlOiBJIGFwb2xvZ2lzZSBm
b3IgdGhlIGFtb3VudCBvZiBub2lzZS9zcGFtIEkgYW0gZG9pbmcgaGVyZS4gU3RpbGwgYWRqdXN0
aW5nIHRvIGhvdyB0byBkbyB0aGluZ3MvY2hhbmdlcw0KdGhhdCB0b3VjaCAyIHN1YnN5c3RlbXMs
IGVzcGVjaWFsbHkgd2hlbiB0cmVlcyBhcmUgbm90IHF1aXRlIGluLXN5bmMuDQo=
