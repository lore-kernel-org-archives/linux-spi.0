From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
Date: Wed, 7 Nov 2018 16:36:13 +0000
Message-ID: <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
 <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        Sascha Hauer <s.hauer@pengut
To: Olof Johansson <olof@lixom.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
Content-Language: en-US
Content-ID: <E3E8513E95EB0141883D08AD67B99E63@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SGkgT2xvZiwNCg0KT24gMDcuMTEuMTggMTc6MjAsIE9sb2YgSm9oYW5zc29uIHdyb3RlOg0KPiBP
biBXZWQsIE5vdiA3LCAyMDE4IGF0IDY6NDQgQU0gRnJpZWRlciBTY2hyZW1wZg0KPiA8ZnJpZWRl
ci5zY2hyZW1wZkBrb250cm9uLmRlPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJl
bXBmIDxmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZT4NCj4+DQo+PiBUaGUgbmV3IGRyaXZlciBh
dCBzcGkvc3BpLWZzbC1xc3BpLmMgcmVwbGFjZXMgdGhlIG9sZCBTUEkgTk9SIGRyaXZlcg0KPj4g
YXQgbXRkL2ZzbC1xdWFkc3BpLmMuIFN3aXRjaCB0byB0aGUgbmV3IGRyaXZlciBpbiB0aGUgZGVm
Y29uZmlncy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVy
LnNjaHJlbXBmQGV4Y2VldC5kZT4NCj4gDQo+IEhpIEZyaWVkZXIsDQo+IA0KPiBUaGlzIHBhdGNo
IGlzIHBhcnQgb2YgYSBzZXJpZXMgdGhhdCBJIGRpZG4ndCBzZWUgdGhlIHJlc3Qgb2YsIGJ1dCBp
bg0KPiBnZW5lcmFsIHdlIHByZWZlciB0byBtZXJnZSB0aGVzZSB0aHJvdWdoIGFybS1zb2MgZXZl
biBpZiB0aGUgZHJpdmVyDQo+IGdvZXMgaW4gdGhyb3VnaCBhbm90aGVyIHRyZWUuIFRoZSB3YXkg
d2UnZCBwcmVmZXIgdG8gaGFuZGxlIGl0IGlzIHRoYXQNCj4gb25jZSB0aGUgZHJpdmVyIGxhbmRz
LCB3ZSdsbCB0YWtlIHRoZSBjb25maWcgb3B0aW9uIGNoYW5nZSB0byB0dXJuIGl0DQo+IG9uLiBU
byBhdm9pZCBvdXIgYnJhbmNoZXMgdG8gYnJlYWsgdW50aWwgYm90aCBzaWRlcyBoYXZlIGxhbmRl
ZCwgaXQNCj4gbWlnaHQgYmUgYSBnb29kIGlkZWEgdG8ga2VlcCBib3RoIGRyaXZlcnMgb24gZm9y
IGEgc2hvcnQgd2hpbGUgKG9uZQ0KPiByZWxlYXNlKS4NCj4gDQo+IFNvLCBJJ20gbm90IGdvaW5n
IHRvIGFjayB0aGlzIHNpbmNlIHdlIGF2b2lkIHRha2luZyBkZWZjb25maWcgY2hhbmdlcw0KPiB0
aHJvdWdoIGRyaXZlciB0cmVlcyAodGhlc2UgdHdvIGRlZmNvbmZpZ3MgdGVuZCB0byBjaHVybiBh
IGxvdCBhbmQgd2UNCj4gZG9uJ3Qgd2FudCB0byBjcmVhdGUgbWVyZ2UgY29uZmxpY3RzIHdoZXJl
IHdlIGRvbid0IGhhdmUgdG8pLCBidXQNCj4gd2UnbGwgYmUgaGFwcHkgdG8gcGljayBpdCB1cCB3
aGVuIHRoZSB0aW1lIGNvbWVzLg0KDQpPaywgdGhhbmsgeW91IGZvciBleHBsYWluaW5nIHRoZSBj
b21tb24gcHJhY3RpY2UuIEkgd2lsbCBkcm9wIHRoZSBjb25maWcgDQpjaGFuZ2VzIGZvciB0aGUg
bmV4dCB2ZXJzaW9uIGFuZCBzZW5kIGl0IHNlcGFyYXRlbHkgd2hlbiB0aGUgdGltZSBpcyByZWFk
eS4NCg0KQm90aCB0aGUgb2xkIGRyaXZlciBhbmQgdGhlIG5ldyBvbmUgdXNlIHRoZSBzYW1lIGNv
bXBhdGlibGUgc3RyaW5ncyBmb3IgDQpwcm9iaW5nLiBXb3VsZG4ndCB0aGF0IGNhdXNlIHByb2Js
ZW1zIGlmIGJvdGggZHJpdmVycyBhcmUgZW5hYmxlZCBmb3IgYSANCndoaWxlLCBvciBhbSBJIG1p
c3Npbmcgc29tZXRoaW5nPw0KDQpUaGFua3MsDQpGcmllZGVyDQoNCj4gDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiAtT2xvZg0KPiA=
