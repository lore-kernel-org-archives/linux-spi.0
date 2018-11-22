From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v3 0/7] spi: add support for octo mode
Date: Thu, 22 Nov 2018 05:19:31 +0000
Message-ID: <VI1PR04MB572680334F4BF09EDFAE3E7199DB0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <468e7b5f-8840-2fce-2b47-325eeed577e4@ti.com>
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
To: Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <468e7b5f-8840-2fce-2b47-325eeed577e4@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWdu
ZXNoIFIgW21haWx0bzp2aWduZXNockB0aS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDEzLCAyMDE4IDE6MzAgUE0NCj4gVG86IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5hcmF5
YW4uZ2F1ckBueHAuY29tPjsgbGludXgtDQo+IG10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBib3Jp
cy5icmV6aWxsb25AYm9vdGxpbi5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbWFyZWsudmFz
dXRAZ21haWwuY29tOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPiBmcmllZGVyLnNjaHJlbXBm
QGV4Y2VldC5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDAvN10gc3BpOiBhZGQgc3VwcG9ydCBmb3Igb2N0byBtb2RlDQo+IA0KPiBIaSBZ
b2dlc2gNCj4gDQo+IE9uIDIzLzEwLzE4IDM6MDcgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3Jv
dGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIG9jdG8gbW9kZSBJTyBkYXRhIHRyYW5zZmVyLg0KPiA+
IE1pY3JvbiBmbGFzaCwgbXQzNXh1NTEyYWJhLCBzdXBwb3J0cyBvY3RhbCBtb2RlIGRhdGEgdHJh
bnNmZXIgYW5kIE5YUA0KPiA+IEZsZXhTUEkgY29udHJvbGxlciBzdXBwb3J0cyA4IGRhdGEgbGlu
ZXMgZm9yIGRhdGEgdHJhbnNmZXIgKFJ4L1R4KS4NCj4gPg0KPiA+IFBhdGNoIHNlcmllcw0KPiA+
ICogQWRkIHN1cHBvcnQgZm9yIG9jdG8gbW9kZSBmbGFncyBhbmQgcGFyc2luZyBvZiBzYW1lIGlu
IHNwaSBkcml2ZXIuDQo+ID4gKiBBZGQgcGFyc2luZyBsb2dpYyBmb3Igc3BpLW1lbSBmcmFtZXdv
cmsgYW5kIG0yNXA4MC5jIGRldmljZSBmaWxlLg0KPiA+ICogQWRkIG9wY29kZXMgZm9yIG9jdG8g
SS9PIGNvbW1hbmRzIGluIHNwaS1ub3IgZnJhbWV3b3JrLCBSZWFkIGFuZCBXcml0ZQ0KPiBwcm90
byBmb3IgKDEtMS04LzEtOC04KSBtb2RlLg0KPiA+ICAgT3Bjb2RlcyBhcmUgYWRkZWQgYXMgcGVy
IG9jdGFsIGRhdGEgSU8gY29tbWFuZHMgcmVxdWlyZWQgZm9yDQo+IG10MzV4dTUxMmFiYSBbMV0g
Zmxhc2guDQo+ID4gKiBBZGQgbW9kZSBiaXQgcmVxdWlyZWQgZm9yIG9jdG8gbW9kZSBpbiBueHAt
ZnNwaSBkcml2ZXIgWzJdLg0KPiA+ICogRGVmaW5lIGJpbmRpbmcgcHJvcGVydHkgJ3NwaS1yeC90
eC1idXMtd2lkdGgnIGZvciBMWDIxNjBBUkRCIHRhcmdldCBbMl0uDQo+ID4NCj4gDQo+IFlvdSBt
YXkgaGF2ZSB0byByZWJhc2UgdGhpcyBzZXJpZXMgdG8gYXZvaWQgY29uZmxpY3RzIHdpdGggcmVj
ZW50IHNwaS5oIGNoYW5nZXMuDQpEb25lLCBoYXZlIHNlbmQgdGhlIG5leHQgdmVyc2lvbiB3aXRo
IHJlYmFzZSBvbiB0b3Agb2YgdjQuMjAtcmMyIFsxXSBhbmQgcmVzb2x2aW5nIGNvbmZsaWN0IHdp
dGggc3BpLmggY2hhbmdlcy4NCiANCj4gQWxzbywgSSBzdWdnZXN0IG1lcmdpbmcgcGF0Y2hlcyBp
biBbMV0gd2l0aCB0aGlzIHNlcmllcyBpZiB5b3UgcGxhbiB0byBwb3N0IGFub3RoZXINCj4gdmVy
c2lvbiBzbyB0aGF0IGFsbCBiaXRzIGFyZSBhdCBvbmUgcGxhY2UuDQpQYXRjaGVzIGZvciBhZGRp
dGlvbiBvZiB0aGUgZmxhc2ggcHJvcGVydHkgaGFzIGFscmVhZHkgYmVlbiBhY2NlcHRlZC4NCg0K
LS0NClJlZ2FyZHMNCllvZ2VzaCBHYXVyLg0KDQpbMV0gICBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbGludXgtbXRkL2xpc3QvP3Nlcmllcz03NzM5NA0KDQo+IA0KPiBSZWdh
cmRzDQo+IFZpZ25lc2gNCj4gDQpbLi4uXQ0K
