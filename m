From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Wed, 14 Nov 2018 09:03:09 +0000
Message-ID: <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
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
In-Reply-To: <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
Content-Language: en-US
Content-ID: <12895E4EB0F7AD4789A6187064E7B09A@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgWW9nZXNoLA0KDQpPbiAxNC4xMS4xOCAwOTo1MCwgRnJpZWRlciBTY2hyZW1wZiB3cm90ZToN
Cj4gSGkgWW9nZXNoLA0KPiANCj4gT24gMTQuMTEuMTggMDk6MzksIFlvZ2VzaCBOYXJheWFuIEdh
dXIgd3JvdGU6DQo+PiBIaSBGcmllZGVyLA0KPj4NCj4+IEkgaGF2ZSB0cmllZCB2NSB2ZXJzaW9u
IG9mIHRoZSBwYXRjaCBhbmQgaGF2ZSBvYnNlcnZlZCB0aGF0IFJlYWQgaXMgDQo+PiBmYWlsaW5n
IGZvciBDUzEuDQo+IA0KPiBUaGFua3MgYSBsb3QgZm9yIGRvaW5nIHRoZSB0ZXN0LiBJIHJlYWxs
eSBhcHByZWNpYXRlIGl0Lg0KPiANCj4+IEluIG15IHRhcmdldCAyIGZsYXNoIGRldmljZXMgYXJl
IGNvbm5lY3RlZCBvbiBzYW1lIGJ1cyBpLmUuIEExIC0+IENTMCANCj4+IGFuZCBBMiAtPiBDUzEu
DQo+Pg0KPj4gT24gaW5pdGlhbCBkZWJ1Z2dpbmcsIEkgZmlndXJlZCB0aGF0IFJlYWQgaXMgZmFp
bGluZyBmb3IgdGhlIEFIQiBtb2RlIA0KPj4gaS5lLiBpZiBJIGF0dGVtcHQgdG8gcmVhZCBkYXRh
IHNpemUgbGVzcyB0aGFuIHJ4ZmlmbyByZWFkIGlzIHdvcmtpbmcgDQo+PiBmaW5lIHdpdGhvdXQg
YW55IGlzc3VlLg0KPj4NCj4+IEZvciBkYXRhIHNpemUgbW9yZSB0aGFuIHJ4ZmlmbyBSZWFkIG91
dCBkYXRhIGlzIGNvbnRlbnQgb2Ygc2FtZSANCj4+IHJlcXVlc3RlZCBhZGRyZXNzIG9mIENTMC4N
Cj4+IMKgwqDCoMKgbXRkX2RlYnVnIHJlYWQgL2Rldi9tdGQxIDB4ZjAwMDAwIDB4NzAgcmVhZCAt
LT4gRGF0YSBpcyBjb3JyZWN0DQo+PiDCoMKgwqDCoG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkMSAw
eGYwMDAwMCAweDEwMCByZWFkIC0tPiBEYXRhIGlzIA0KPj4gaW4tY29ycmVjdCBhbmQgZGF0YSBj
b250ZW50IGFyZSBvZiB0aGUgYWRkcmVzcyAweGYwMDAwMCBvZiBDUzAgDQo+PiBjb25uZWN0ZWQg
Zmxhc2ggZGV2aWNlLg0KPiANCj4gT2ssIEkgd2lsbCBoYXZlIGEgbG9vayBhdCB3aGF0IGNvdWxk
IG1ha2UgdGhlIGNoaXAgc2VsZWN0aW9uIGZhaWwgaW4gDQo+IGNhc2Ugb2YgQUhCIHJlYWQuDQoN
CkNvdWxkIHlvdSB0cnkgd2l0aCB0aGlzIGNoYW5nZSBhcHBsaWVkOg0KDQpAQCAtNTAzLDcgKzUw
Myw3IEBAIHN0YXRpYyB2b2lkIGZzbF9xc3BpX3NlbGVjdF9tZW0oc3RydWN0IGZzbF9xc3BpICpx
LCANCnN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQogICAgICAgICAgICAgICAgICAgICAgICAgbWFw
X2FkZHIgPSBxLT5tZW1tYXBfcGh5Ow0KICAgICAgICAgICAgICAgICBlbHNlDQogICAgICAgICAg
ICAgICAgICAgICAgICAgbWFwX2FkZHIgPSBxLT5tZW1tYXBfcGh5ICsNCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMiAqIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplOw0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9i
dWZfc2l6ZTsNCg0KICAgICAgICAgICAgICAgICBxc3BpX3dyaXRlbChxLCBtYXBfYWRkciwgcS0+
aW9iYXNlICsgUVVBRFNQSV9TRkExQUQgKyANCihpICogNCkpOw0KICAgICAgICAgfQ0KDQo+IA0K
Pj4gT24gdGhlIHNldHVwIHdoZXJlIHlvdSBoYXZlIGRvbmUgdGVzdGluZywgZGlkIEFIQiBtb2Rl
IHJlYWQgaXMgYmVpbmcgDQo+PiB2ZXJpZmllZCBmb3IgQ1MxPw0KPiANCj4gTm8sIEkgY3VycmVu
dGx5IGhhdmUgb25seSBoYXJkd2FyZSB3aXRoIENTMCBjb25uZWN0ZWQuIFNvIEkgZGlkbid0IHRl
c3QgDQo+IHdpdGggQ1MxLg0KPiANCj4+DQo+PiBJIGFtIGRvaW5nIGZ1cnRoZXIgZGVidWdnaW5n
IG9mIHRoaXMgaXNzdWUuDQo+IA0KPiBUaGFua3MsDQo+IEZyaWVkZXI=
