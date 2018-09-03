From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 1/7] spi: add slave device size in spi_device struct
Date: Mon, 3 Sep 2018 04:47:25 +0000
Message-ID: <VI1PR04MB103801BA8203421C517199BB990C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180831135807.22255bce@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831135807.22255bce@karo-electronics.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgTG90aGFyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvdGhh
ciBXYcOfbWFubiBbbWFpbHRvOkxXQEtBUk8tZWxlY3Ryb25pY3MuZGVdDQo+IFNlbnQ6IEZyaWRh
eSwgQXVndXN0IDMxLCAyMDE4IDU6MjggUE0NCj4gVG86IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlv
Z2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbTsNCj4gbWFyZWsudmFzdXRAZ21haWwu
Y29tOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHJvYmhAa2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGZyaWVkZXIuc2NocmVtcGZAZXhjZWV0LmRlOw0KPiBjb21w
dXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LWFybS0N
Cj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzdd
IHNwaTogYWRkIHNsYXZlIGRldmljZSBzaXplIGluIHNwaV9kZXZpY2Ugc3RydWN0DQo+IA0KPiBI
aSwNCj4gDQo+IE9uIEZyaSwgMzEgQXVnIDIwMTggMTU6NTk6NTggKzA1MzAgWW9nZXNoIEdhdXIg
d3JvdGU6DQo+ID4gQWRkICdzaXplJyBkYXRhIHZhcmlhYmxlIGluIHNwaV9kZXZpY2Ugc3RydWN0
Lg0KPiA+IFRoaXMgaXMgdG8gc2F2ZSB0aGUgc2l6ZSBvZiB0aGUgY29ubmVjdGVkIHNsYXZlIGRl
dmljZS4NCj4gPg0KPiA+IEFmdGVyIHNsYXZlIGRldmljZSBzY2FuLCBzcGlfbm9yX3NjYW4sIHNp
emUgYmVpbmcgYXNzaWduZWQgdG8gdGhpcw0KPiA+IGZyb20gTVREIGxheWVyLg0KPiA+DQo+ID4g
U0ZEUCByZWFkIGlzIGJlaW5nIHJlcXVlc3RlZCBiZWZvcmUgY29tcGxldGlvbiBvZiBzcGlfbm9y
X3NjYW4oKQ0KPiA+IHJvdXRpbmUsIHRodXMgcG9wdWxhdGUgZGV2aWNlIHNpemUgYmVmb3JlIG1h
a2luZyByZWFkIHJlcXVlc3QgdG8gdGhlDQo+ID4gU1BJIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBZb2dlc2ggR2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgIHwgNiArKysrKysNCj4g
PiBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKysNCj4gPiAgaW5jbHVkZS9saW51
eC9zcGkvc3BpLmggICAgICAgfCAyICsrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgw
LmMNCj4gPiBiL2RyaXZlcnMvbXRkL2RldmljZXMvbTI1cDgwLmMgaW5kZXggZmUyNjBjYy4uNmM3
YWQ4NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5jDQo+ID4g
KysrIGIvZHJpdmVycy9tdGQvZGV2aWNlcy9tMjVwODAuYw0KPiA+IEBAIC0xMjQsNiArMTI0LDEw
IEBAIHN0YXRpYyBzc2l6ZV90IG0yNXA4MF9yZWFkKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+IGxv
ZmZfdCBmcm9tLCBzaXplX3QgbGVuLA0KPiA+ICAJLyogY29udmVydCB0aGUgZHVtbXkgY3ljbGVz
IHRvIHRoZSBudW1iZXIgb2YgYnl0ZXMgKi8NCj4gPiAgCW9wLmR1bW15Lm5ieXRlcyA9IChub3It
PnJlYWRfZHVtbXkgKiBvcC5kdW1teS5idXN3aWR0aCkgLyA4Ow0KPiA+DQo+ID4gKwkvKiBmb3Ig
Y2FzZSBvZiBTRkRQIGhlYWRlciByZWFkIGNvbW1hbmRzLCBwb3B1bGF0ZSBzcGkgZGV2aWNlIHNp
emUgKi8NCj4gPiArCWlmIChmbGFzaC0+c3BpbWVtLT5zcGktPnNpemUgPT0gMCkNCj4gPiArCQlm
bGFzaC0+c3BpbWVtLT5zcGktPnNpemUgPSBub3ItPm10ZC5zaXplOw0KPiA+ICsNCj4gSWYgdGhl
ICdzaXplJyBpcyBhbiBzcGltZW0gc3BlY2lmaWMgdmFyaWFibGUgaXQgc2hvdWxkIGJlIGFkZGVk
IHRvIHRoZSBzcGlfbWVtDQo+IHN0cnVjdCByYXRoZXIgdGhhbiB0aGUgc3BpX2RldmljZSBzdHJ1
Y3QuDQoNClN1cmUsIHdvdWxkIG1vdmUgJ3NpemUnIGZyb20gc3RydWN0IHNwaV9kZXZpY2UgdG8g
dGhlIHN0cnVjdCBzcGlfbWVtLg0KDQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdhdXIuDQoNCj4gDQo+
IExvdGhhciBXYcOfbWFubg0K
