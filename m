From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Wed, 14 Nov 2018 10:43:00 +0000
Message-ID: <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
 <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.De>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgRnJpZWRlciwNCg0KWy4uXQ0KPiA+DQo+ID4gT2ssIEkgd2lsbCBoYXZlIGEgbG9vayBhdCB3
aGF0IGNvdWxkIG1ha2UgdGhlIGNoaXAgc2VsZWN0aW9uIGZhaWwgaW4NCj4gPiBjYXNlIG9mIEFI
QiByZWFkLg0KPiANCj4gQ291bGQgeW91IHRyeSB3aXRoIHRoaXMgY2hhbmdlIGFwcGxpZWQ6DQo+
IA0KPiBAQCAtNTAzLDcgKzUwMyw3IEBAIHN0YXRpYyB2b2lkIGZzbF9xc3BpX3NlbGVjdF9tZW0o
c3RydWN0IGZzbF9xc3BpICpxLCBzdHJ1Y3QNCj4gc3BpX2RldmljZSAqc3BpKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWFwX2FkZHIgPSBxLT5tZW1tYXBfcGh5Ow0KPiAgICAgICAgICAg
ICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9hZGRyID0gcS0+bWVt
bWFwX3BoeSArDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAqIHEtPmRl
dnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplOw0KPiANCj4gICAgICAgICAgICAg
ICAgICBxc3BpX3dyaXRlbChxLCBtYXBfYWRkciwgcS0+aW9iYXNlICsgUVVBRFNQSV9TRkExQUQg
Kw0KPiAoaSAqIDQpKTsNCj4gICAgICAgICAgfQ0KPiANCg0KSSBoYXZlIHRyaWVkIGFib3ZlIGNo
YW5nZSBhbmQgYWxzbyBoYXZlIGRvbmUgZmV3IG1vcmUgY2hhbmdlcyBidXQgc3RpbGwgQUhCIHJl
YWQgZm9yIENTMSBpcyBmYWxsaW5nLg0KDQpJIGd1ZXNzIHdlIG5lZWQgdG8gaW1wbGVtZW50IGR5
bmFtaWMgbWVtb3J5IG1hcHBpbmcgWzFdIGZvciBBSEIgUmVhZCBhcyB3YXMgYmVpbmcgZG9uZSBp
biBwcmV2aW91cyBkcml2ZXIgaW1wbGVtZW50YXRpb24uDQpXb3VsZCB0cnkgdGhpcyBhbmQgdXBk
YXRlIHlvdS4NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvNTAzNjU1
Lw0KDQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdhdXINClsuLl0NCg==
