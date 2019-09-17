From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Date: Tue, 17 Sep 2019 06:05:15 +0000
Message-ID: <2ebd680eb38bd3bc46414a5e18e399279946bd9b.camel@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
         <20190913114550.956-4-alexandru.ardelean@analog.com>
         <20190916122505.GC4352@sirena.co.uk>
         <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
         <20190916124707.GD4352@sirena.co.uk>
         <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
         <20190916134309.GH4352@sirena.co.uk>
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
In-Reply-To: <20190916134309.GH4352@sirena.co.uk>
Content-Language: en-US
Content-ID: <418F646267A0C44DA315D6E3661E68FC@namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTE2IGF0IDE0OjQzICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAxOSBhdCAwMTowNDo0MlBNICswMDAw
LCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0wOS0xNiBhdCAx
Mzo0NyArMDEwMCwgTWFyayBCcm93biB3cm90ZToNCj4gPiA+IFRoYXQgdjMgc2VlbXMgdG8gYmUg
YSBzbWFsbCBzdWJzZXQgb2YgdGhpcyBzZXJpZXM/DQo+ID4gQWNrLg0KPiA+IFYzIGlzIHRoZSBm
aXJzdCA0IHBhdGNoZXMgZnJvbSB0aGlzIHNlcmllcy4NCj4gPiBXZWxsLCBwYXRjaGVzIDMgJiA0
IGFyZSBzcXVhc2hlZC4NCj4gPiBJIGFtIDEwMCUgY29udmluY2VkIHRoYXQgdGhlIGVudGlyZSBz
ZXJpZXMgaXMgYSBnb29kIGlkZWEuDQoNClNvbWV0aGluZyBoYXBwZW5lZCBoZXJlIHRvIHRoZSAi
bm90IiB3b3JkLg0KUHJvYmFibHkgZ290IGxvc3QgaW4gYW4gYWx0ZXJuYXRlIGRpbWVuc2lvbiAg
wq9cXyjjg4QpXy/CryAuDQoNCldhcyBzdXBwb3NlZCB0byBiZToNCiJJIGFtIG5vdCAxMDAlIGNv
bnZpbmNlZCB0aGF0IHRoZSBlbnRpcmUgc2VyaWVzIGlzIGEgZ29vZCBpZGVhLiINCg0KDQo+ID4g
SW4gdGhlIHNlbnNlIHRoYXQgYSBgc3RydWN0IHNwaV9kZWxheWAgbWF5IGJlIGEgZ29vZCBpZGVh
LCBidXQgYXQgdGhlDQo+ID4gc2FtZSB0aW1lLCBpdCBtYXkgYmUgdW4tbmVlZGVkLg0KPiA+IEFs
bCBJIHdhbnRlZCB0byBkbywgd2FzIHRvIGFkZCBhbm90aGVyIGRlbGF5IHNvbWV3aGVyZSwgYW5k
IGdvdCBsb3N0IGluDQo+ID4gdGhlIHJld29yayBvZiBjdXJyZW50IGRlbGF5cy4NCj4gPiBJIHRo
b3VnaHQgYWJvdXQgcHJvcG9zaW5nIGp1c3QgdGhlIGZpcnN0IDQgcGF0Y2hlcyBbb24gdGhlaXIg
b3duXSwgYnV0DQo+ID4gSSB0aG91Z2h0IHRoYXQgc2hvd2luZyB0aGUgY3VycmVudCBzZXJpZXMg
YXMtaXMNCj4gPiBub3csIG1heSBiZSBhIGdvb2QgaWRlYSBhcyB3ZWxsIFt0byBnYXRoZXIgc29t
ZSBmZWVkYmFja10uDQo+IA0KPiBJIHRoaW5rIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gcmV2aWV3
IGFzIGEgd2hvbGUgc2VyaWVzIHJhdGhlciB0aGFuIG9ubHkNCj4gYSBwYXJ0IG9mIHRoZSBjb252
ZXJzaW9uLCBpdCBkb2Vzbid0IHJlYWxseSBoZWxwIHRvIG9ubHkgZG8gcGFydCBvZiBpdC4NCj4g
DQo+IFBsZWFzZSBmaXggeW91ciBtYWlsIGNsaWVudCB0byB3b3JkIHdyYXAgd2l0aGluIHBhcmFn
cmFwaHMgYXQgc29tZXRoaW5nDQo+IHN1YnN0YW50aWFsbHkgbGVzcyB0aGFuIDgwIGNvbHVtbnMu
ICBEb2luZyB0aGlzIG1ha2VzIHlvdXIgbWVzc2FnZXMgbXVjaA0KPiBlYXNpZXIgdG8gcmVhZCBh
bmQgcmVwbHkgdG8uDQoNCkFjay4NClByb2JsZW0gaXM6IEkgaGF2ZSB0byByZS1zZXR1cCBteSBl
bWFpbCBjbGllbnQgZXZlcnkgbm93LW4tdGhlbiBzaW5jZSB0aGUNCndvcmstZW1haWwgc2VydmVy
IGhhcyBzb21lIGlzc3VlcyB3aXRoIExpbnV4IGVtYWlsIGNsaWVudHMuDQpBbmQgSSBzb21ldGlt
ZXMgZm9yZ2V0IHRvIGNvbmZpZ3VyZSB0aGlzLg0KWyBFeGNoYW5nZSBkb2VzIG5vdCBhbHdheXMg
Z2V0IGFsb25nIHdlbGwgd2l0aCBub24tT3V0bG9vayBjbGllbnRzIF0NCg==
