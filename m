From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Fri, 1 Feb 2019 14:43:18 +0000
Message-ID: <af691fb9-e972-5590-77f7-754bc1018b05@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
 <20190131161515.21605-11-tudor.ambarus@microchip.com>
 <20190131173207.56481a42@bbrezillon>
 <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
To: <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
Content-Language: en-US
Content-ID: <B1A32B394A61DF4C8AD769D0FF5E83AD@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDAyLzAxLzIwMTkgMDk6MDcgQU0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3
cm90ZToNCg0KY3V0DQoNCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNw
aS5jIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQoNCmN1dA0KDQo+Pj4gK3N0YXRpYyBp
bnQgYXRtZWxfc2FtOXg2MF9xc3BpX3NldF9jZmcodm9pZCBfX2lvbWVtICpiYXNlLA0KPj4+ICsJ
CQkJICAgICAgY29uc3Qgc3RydWN0IHNwaV9tZW1fb3AgKm9wLA0KPj4+ICsJCQkJICAgICAgc3Ry
dWN0IGF0bWVsX3FzcGlfY2ZnICpjZmcpDQo+Pj4gK3sNCj4+PiArCWludCByZXQgPSBhdG1lbF9x
c3BpX3NldF9tb2RlKGNmZywgb3ApOw0KPj4+ICsNCj4+PiArCWlmIChyZXQpDQo+Pj4gKwkJcmV0
dXJuIHJldDsNCj4+PiArDQo+Pj4gKwlyZXQgPSBhdG1lbF9xc3BpX3NldF9hZGRyZXNzX21vZGUo
Y2ZnLCBvcCk7DQo+Pj4gKwlpZiAocmV0KQ0KPj4+ICsJCXJldHVybiByZXQ7DQo+Pj4gKw0KPj4+
ICsJY2ZnLT5pZnIgfD0gUVNQSV9JRlJfSU5TVEVOOw0KPj4+ICsJY2ZnLT5pY3IgfD0gUVNQSV9J
Q1JfSU5TVChvcC0+Y21kLm9wY29kZSk7DQo+Pj4gKw0KPj4+ICsJLyogU2V0IGRhdGEgZW5hYmxl
ICovDQo+Pj4gKwlpZiAob3AtPmRhdGEubmJ5dGVzKQ0KPj4+ICsJCWNmZy0+aWZyIHw9IFFTUElf
SUZSX0RBVEFFTjsNCj4+PiArDQo+Pj4gKwlpZiAoIW9wLT5hZGRyLm5ieXRlcykgew0KPj4+ICsJ
CWNmZy0+aWZyIHw9IFFTUElfSUZSX1RGUlRZUF9UUlNGUl9SRUc7DQo+Pj4gKwkJaWYgKG9wLT5k
YXRhLmRpciA9PSBTUElfTUVNX0RBVEFfT1VUKQ0KPj4+ICsJCQljZmctPmlmciB8PSBRU1BJX0lG
Ul9BUEJURlJUWVBfV1JJVEU7DQo+Pj4gKwkJZWxzZQ0KPj4+ICsJCQljZmctPmlmciB8PSBRU1BJ
X0lGUl9BUEJURlJUWVBfUkVBRDsNCj4+PiArCX0gZWxzZSB7DQo+Pj4gKwkJY2ZnLT5pZnIgfD0g
UVNQSV9JRlJfVEZSVFlQX1RSU0ZSX01FTTsNCj4+DQo+PiBDYW4geW91IHRyeSBkb2luZyBvbmx5
IHJlZ3VsYXIgdHJhbnNmZXJzIGFuZCBsZXQgbWUga25vdyBpZiBpdCBzdGlsbA0KPj4gd29ya3Mu
IFN1cHBvcnQgZm9yIG1lbSB0cmFuc2ZlcnMgY2FuIHRoZW4gYmUgYWRkZWQgYWxvbmcgd2l0aCBk
aXJtYXANCj4+IHN1cHBvcnQuDQo+IA0KPiBzaG91bGQgd29yay4gV2lsbCB0cnkgYW5kIGxldCB5
b3Uga25vdy4NCg0KeW91IHdlcmUgcmlnaHQsIGl0IHdvcmtzLiBJIHdpbGwgbGV0IG1lbSB0cmFu
c2ZlciBsb2dpYyBmb3IgZGlybWFwIHN1cHBvcnQuDQoNCkNoZWVycywNCnRhDQoNCg==
