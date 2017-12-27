From: Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH 0/3] mtd: spi-nor: fix DMA-unsafe buffer issue between MTD
 and SPI
Date: Wed, 27 Dec 2017 20:15:11 +0000
Message-ID: <1514405711.26695.67.camel@impinj.com>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
         <1514313927.26695.19.camel@impinj.com> <20171227103609.GQ1827@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "radu.pirea@microchip.com" <radu.pirea@microchip.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "boris.brezillon@free-electrons.com"
        <boris.brezillon@free-electrons.com>,
        "richard@nod.at" <richard@nod.at>,
        "marek.vasut@gmai
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171227103609.GQ1827@finisterre>
Content-Language: en-US
Content-ID: <FA2545AD1CB5704BB88FF465EC11F6C8@namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gV2VkLCAyMDE3LTEyLTI3IGF0IDEwOjM2ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIERlYyAyNiwgMjAxNyBhdCAwNjo0NToyOFBNICswMDAwLCBUcmVudCBQaWVwaG8gd3Jv
dGU6DQo+IA0KPiA+IE9yLCBzaW5jZSB0aGlzIG9ubHkgZml4ZXMgaW5zdGFuY2VzIG9mIERNQS11
bnNhZmUgYnVmZmVycyB1c2VkIGluDQo+ID4gYWNjZXNzIHRvIFNQSSBOT1IgZmxhc2ggY2hpcHMs
IGFuZCBzaW5jZSB0aGVyZSBhcmUgb3RoZXIgU1BJIG1hc3Rlcg0KPiA+IGludGVyZmFjZSB1c2Vy
cywgdGhvc2UgY2hpcCBzcGVjaWZpYyBmaXhlcyBpbiBzb21lL2FsbCBzcGkgbWFzdGVyDQo+ID4g
ZHJpdmVycyBhcmUgc3RpbGwgbmVlZGVkIHRvIGZpeCB0cmFuc2ZlcnMgbm90IG9yaWdpbmF0ZWQg
dmlhIHNwaS1ub3I/IA0KPiANCj4gU1BJIGNsaWVudCBkcml2ZXJzIGFyZSAqc3VwcG9zZWQqIHRv
IHVzZSBETUEgc2FmZSBtZW1vcnkgYWxyZWFkeS4gIEhvdw0KPiBvZnRlbiB0aGF0IGhhcHBlbnMg
aW4gY2FzZXMgd2hlcmUgaXQgbWF0dGVycyBpcyBhIHNlcGFyYXRlIHF1ZXN0aW9uLCB3ZQ0KPiBk
ZWZpbml0ZWx5IGhhdmUgdXNlcnMgd2l0aCBzbWFsbGVyIHRyYW5zZmVycyB0aGF0IGRvbid0IGRv
IHRoZSByaWdodA0KPiB0aGluZyBidXQgdGhleSdyZSBub3JtYWxseSBkb25lIHVzaW5nIFBJTyBh
bnl3YXkuDQoNCkkgd29uZGVyIHdoYXQgdGhlIGVuZCBnb2FsIGlzIGhlcmU/DQoNCkEgcmFuZG9t
IGNvbGxlY3Rpb24gb2Ygc3BpIG1hc3RlciBkcml2ZXJzIHdpbGwgYWNjZXB0IERNQS11bnNhZmUN
CmJ1ZmZlcnMgaW4gc29tZSB3YXkuICBJbiBzb21lIGNhc2VzIGEgZnJhbWV3b3JrIGxpa2Ugc3Bp
LW5vciBwcm92aWRlcw0KdGhlIGZpeHVwIHRvIHNwaS1ub3IgbWFzdGVyIGRyaXZlcnMgKG5vbmUg
c28gZmFyKSBhbmQgaW4gb3RoZXIgY2FzZXMNCihhdG1lbC1xdWFkc3BpKSwgdGhlIHNwaS1ub3Ig
bWFzdGVyIGRyaXZlciBoYXMgaXRzIG93biBmaXhlcy4NCg0KR2VuZXJpYyBzcGkgbWFzdGVycyBs
aWtlIHNwaS1hdG1lbCwgc3BpLXRpLXFzcGksIGFuZCBzcGktZGF2aW5jaSB3aWxsDQpoYXZlIHRo
ZWlyIGZpeGVzIGZvciBjZXJ0YWluIGNhc2VzLg0KDQpQZXJoYXBzIHNwaSBmbGFzaCBkcml2ZXJz
IGxpa2UgbTI1cDgwIHdpbGwgaGF2ZSBmaXhlcyB0b28/DQoNClNvbWUgc3BpIGNsaWVudHMsIGxp
a2Ugc3BpZGV2LCB3aWxsIGhhdmUgaW50ZXJuYWwgYm91bmNlIGJ1ZmZlcnMsDQpyYXRoZXIgdGhh
biB1c2Vyc3BhY2UgYWRkcmVzc2VzIG9yIGNvbW1hbmRzIGluIHN0YWNrIHZhcmlhYmxlcywgc28g
dGhhdA0KdGhleSBmb2xsb3cgdGhlIHJ1bGVzIGFib3V0IERNQSBzYWZlIGJ1ZmZlcnMuDQoNCldo
YXQgZXhhY3RseSBpcyBjYXVnaHQgYXMgRE1BIHVuc2FmZSBhbmQgd2hhdCBpcyBub3Qgd2lsbCBv
ZiBjb3Vyc2UNCnZhcnkgZ3JlYXRseSBmcm9tIGRyaXZlciB0byBkcml2ZXIuICBTb21lIGRyaXZl
cnMgd2lsbCBjYXRjaCBoaWdobWVtDQptZW1vcnkgd2hpbGUgb3RoZXIgZHJpdmVycyB3aWxsIG9u
bHkgZGV0ZWN0IHZtYWxsb2MgbWVtb3J5LiAgU29tZSB3aWxsDQpvbmx5IGNhdGNoIGFuIHVuc2Fm
ZSBidWZmZXIgaWYgYSBzcGVjaWZpYyBTb0Mga25vd24gdG8gdGhlIGRyaXZlciB0bw0KaGF2ZSBh
biBhbGlhc2luZyBjYWNoZSBpcyBlbmFibGVkLiAgU29tZSB3aWxsIGNoZWNrIGJ1ZmZlcnMgdGhh
dCBhcnJpdmUNCnZpYSB0aGUgc3BpX2ZsYXNoX3JlYWQgaW50ZXJmYWNlIGJ1dCBub3QgdmlhIGdl
bmVyaWMgc3BpIHRyYW5zZmVycywNCndoaWxlIG90aGVycyB3aWxsIGNoZWNrIGFsbCBzcGkgdHJh
bnNmZXIgYnVmZmVycy4NCg0KT2J2aW91c2x5LCBJIGRvbid0IHRoaW5rIHRoaXMgcGF0aCB3aWxs
IGxlYWQgdG8gYSBkZXNpcmFibGUgZW5kLiAgTWF5YmUNCnRoZSBiYXNpYyBhc3N1bXB0aW9uLCB0
aGF0IGNsaWVudHMgc2hvdWxkIHByb3ZpZGUgRE1BIHNhZmUgYnVmZmVycywNCnNob3VsZCBiZSBy
ZXZpc2l0ZWQuICBFeHBlcmllbmNlIGhhcyBzaG93biB0aGF0IGl0J3MgdG9vIG11Y2ggdG8gYXNr
DQpmb3IgYW5kIHNwaSBjbGllbnRzIHdpbGwgbmV2ZXIgZ2V0IGl0IHJpZ2h0LiAgSXQgd291bGQg
YmUgYmV0dGVyIHRvIHRyeQ0KdG8gZml4IHRoaXMgYXQgc29tZSBjb21tb24gcG9pbnQgYmV0d2Vl
biB0aGUgY2xpZW50cyBhbmQgbWFzdGVycyBzbyBpdA0KY2FuIGJlIGRvbmUgb25jZSBhbmQgZm9y
IGFsbC4=
