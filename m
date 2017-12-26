From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH 0/3] mtd: spi-nor: fix DMA-unsafe buffer issue between MTD
 and SPI
Date: Tue, 26 Dec 2017 18:45:28 +0000
Message-ID: <1514313927.26695.19.camel@impinj.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "radu.pirea@microchip.com" <radu.pirea@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@free-electrons.com"
        <boris.brezillon@free-electrons.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
Content-Language: en-US
Content-ID: <9F4DA121DFBF5C468E6931A7F02B59B9@namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gU3VuLCAyMDE3LTEyLTI0IGF0IDA1OjM2ICswMTAwLCBDeXJpbGxlIFBpdGNoZW4gd3JvdGU6
DQo+IHRoaXMgc2VyaWVzIHRyaWVzIHRvIHNvbHZlIGEgbG9uZyB0aW1lIGlzc3VlIG9mIGNvbXBh
dGliaWxpdHkgYmV0d2VlbiB0aGUNCj4gTVREIGFuZCBTUEkgc3ViLXN5c3RlbXMgYWJvdXQgd2hl
dGhlciB3ZSBzaG91bGQgdXNlIERNQS1zYWZlIG1lbW9yeS4NCg0KQ2FuIHRoaXMgc2hvdWxkIHJl
cGxhY2UgU29DIHNwZWNpZmljIGZpeGVzIGxpa2U6DQoNCmM2ODdjNDZlOWU0NQ0Kc3BpOiBzcGkt
dGktcXNwaTogVXNlIGJvdW5jZSBidWZmZXIgaWYgcmVhZCBidWZmZXIgaXMgbm90IERNQSdibGUN
Cg0KNzA5NDU3NmNjZGMzDQpzcGk6IGF0bWVsOiBmaXggY29ycnVwdGVkIGRhdGEgaXNzdWUgb24g
U0FNOSBmYW1pbHkgU29Dcw0KDQpPciwgc2luY2UgdGhpcyBvbmx5IGZpeGVzIGluc3RhbmNlcyBv
ZiBETUEtdW5zYWZlIGJ1ZmZlcnMgdXNlZCBpbg0KYWNjZXNzIHRvIFNQSSBOT1IgZmxhc2ggY2hp
cHMsIGFuZCBzaW5jZSB0aGVyZSBhcmUgb3RoZXIgU1BJIG1hc3Rlcg0KaW50ZXJmYWNlIHVzZXJz
LCB0aG9zZSBjaGlwIHNwZWNpZmljIGZpeGVzIGluIHNvbWUvYWxsIHNwaSBtYXN0ZXINCmRyaXZl
cnMgYXJlIHN0aWxsIG5lZWRlZCB0byBmaXggdHJhbnNmZXJzIG5vdCBvcmlnaW5hdGVkIHZpYSBz
cGktbm9yPyANCk9yIGFyZSBhbGwgdGhlIHByZXZpb3VzIGZpeGVzIG5lY2Vzc2FyeSBiZWNhdXNl
IG9mIHNwaS1ub3IgZmxhc2ggKHZpYQ0KdWJpZnMgb3IgamZmczIpIGFuZCBvbmNlIHRoYXQncyBm
aXhlZCB2aWEgdGhpcyBzZXJpZXMgdGhlcmUgYXJlIG5vIG1vcmUNCm9yaWdpbmF0b3JzIG9mIGRt
YS11bnNhZmUgYnVmZmVycz8NCg0KPiBUaGUgU1BJIHN1Yi1zeXN0ZW0gaGFzIGFscmVhZHkgaW1w
bGVtZW50ZWQgYSB3b3JrLWFyb3VuZCBvbiBpdHMgc2lkZSwNCj4gYmFzZWQgb24gdGhlIHNwaV9t
YXBfYnVmKCkgZnVuY3Rpb24uIEhvd2V2ZXIgdGhpcyBmdW5jdGlvbiBoYXMgaXRzIG93bg0KPiBs
aW1pdGF0aW9uIHRvby4gRXNwZWNpYWxseSwgZXZlbiBpZiBpdCBidWlsZHMgYSAnc3RydWN0IHNj
YXR0ZXJsaXN0JyBmcm9tDQo+IGEgdm1hbGxvYydlZCBidWZmZXIsIGNhbGxpbmcgZG1hX21hcF9z
ZygpIGlzIHN0aWxsIG5vdCBzYWZlIG9uIGFsbA0KPiBhcmNoaXRlY3R1cmVzLiBFc3BlY2lhbGx5
LCBvbiBBUk0gY29yZXMgdXNpbmcgZWl0aGVyIFZJUFQgb3IgVklWVCBkYXRhDQo+IGNhY2hlcywg
ZG1hX21hcF9zZygpIGRvZXNuJ3QgdGFrZSB0aGUgY2FjaGUgYWxpYXNlcyBpc3N1ZSBpbnRvIGFj
Y291bnQuDQo+IFRoZW4gbnVtZXJvdXMgY3Jhc2hlcyB3ZXJlIHJlcG9ydGVkIGZvciBzdWNoIGFy
Y2hpdGVjdHVyZXMuDQoNCkNvdWxkIHRoZSBhYm92ZSBpc3N1ZSBhbHNvIGJlIGZpeGVkIHZpYSBj
YWxscyB0bw0KZmx1c2hfa2VybmVsX3ZtYXBfcmFuZ2UoKSBhbmQgaW52YWxpZGF0ZV9rZXJuZWxf
dm1hcF9yYW5nZSgpIHRvIGtlZXANCnRoZSBkYXRhIGNhY2hlIHZhbGlkPyAgT3IgaXMgdGhlcmUg
YSByZWFzb24gdGhhdCB3b24ndCB3b3JrPw==
