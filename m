From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Mon, 4 Feb 2019 14:28:27 +0000
Message-ID: <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
 <20190204100910.26701-14-tudor.ambarus@microchip.com>
 <20190204151643.0354180d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204151643.0354180d@bbrezillon>
Content-Language: en-US
Content-ID: <76203A191EB89340847F683DC537E571@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDAyLzA0LzIwMTkgMDQ6MTYgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
TW9uLCA0IEZlYiAyMDE5IDEwOjEwOjIxICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBhdG1lbF9xc3BpX3NhbTl4
NjBfd3JpdGVfcmVncyhjb25zdCBzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEsDQo+PiArCQkJCQkgIGNv
bnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCwNCj4+ICsJCQkJCSAgY29uc3Qgc3RydWN0IGF0bWVs
X3FzcGlfY2ZnICpjZmcpDQo+PiArew0KPj4gKwkvKiBDbGVhciBwZW5kaW5nIGludGVycnVwdHMg
Ki8NCj4+ICsJKHZvaWQpcmVhZGxfcmVsYXhlZChhcS0+cmVncyArIFFTUElfU1IpOw0KPj4gKw0K
Pj4gKwkvKiBTZXQgUVNQSSBJbnN0cnVjdGlvbiBGcmFtZSByZWdpc3RlcnMgKi8NCj4+ICsJd3Jp
dGVsX3JlbGF4ZWQoY2ZnLT5pYXIsIGFxLT5yZWdzICsgUVNQSV9JQVIpOw0KPj4gKwlpZiAob3At
PmRhdGEuZGlyID09IFNQSV9NRU1fREFUQV9JTikNCj4+ICsJCXdyaXRlbF9yZWxheGVkKGNmZy0+
aWNyLCBhcS0+cmVncyArIFFTUElfUklDUik7DQo+PiArCWVsc2UNCj4+ICsJCXdyaXRlbF9yZWxh
eGVkKGNmZy0+aWNyLCBhcS0+cmVncyArIFFTUElfSUNSKTsNCj4gDQo+IENhbiB5b3UgdXNlIFdJ
Q1IgaGVyZSAoZXZlbiBpZiBJQ1IgPT0gV0lDUik/DQoNCnllcywgZ29vZCBjYXRjaC4NCj4gDQo+
PiArCXdyaXRlbF9yZWxheGVkKGNmZy0+aWZyLCBhcS0+cmVncyArIFFTUElfSUZSKTsNCj4+ICt9
DQo+IA0KPiBIbSwgc28gdGhlIG9ubHkgZGlmZmVyZW5jZSB3ZSBoYXZlIGlzIHRoZSBSSUNSIHZz
IElDUiByZWcgYW5kIHRoZQ0KPiBBUEJURlJUWVBfUkVBRCB2cyBTQU1BNUQyX1dSSVRFX1RSU0ZS
IGJpdC4gTm90IHN1cmUgaXQgZGVzZXJ2ZXMNCj4gY3JlYXRpbmcgMiBob29rcyBmb3IgdGhhdC4g
Q2FuIHdlIGhhdmUgc29tZXRoaW5nIGxpa2UgLT5oYXNfcmljciBpbg0KPiB0aGUgY2FwcyBhbmQg
dGhlbiBoYXZlIGFuIGlmL2Vsc2UgYmxvY2sgZGlyZWN0bHkgaW4NCj4gYXRtZWxfcXNwaV9zZXRf
Y2ZnKCk/DQo+IA0KDQpDb3JyZWN0LiBJdCBpcyBhIGNvc3Qgb2YgYW4gZXh0cmEgaWYsIEkgdHJp
ZWQgdG8gYXZvaWQgaXQuIEkgbGlrZSBpdCBiZXR0ZXIgd2l0aA0KdGhlc2UgdHdvIGhvb2tzLCBi
dXQgaWYgeW91IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBJJ2xsIGRvIGl0LCBqdXN0IGNvbmZpcm0g
aXQgYWdhaW4uDQoNClRoYW5rcywNCnRhDQo=
