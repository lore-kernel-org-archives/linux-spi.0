From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Date: Tue, 11 Dec 2018 12:32:40 +0000
Message-ID: <22730de3-55f0-df21-312a-560a02f02dc7@microchip.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181210213553.GK8952@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Cyrille.Pitchen@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>
To: <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210213553.GK8952@piout.net>
Content-Language: en-US
Content-ID: <FDD38498AEBB3547A3FAB81144C33D0F@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGksIEFsZXhhbmRyZSwNCg0KT24gMTIvMTAvMjAxOCAxMTozNSBQTSwgQWxleGFuZHJlIEJlbGxv
bmkgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gMTAvMTIvMjAxOCAxNzoxNToyOSswMDAwLCBUdWRv
ci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBDeXJpbGxlIFBpdGNoZW4g
PGN5cmlsbGUucGl0Y2hlbkBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IFRoaXMgcGF0Y2ggY29uZmln
dXJlcyB0aGUgUVNQSTAgY29udHJvbGxlciBwaW4gbXV4aW5nIGFuZCBkZWNsYXJlcw0KPj4gYSBq
ZWRlYyxzcGktbm9yIG1lbW9yeS4NCj4+DQo+PiBzYW1hNWQyIFhwbGFpbmVkIFJldkIgYW5kIFJl
dkMgdXNlIHRoZSBNYWNyb25peCBNWDI1TDI1NjczRyBmbGFzaA0KPj4gbWVtb3J5IHdoaWNoIGFk
dmVydGlzZXMgYSBtYXhpbXVtIGZyZXF1ZW5jeSBvZiA4ME1IeiBmb3IgUXVhZCBJTw0KPj4gRmFz
dCBSZWFkLiBTZXQgdGhlIHNwaS1tYXgtZnJlcXVlbmN5IHRvIDgwTUh6IGtub3dpbmcgdGhhdCBh
Y3R1YWxseQ0KPj4gdGhlIFFTUEkgZHJ2ZXIgd2lsbCBzZXQgdGhlIFNQSSBidXMgY2xvY2sgdG8g
MTY2TUh6IC8gMyA9IDU1LjNNSHouDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ3lyaWxsZSBQaXRj
aGVuIDxjeXJpbGxlLnBpdGNoZW5AbWljcm9jaGlwLmNvbT4NCj4+IFt0dWRvci5hbWJhcnVzQG1p
Y3JvY2hpcC5jb206DQo+PiAtIGRyb3AgcGFydGl0aW9ucywNCj4+IC0gYWRkIHNwaS1yeC90eC1i
dXMtd2lkdGgNCj4+IC0gY2hhbmdlIHNwaS1tYXgtZnJlcXVlbmN5IHRvIG1hdGNoIHRoZSA4ME1I
eiBsaW1pdCBhZHZlcnRpc2VkIGJ5DQo+PiAgIE1YMjVMMjU2NzNHIGZvciBRdWFkIElPIEZhc3Qg
UmVhZCwNCj4+IC0gcmV3b3JkIGNvbW1pdCBtZXNzYWdlIGFuZCBzdWJqZWN0Ll0NCj4+IFNpZ25l
ZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+
IC0tLQ0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMgfCAz
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEt
c2FtYTVkMl94cGxhaW5lZC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfeHBs
YWluZWQuZHRzDQo+PiBpbmRleCA1MThlMmIwOTVjY2YuLjE3MWJjODJjZmJiZiAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMNCj4+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMNCj4+IEBAIC0x
MDgsNiArMTA4LDIxIEBADQo+PiAgCQl9Ow0KPj4gIA0KPj4gIAkJYXBiIHsNCj4+ICsJCQlxc3Bp
MDogc3BpQGYwMDIwMDAwIHsNCj4+ICsJCQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+
ICsJCQkJcGluY3RybC0wID0gPCZwaW5jdHJsX3FzcGkwX2RlZmF1bHQ+Ow0KPj4gKwkJCQkvKiBz
dGF0dXMgPSAib2theSI7ICovIC8qIGNvbmZsaWN0IHdpdGggc2RtbWMxICovDQo+IA0KPiBJc24n
dCB0aGF0IGNvbmZsaWN0aW5nIHRoZW4gYmVjYXVzZSBJIHRoaW5rIHRoZSBkZWZhdWx0IGlzIG9r
YXkuDQpxc3BpMCBpcyBkaXNhYmxlZCBpbiBzYW1hNWQyLmR0c2kuDQoNClRoYW5rcywNCnRhDQo=
