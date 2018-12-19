From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Date: Wed, 19 Dec 2018 10:15:00 +0000
Message-ID: <VI1PR04MB5726FBFD2CBEB7A3F0454A5999BE0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <ac569071-3c69-ebc8-2c18-ea1399210549@microchip.com>
 <VI1PR04MB57264CBB25E2984DF221ED2E99A60@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <141c6d79-ae7a-60aa-865a-f6b6997f8da9@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <141c6d79-ae7a-60aa-865a-f6b6997f8da9@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIFttYWlsdG86VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29t
XQ0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMSwgMjAxOCAxOjQwIFBNDQo+IFRvOiBZb2dl
c2ggTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT47IGxpbnV4LQ0KPiBt
dGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgYm9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tOyBicm9v
bmllQGtlcm5lbC5vcmc7DQo+IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgdmlnbmVzaHJAdGkuY29t
OyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9A
a2VybmVsLm9yZzsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY29t
cHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPiBmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMv
N10gbXRkOiBzcGktbm9yOiBhZGQgb3Bjb2RlcyBmb3Igb2N0YWwgUmVhZC9Xcml0ZQ0KPiBjb21t
YW5kcw0KPiANCj4gSGksDQo+IA0KPiBPbiAxMi8xMS8yMDE4IDA2OjU1IEFNLCBZb2dlc2ggTmFy
YXlhbiBHYXVyIHdyb3RlOg0KPiA+IFRodXMgd291bGQgZ29pbmcgdG8gbW9kaWZ5IHRoZSBjb25k
aXRpb24gY2hlY2sgYXMgYmVsb3csIHNvIHRoYXQgU0ZEUA0KPiBwYXJzaW5nIHdvdWxkIGFsc28g
YmUgcGVyZm9ybWVkIHdoZW4gU1BJX05PUl9PQ1RBTF9SRUFEIGlzIHNldC4gQ29ycmVjdD8NCj4g
Pg0KPiA+ICAgICAgICAgaWYgKChpbmZvLT5mbGFncyAmIChTUElfTk9SX0RVQUxfUkVBRCB8IFNQ
SV9OT1JfUVVBRF9SRUFEIHwNCj4gPiAgICAgICAgICAgICAgU1BJX05PUl9PQ1RBTF9SRUFEKSkg
JiYgIShpbmZvLT5mbGFncyAmDQo+ID4gU1BJX05PUl9TS0lQX1NGRFApKSB7DQo+IA0KPiBZZXMs
IHRoaXMgaXMgd2hhdCBJIHdhcyBzdWdnZXN0aW5nLiBPbiBhIHNlY29uZCB0aG91Z2h0LCB3ZSBo
YXZlbid0IGFkZGVkIHlldA0KPiBzdXBwb3J0IGZvciBwYXJzaW5nIHNmZHAgdG8gZ2V0IHRoZSBv
Y3RhbCBtb2RlIGluZm8sIHNvIHRoZSBwYXJzaW5nIHdpbGwgYmUgZG9uZQ0KPiBncmF0dWl0b3Vz
bHkuIExldCdzIGRyb3AgdGhpcyBjaGFuZ2UgYW5kIGFkZCBpdCB3aGVuIGFkZGluZyBzdXBwb3J0
IGZvciBwYXJzaW5nDQo+IG9jdGFsIG1vZGUgaW5mbyBmcm9tIHNmZHAuIEknbGwgcHJlcGFyZSBh
IHBhdGNoIGZvciB0aGlzLg0KPiANCj4gUGxlYXNlIHJlYmFzZSBvbiB0b3Agb2Ygc3BpLW5vci9u
ZXh0LCBzL29jdG8vb2N0YWwgaW4gc3BpLW5vci5oIGFuZCBjb3JyZWN0IHlvdXINCj4gUy1vLWIg
dGFnIGFuZCB5b3UnbGwgaGF2ZSBteSBSLWIgdGFnLg0KPiANCk5leHQgdmVyc2lvbiwgdjYsIHNl
bnQgZm9yIHJldmlld1sxXS4NClNvcnJ5IGZvciBsYXRlIHJlcGx5LCB3YXMgb24gbGVhdmUuDQoN
Ci0tDQpSZWdhcmRzDQpZb2dlc2ggR2F1cg0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L2xpbnV4LW10ZC9saXN0Lz9zZXJpZXM9ODI4MTUNCg0KPiBUaGFua3MgWW9n
ZXNoLA0KPiB0YQ0K
