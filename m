From: Schrempf Frieder <frieder.schrempf@kontron.De>
Subject: Re: [PATCH v4 06/10] ARM: defconfig: Use the new FSL QSPI driver
 under the SPI framework
Date: Mon, 12 Nov 2018 10:46:45 +0000
Message-ID: <b01d70ae-9feb-985a-8001-dba54206662d@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
 <1541601809-16950-7-git-send-email-frieder.schrempf@kontron.de>
 <CAOesGMgPwwwmizC+R4W1aLpvgcuVOYQr2qR2Vqb6171zGfarRw@mail.gmail.com>
 <b12936f5-871d-a982-13c5-9d894f4a1521@kontron.de>
 <20181108093451.08dfe63e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Olof Johansson <olof@lixom.net>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
        Sascha Hauer <s.hauer@pengutronix.de>,
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108093451.08dfe63e@bbrezillon>
Content-Language: en-US
Content-ID: <488850F0A853A84A8DE0BBCA83E1F7B7@snt-world.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gMDguMTEuMTggMDk6MzQsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gV2VkLCA3IE5v
diAyMDE4IDE2OjM2OjEzICswMDAwDQo+IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVt
cGZAa29udHJvbi5EZT4gd3JvdGU6DQo+IA0KPj4gSGkgT2xvZiwNCj4+DQo+PiBPbiAwNy4xMS4x
OCAxNzoyMCwgT2xvZiBKb2hhbnNzb24gd3JvdGU6DQo+Pj4gT24gV2VkLCBOb3YgNywgMjAxOCBh
dCA2OjQ0IEFNIEZyaWVkZXIgU2NocmVtcGYNCj4+PiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9u
LmRlPiB3cm90ZToNCj4+Pj4NCj4+Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5z
Y2hyZW1wZkBleGNlZXQuZGU+DQo+Pj4+DQo+Pj4+IFRoZSBuZXcgZHJpdmVyIGF0IHNwaS9zcGkt
ZnNsLXFzcGkuYyByZXBsYWNlcyB0aGUgb2xkIFNQSSBOT1IgZHJpdmVyDQo+Pj4+IGF0IG10ZC9m
c2wtcXVhZHNwaS5jLiBTd2l0Y2ggdG8gdGhlIG5ldyBkcml2ZXIgaW4gdGhlIGRlZmNvbmZpZ3Mu
DQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2No
cmVtcGZAZXhjZWV0LmRlPg0KPj4+DQo+Pj4gSGkgRnJpZWRlciwNCj4+Pg0KPj4+IFRoaXMgcGF0
Y2ggaXMgcGFydCBvZiBhIHNlcmllcyB0aGF0IEkgZGlkbid0IHNlZSB0aGUgcmVzdCBvZiwgYnV0
IGluDQo+Pj4gZ2VuZXJhbCB3ZSBwcmVmZXIgdG8gbWVyZ2UgdGhlc2UgdGhyb3VnaCBhcm0tc29j
IGV2ZW4gaWYgdGhlIGRyaXZlcg0KPj4+IGdvZXMgaW4gdGhyb3VnaCBhbm90aGVyIHRyZWUuIFRo
ZSB3YXkgd2UnZCBwcmVmZXIgdG8gaGFuZGxlIGl0IGlzIHRoYXQNCj4+PiBvbmNlIHRoZSBkcml2
ZXIgbGFuZHMsIHdlJ2xsIHRha2UgdGhlIGNvbmZpZyBvcHRpb24gY2hhbmdlIHRvIHR1cm4gaXQN
Cj4+PiBvbi4gVG8gYXZvaWQgb3VyIGJyYW5jaGVzIHRvIGJyZWFrIHVudGlsIGJvdGggc2lkZXMg
aGF2ZSBsYW5kZWQsIGl0DQo+Pj4gbWlnaHQgYmUgYSBnb29kIGlkZWEgdG8ga2VlcCBib3RoIGRy
aXZlcnMgb24gZm9yIGEgc2hvcnQgd2hpbGUgKG9uZQ0KPj4+IHJlbGVhc2UpLg0KPj4+DQo+Pj4g
U28sIEknbSBub3QgZ29pbmcgdG8gYWNrIHRoaXMgc2luY2Ugd2UgYXZvaWQgdGFraW5nIGRlZmNv
bmZpZyBjaGFuZ2VzDQo+Pj4gdGhyb3VnaCBkcml2ZXIgdHJlZXMgKHRoZXNlIHR3byBkZWZjb25m
aWdzIHRlbmQgdG8gY2h1cm4gYSBsb3QgYW5kIHdlDQo+Pj4gZG9uJ3Qgd2FudCB0byBjcmVhdGUg
bWVyZ2UgY29uZmxpY3RzIHdoZXJlIHdlIGRvbid0IGhhdmUgdG8pLCBidXQNCj4+PiB3ZSdsbCBi
ZSBoYXBweSB0byBwaWNrIGl0IHVwIHdoZW4gdGhlIHRpbWUgY29tZXMuDQo+Pg0KPj4gT2ssIHRo
YW5rIHlvdSBmb3IgZXhwbGFpbmluZyB0aGUgY29tbW9uIHByYWN0aWNlLiBJIHdpbGwgZHJvcCB0
aGUgY29uZmlnDQo+PiBjaGFuZ2VzIGZvciB0aGUgbmV4dCB2ZXJzaW9uIGFuZCBzZW5kIGl0IHNl
cGFyYXRlbHkgd2hlbiB0aGUgdGltZSBpcyByZWFkeS4NCj4+DQo+PiBCb3RoIHRoZSBvbGQgZHJp
dmVyIGFuZCB0aGUgbmV3IG9uZSB1c2UgdGhlIHNhbWUgY29tcGF0aWJsZSBzdHJpbmdzIGZvcg0K
Pj4gcHJvYmluZy4gV291bGRuJ3QgdGhhdCBjYXVzZSBwcm9ibGVtcyBpZiBib3RoIGRyaXZlcnMg
YXJlIGVuYWJsZWQgZm9yIGENCj4+IHdoaWxlLCBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0K
PiANCj4gT3IgbWF5YmUgd2Ugc2hvdWxkIG5vdCBpbnRyb2R1Y2UgYSBuZXcgS2NvbmZpZyBvcHRp
b24gYW5kIGp1c3QgcmV1c2UNCj4gdGhlIG9sZCBvbmUuIEl0IHByb2JhYmx5IHJlcXVpcmVzIHJl
LW9yZGVyaW5nIHBhdGNoZXMgYSBiaXQgKHBhdGNoIDENCj4gc2hvdWxkIGJlIG1vdmVkIGFmdGVy
IHBhdGNoIDUpLiBUaGVuIHlvdSBoYXZlIDIgY2hvaWNlczoNCj4gDQo+IDEvIG1lcmdlIHBhdGNo
IDEgYW5kIDYgc28gdGhhdCB0aGUgbmV3IGRyaXZlciBlZmZlY3RpdmVseSByZXBsYWNlcyB0aGUN
Cj4gICAgIG9sZCBvbmUgYnV0IHVzZXMgdGhlIHNhbWUgS2NvbmZpZyBvcHRpb24NCj4gMi8gcmVt
b3ZlIHRoZSBhYmlsaXR5IHRvIGNvbXBpbGUgdGhlIG9sZCBkcml2ZXIgd2hlbiB0aGUgbmV3IG9u
ZSBpcw0KPiAgICAgaW50cm9kdWNlZDogcmVtb3ZlIHRoZSBsaW5lIGZyb20gZHJpdmVycy9tdGQv
c3BpLW5vciBNYWtlZmlsZSBhbmQNCj4gICAgIG1vdmUgdGhlIEtjb25maWcgZW50cnkgZnJvbSBk
cml2ZXJzL210ZC9zcGktbm9yL0tjb25maWcgdG8NCj4gICAgIGRyaXZlcnMvc3BpL0tjb25maWcu
IEFuZCByZW1vdmUgdGhlIG9sZCBjb2RlIGluIGEgc2VwYXJhdGUgcGF0Y2gNCj4gDQo+IEknbSBm
aW5lIGVpdGhlciB3YXksIGJ1dCBvcHRpb24gIzIgd2lsbCBwcm9iYWJseSBtYWtlIHRoZSBwYXRj
aA0KPiBpbnRyb2R1Y2luZyB0aGUgbmV3IGRyaXZlciBiaWdnZXIgYW5kIGh1cnQgcmVhZGFiaWxp
dHkuDQoNCkkgdGhpbmsgaGF2aW5nIGJvdGggZHJpdmVycyBpbiB0aGUgdHJlZSBmb3IgYSB3aGls
ZSB3b3VsZG4ndCBiZSBzbyBiYWQuIA0KU28gaWYgYW55IGNvbXBhdGliaWxpdHkgaXNzdWVzIGNv
bWUgdXAgd2l0aCB0aGUgbmV3IGRyaXZlciwgcGVvcGxlIGNhbiANCnN0aWxsIHVzZSB0aGUgb2xk
IG9uZS4NCg0KVGhlcmVmb3JlIEkgdGhpbmsgSSB3aWxsIGRyb3AgdGhlIHBhdGNoZXMgdGhhdCBj
aGFuZ2UgdGhlIGRlZmNvbmZpZyBhbmQgDQpyZW1vdmUgdGhlIG9sZCBkcml2ZXIgY29kZSBhbmQg
a2VlcCB0aGUgZGlmZmVyZW50IEtjb25maWcgb3B0aW9ucy4gQW5kIA0KbWF5YmUgYWRkIGFuIGV4
Y2x1c2l2ZSBkZXBlbmRlbmN5IGluIEtjb25maWcsIHNvIGJvdGggZHJpdmVycyBjYW4gbm90IGJl
IA0KZW5hYmxlZCBhdCB0aGUgc2FtZSB0aW1lLg0KDQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8=
