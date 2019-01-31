From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Thu, 31 Jan 2019 10:46:10 +0000
Message-ID: <ae6235b9-be0c-525d-660e-66fb28577376@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
 <20190130184313.281f5374@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
To: <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130184313.281f5374@bbrezillon>
Content-Language: en-US
Content-ID: <01C4465519B27043A274F08B2739A5FB@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDAxLzMwLzIwMTkgMDc6NDMgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
V2VkLCAzMCBKYW4gMjAxOSAxNTowODo0NyArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiArc3RhdGljIGludCBhdG1lbF9zYW05eDYwX3FzcGlfY2xr
X3ByZXBhcmVfZW5hYmxlKHN0cnVjdCBhdG1lbF9xc3BpICphcSkNCj4+ICt7DQo+PiArCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZhcS0+cGRldi0+ZGV2Ow0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4g
KwlpZiAoIWFxLT5jbGspIHsNCj4+ICsJCS8qIEdldCB0aGUgcGVyaXBoZXJhbCBjbG9jayAqLw0K
Pj4gKwkJYXEtPmNsayA9IGRldm1fY2xrX2dldChkZXYsICJwY2xrIik7DQo+PiArCQlpZiAoSVNf
RVJSKGFxLT5jbGspKSB7DQo+PiArCQkJZGV2X2VycihkZXYsICJtaXNzaW5nIHBlcmlwaGVyYWwg
Y2xvY2tcbiIpOw0KPj4gKwkJCXJldHVybiBQVFJfRVJSKGFxLT5jbGspOw0KPj4gKwkJfQ0KPj4g
Kwl9DQo+PiArDQo+PiArCWlmICghYXEtPnFzcGljaykgew0KPj4gKwkJLyogR2V0IHRoZSBRU1BJ
IHN5c3RlbSBjbG9jayAqLw0KPj4gKwkJYXEtPnFzcGljayA9IGRldm1fY2xrX2dldChkZXYsICJx
c3BpY2siKTsNCj4+ICsJCWlmIChJU19FUlIoYXEtPnFzcGljaykpIHsNCj4+ICsJCQlkZXZfZXJy
KGRldiwgIm1pc3Npbmcgc3lzdGVtIGNsb2NrXG4iKTsNCj4+ICsJCQlyZXR1cm4gUFRSX0VSUihh
cS0+cXNwaWNrKTsNCj4+ICsJCX0NCj4+ICsJfQ0KPiANCj4gTW92ZSB0aGUgZGV2bV9jbGtfZ2V0
KCkgY2FsbHMgdG8gdGhlIHByb2JlIHBhdGggaW5zdGVhZCBvZiBkb2luZyBpdCBhdA0KPiBwcmVw
YXJlIHRpbWUsIGFuZCB5b3UgY2FuIG1ha2UgaXQgZ2VuZXJpYyBmb3IgYm90aCBjb21wYXRzIHdp
dGgNCj4gc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJYXEtPmNsayA9IGRldm1fY2xrX2dldChkZXYs
ICJwY2xrIik7DQo+IAlpZiAoSVNfRVJSKGFxLT5jbGspKQ0KPiAJCWFxLT5jbGsgPSBkZXZtX2Ns
a19nZXQoZGV2LCBOVUxMKTsNCj4gDQo+IAlpZiAoSVNfRVJSKGFxLT5jbGspKQ0KPiAJCXJldHVy
biBQVFJfRVJSKGFxLT5jbGspOw0KPiANCj4gCWlmIChhcS0+Y2Fwcy0+cXNwaWNrX3JlcXVpcmVk
KSB7DQo+IAkJYXEtPnFzcGljayA9IGRldm1fY2xrX2dldChkZXYsICJxc3BpY2siKTsNCj4gCQlp
ZiAoSVNfRVJSKGFxLT5xc3BpY2spKSB7DQo+IAkJCXJldHVybiBQVFJfRVJSKGFxLT5xc3BpY2sp
Ow0KPiAJfQ0KDQpnb29kIHRpcCwgd2lsbCBkbywgdGhhbmtzIQ0KDQp0YQ0K
