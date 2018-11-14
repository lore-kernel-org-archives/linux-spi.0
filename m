From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Wed, 14 Nov 2018 08:50:38 +0000
Message-ID: <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
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
In-Reply-To: <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-ID: <F9825BF6EF2E204790D63444BD5D6864@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgWW9nZXNoLA0KDQpPbiAxNC4xMS4xOCAwOTozOSwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90
ZToNCj4gSGkgRnJpZWRlciwNCj4gDQo+IEkgaGF2ZSB0cmllZCB2NSB2ZXJzaW9uIG9mIHRoZSBw
YXRjaCBhbmQgaGF2ZSBvYnNlcnZlZCB0aGF0IFJlYWQgaXMgZmFpbGluZyBmb3IgQ1MxLg0KDQpU
aGFua3MgYSBsb3QgZm9yIGRvaW5nIHRoZSB0ZXN0LiBJIHJlYWxseSBhcHByZWNpYXRlIGl0Lg0K
DQo+IEluIG15IHRhcmdldCAyIGZsYXNoIGRldmljZXMgYXJlIGNvbm5lY3RlZCBvbiBzYW1lIGJ1
cyBpLmUuIEExIC0+IENTMCBhbmQgQTIgLT4gQ1MxLg0KPiANCj4gT24gaW5pdGlhbCBkZWJ1Z2dp
bmcsIEkgZmlndXJlZCB0aGF0IFJlYWQgaXMgZmFpbGluZyBmb3IgdGhlIEFIQiBtb2RlIGkuZS4g
aWYgSSBhdHRlbXB0IHRvIHJlYWQgZGF0YSBzaXplIGxlc3MgdGhhbiByeGZpZm8gcmVhZCBpcyB3
b3JraW5nIGZpbmUgd2l0aG91dCBhbnkgaXNzdWUuDQo+IA0KPiBGb3IgZGF0YSBzaXplIG1vcmUg
dGhhbiByeGZpZm8gUmVhZCBvdXQgZGF0YSBpcyBjb250ZW50IG9mIHNhbWUgcmVxdWVzdGVkIGFk
ZHJlc3Mgb2YgQ1MwLg0KPiAJbXRkX2RlYnVnIHJlYWQgL2Rldi9tdGQxIDB4ZjAwMDAwIDB4NzAg
cmVhZCAtLT4gRGF0YSBpcyBjb3JyZWN0DQo+IAltdGRfZGVidWcgcmVhZCAvZGV2L210ZDEgMHhm
MDAwMDAgMHgxMDAgcmVhZCAtLT4gRGF0YSBpcyBpbi1jb3JyZWN0IGFuZCBkYXRhIGNvbnRlbnQg
YXJlIG9mIHRoZSBhZGRyZXNzIDB4ZjAwMDAwIG9mIENTMCBjb25uZWN0ZWQgZmxhc2ggZGV2aWNl
Lg0KDQpPaywgSSB3aWxsIGhhdmUgYSBsb29rIGF0IHdoYXQgY291bGQgbWFrZSB0aGUgY2hpcCBz
ZWxlY3Rpb24gZmFpbCBpbiANCmNhc2Ugb2YgQUhCIHJlYWQuDQoNCj4gT24gdGhlIHNldHVwIHdo
ZXJlIHlvdSBoYXZlIGRvbmUgdGVzdGluZywgZGlkIEFIQiBtb2RlIHJlYWQgaXMgYmVpbmcgdmVy
aWZpZWQgZm9yIENTMT8NCg0KTm8sIEkgY3VycmVudGx5IGhhdmUgb25seSBoYXJkd2FyZSB3aXRo
IENTMCBjb25uZWN0ZWQuIFNvIEkgZGlkbid0IHRlc3QgDQp3aXRoIENTMS4NCg0KPiANCj4gSSBh
bSBkb2luZyBmdXJ0aGVyIGRlYnVnZ2luZyBvZiB0aGlzIGlzc3VlLg0KDQpUaGFua3MsDQpGcmll
ZGVy
