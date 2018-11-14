From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Wed, 14 Nov 2018 11:07:04 +0000
Message-ID: <eb4b79be-c12b-16e7-e1dd-86a157cfdc7d@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
 <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
 <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Prabhakar Kushwaha" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-ID: <89687489640DA44EB6C07997A23F0A96@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCk9uIDE0LjExLjE4IDExOjQzLCBZb2dlc2ggTmFyYXlhbiBHYXVyIHdyb3RlOg0KPiBIaSBG
cmllZGVyLA0KPiANCj4gWy4uXQ0KPj4+DQo+Pj4gT2ssIEkgd2lsbCBoYXZlIGEgbG9vayBhdCB3
aGF0IGNvdWxkIG1ha2UgdGhlIGNoaXAgc2VsZWN0aW9uIGZhaWwgaW4NCj4+PiBjYXNlIG9mIEFI
QiByZWFkLg0KPj4NCj4+IENvdWxkIHlvdSB0cnkgd2l0aCB0aGlzIGNoYW5nZSBhcHBsaWVkOg0K
Pj4NCj4+IEBAIC01MDMsNyArNTAzLDcgQEAgc3RhdGljIHZvaWQgZnNsX3FzcGlfc2VsZWN0X21l
bShzdHJ1Y3QgZnNsX3FzcGkgKnEsIHN0cnVjdA0KPj4gc3BpX2RldmljZSAqc3BpKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICBtYXBfYWRkciA9IHEtPm1lbW1hcF9waHk7DQo+PiAgICAg
ICAgICAgICAgICAgICBlbHNlDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9hZGRy
ID0gcS0+bWVtbWFwX3BoeSArDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDIgKiBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9idWZfc2l6ZTsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcS0+ZGV2dHlwZV9kYXRhLT5haGJfYnVmX3NpemU7DQo+Pg0KPj4g
ICAgICAgICAgICAgICAgICAgcXNwaV93cml0ZWwocSwgbWFwX2FkZHIsIHEtPmlvYmFzZSArIFFV
QURTUElfU0ZBMUFEICsNCj4+IChpICogNCkpOw0KPj4gICAgICAgICAgIH0NCj4+DQo+IA0KPiBJ
IGhhdmUgdHJpZWQgYWJvdmUgY2hhbmdlIGFuZCBhbHNvIGhhdmUgZG9uZSBmZXcgbW9yZSBjaGFu
Z2VzIGJ1dCBzdGlsbCBBSEIgcmVhZCBmb3IgQ1MxIGlzIGZhbGxpbmcuDQoNCk1heWJlIENTMSBp
cyBub3Qgc2VsZWN0ZWQgYmVjYXVzZSB3ZSByZXVzZSB0aGUgc2FtZSBtZW1vcnkgb2Zmc2V0IGFz
IGZvciANCkNTMC4gQ2FuIHlvdSB0cnkgd2l0aCBhIGZpeGVkIG1hcHBpbmcgZm9yIGFsbCBmb3Vy
IENTIGxpbmVzLCBsaWtlIHRoaXM6IA0KaHR0cHM6Ly9wYXN0ZS5lZS9wL21Zd2pQPw0KDQpUaGFu
a3MsDQpGcmllZGVy
