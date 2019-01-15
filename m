From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v8 5/7] ARM: dts: ls1021a: Remove fsl,qspi-has-second-chip
 as it is not used
Date: Tue, 15 Jan 2019 15:24:01 +0000
Message-ID: <7ffa6d92-3fdd-f838-ab6d-185ea5f1c103@kontron.de>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
 <20190113033117.GG11426@dragon>
 <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
 <20190115151818.GD13895@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115151818.GD13895@dragon>
Content-Language: en-US
Content-ID: <A70D2C538BB6254E8E263CC9273AD2A0@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gMTUuMDEuMTkgMTY6MTgsIFNoYXduIEd1byB3cm90ZToNCj4gT24gTW9uLCBKYW4gMTQsIDIw
MTkgYXQgMDg6MTg6NDlBTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IEhpIFNo
YXduLA0KPj4NCj4+IE9uIDEzLjAxLjE5IDA0OjMxLCBTaGF3biBHdW8gd3JvdGU6DQo+Pj4gT24g
TW9uLCBKYW4gMDcsIDIwMTkgYXQgMDk6Mjk6NTRBTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3
cm90ZToNCj4+Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250
cm9uLmRlPg0KPj4+Pg0KPj4+PiBBZnRlciBzd2l0Y2hpbmcgdG8gdGhlIG5ldyBGU0wgUVNQSSBk
cml2ZXIgdGhlIHByb3BlcnR5DQo+Pj4+ICdmc2wscXNwaS1oYXMtc2Vjb25kLWNoaXAnIGlzIG5v
dCBuZWVkZWQgYW55bW9yZS4NCj4+Pj4NCj4+Pj4gVGhlIGRyaXZlciBub3cgdXNlcyB0aGUgJ3Jl
ZycgcHJvcGVydHkgdG8gZGV0ZXJtaW5lIHRoZSBidXMgYW5kDQo+Pj4+IHRoZSBjaGlwc2VsZWN0
Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNj
aHJlbXBmQGtvbnRyb24uZGU+DQo+Pj4NCj4+PiBBcHBsaWVkLCB0aGFua3MuDQo+Pg0KPj4gSSBq
dXN0IG5vdGljZWQsIHRoYXQgdGhpcyBhbmQgdGhlIGFybTY0IHBhdGNoIGRlcGVuZCBvbiB0aGUg
ZHJpdmVyDQo+PiBjaGFuZ2VzIGZvciA1LjEgdGhhdCBnbyB0aHJvdWdoIHRoZSBTUEkgdHJlZS4g
U28gSSBndWVzcyB3ZSBjYW4ndCBiZQ0KPj4gc3VyZSB0aGF0IHRoaXMgd2lsbCBiZSBtZXJnZWQg
aW4gdGhlIHJpZ2h0IG9yZGVyIGFuZCB3ZSBuZWVkIHRvIGRlbGF5DQo+PiB0aGlzIGNsZWFudXAg
dG8gNS4yLCBvciBhbSBJIHdyb25nPw0KPiANCj4gWW91IGFyZSByaWdodC4gIEkganVzdCBkcm9w
cGVkIHRoZSBib3RoIHBhdGNoZXMuICBQaW5nIG1lIG9yIHJlc2VuZCB3aGVuDQo+IHRoZXkgYXJl
IHJlYWR5IHRvIGdvLg0KDQpUaGFua3MsIHdpbGwgZG8gc28uDQoNCkZyaWVkZXI=
