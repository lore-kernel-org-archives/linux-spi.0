From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Tue, 18 Sep 2018 08:28:23 +0000
Message-ID: <VI1PR04MB1038A85DC36665244DF2104A991D0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180917133751.453ea6ed@bbrezillon>
 <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Frieder Schrempf <frieder.schrempf@exceet.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9529c765-cb3b-02f9-df15-4f79cfa48e47@exceet.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgRnJpZWRlciwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmll
ZGVyIFNjaHJlbXBmIFttYWlsdG86ZnJpZWRlci5zY2hyZW1wZkBleGNlZXQuZGVdDQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxOCwgMjAxOCAxOjUyIFBNDQo+IFRvOiBCb3JpcyBCcmV6aWxs
b24gPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT47IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4g
PHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgbGludXgtDQo+IHNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+IG1h
cmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
MS81XSBzcGk6IHNwaS1tZW06IEFkZCBkcml2ZXIgZm9yIE5YUCBGbGV4U1BJIGNvbnRyb2xsZXIN
Cj4gDQo+IEhpIEJvcmlzLCBZb2dlc2gsDQo+IA0KPiBPbiAxNy4wOS4yMDE4IDEzOjM3LCBCb3Jp
cyBCcmV6aWxsb24gd3JvdGU6DQo+ID4gSGkgWW9nZXNoLA0KPiA+DQo+ID4gT24gTW9uLCAxNyBT
ZXAgMjAxOCAxNToxODoyNiArMDUzMA0KPiA+IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdh
dXJAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gKw0KPiA+PiArCS8qDQo+ID4+ICsJICogUi9X
IGZ1bmN0aW9ucyBmb3IgYmlnLSBvciBsaXR0bGUtZW5kaWFuIHJlZ2lzdGVyczoNCj4gPj4gKwkg
KiBUaGUgRlNQSSBjb250cm9sbGVyJ3MgZW5kaWFubmVzcyBpcyBpbmRlcGVuZGVudCBvZg0KPiA+
PiArCSAqIHRoZSBDUFUgY29yZSdzIGVuZGlhbm5lc3MuIFNvIGZhciwgYWx0aG91Z2ggdGhlIENQ
VQ0KPiA+PiArCSAqIGNvcmUgaXMgbGl0dGxlLWVuZGlhbiB0aGUgRlNQSSBjb250cm9sbGVyIGNh
biB1c2UNCj4gPj4gKwkgKiBiaWctZW5kaWFuIG9yIGxpdHRsZS1lbmRpYW4uDQo+ID4+ICsJICov
DQo+ID4+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImJpZy1lbmRpYW4iKSkgew0K
PiA+PiArCQlmLT53cml0ZSA9IGZzcGlfd3JpdGVsX2JlOw0KPiA+PiArCQlmLT5yZWFkID0gZnNw
aV9yZWFkbF9iZTsNCj4gPj4gKwl9IGVsc2Ugew0KPiA+PiArCQlmLT53cml0ZSA9IGZzcGlfd3Jp
dGVsOw0KPiA+PiArCQlmLT5yZWFkID0gZnNwaV9yZWFkbDsNCj4gPj4gKwl9DQo+ID4NCj4gPiBI
bSwgaXNuJ3QgaXQgc29tZXRoaW5nIHlvdSBjYW4gZXh0cmFjdCBmcm9tIHRoZSBjb21wYXRpYmxl
IHN0cmluZz8gSSdkDQo+ID4gcmF0aGVyIG5vdCBhbGxvdyB1c2VycyB0byBzZXQgdGhhdCBpbiB0
aGVpciBEVCBpZiBpdCdzIG5vdCBzb21ldGhpbmcNCj4gPiB5b3UgY2FuIGNoYW5nZS4NCj4gDQo+
IFRoaXMgd2FzIGNvcGllZCBmcm9tIHRoZSBRU1BJIGRyaXZlciwgYnV0IEkgdGhpbmsgQm9yaXMg
aXMgcmlnaHQuIFRoaXMgc2VlbXMgdG8gYmUgYQ0KPiBmaXhlZCBTT0Mtc3BlY2lmaWMgc2V0dGlu
ZyBhbmQgd2Ugc2hvdWxkbid0IHNldCBpdCBpbiB0aGUgRFQuIFRoaXMgYXBwbGllcyB0byBRU1BJ
DQo+IGFuZCBGU1BJIGFsaWtlLg0KPiANCg0KWWVzLCBpdCBjYW4gYmUgbW9kaWZpZWQuIEluc3Rl
YWQgb2YgcmVhZGluZyBlbmRpYW5uZXNzIHByb3BlcnR5IGZyb20gZGV2aWNlIHRyZWUgY2FuIGJl
IG1vdmVkIHRvIHRoZSBwbGF0Zm9ybSBzdHJ1Y3R1cmUgbnhwX2ZzcGlfZGV2dHlwZV9kYXRhIHdo
aWNoIGlzIGxpbmtlZCB3aXRoIHRoZSBjb21wYXRpYmxlIHN0cmluZw0KeyAuY29tcGF0aWJsZSA9
ICJueHAsbHgyMTYwYS1mc3BpIiwgLmRhdGEgPSAodm9pZCAqKSZseDIxNjBhX2RhdGEsIH0NCg0K
VGhhbmtzLg0KDQpXb3VsZCBzZW5kIHRoZSBjaGFuZ2VzIGluIG5leHQgdmVyc2lvbi4NCg0KLS0N
ClJlZ2FyZHMsDQpZb2dlc2ggR2F1ci4NCg0KPiBSZWdhcmRzLA0KPiBGcmllZGVyDQo+IA0KPiA+
DQo+ID4gUmVnYXJkcywNCj4gPg0KPiA+IEJvcmlzDQo+ID4NCg==
