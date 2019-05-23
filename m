From: Robin Gong <yibin.gong@nxp.com>
Subject: RE:Re: [PATCH v4 00/14] add ecspi ERR009165 for i.mx6/7 soc family
Date: Thu, 23 May 2019 02:18:10 +0000
Message-ID: <VI1PR04MB45434A8AB7BC8B3DADBFCD5D89010@VI1PR04MB4543.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAxOeW5tDXmnIgyMuaXpSAxODoxMA0KPiBIaSBS
b2JpbiwNCj4gDQo+IEFtIE1pdHR3b2NoLCBkZW4gMjIuMDUuMjAxOSwgMDk6NTkgKzAwMDAgc2No
cmllYiBSb2JpbiBHb25nOg0KPiA+ICAgVGhlcmUgaXMgZWNzcGkgRVJSMDA5MTY1IG9uIGkubXg2
Lzcgc29jIGZhbWlseSwgd2hpY2ggY2F1c2UgRklGTw0KPiA+IHRyYW5zZmVyIHRvIGJlIHNlbmQg
dHdpY2UgaW4gRE1BIG1vZGUuIFBsZWFzZSBnZXQgbW9yZSBpbmZvcm1hdGlvbiBmcm9tOg0KPiA+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRnd3dy4NCj4gDQo+IEkgaGF2ZW4ndCB0ZXN0ZWQgdGhpcyBzbyBhc2tpbmcgdGhl
IG9idmlvdXMgcXVlc3Rpb246IHdoYXQgaGFwcGVucyB3aGVuIHRoaXMNCj4gc2VyaWVzIGlzIGFw
cGxpZWQgd2l0aG91dCB0aGUgUkFNIHNjcmlwdCBiZWluZyBwcmVzZW50IG9uIHRoZSBzeXN0ZW0/
IFdpbGwgaXQNCj4gcmVuZGVyIFNQSSB1bnVzYWJsZT8gSSBndWVzcyBzbyBzaW5jZSBpdCBjaGFu
Z2VzIHRoZSBmbG93IGJldHdlZW4gdGhlIFNQSSBjb3JlDQo+IGFuZCBETUEgY29udHJvbGxlci4g
Q2FuIHdlIHNvbWVob3cgZGV0ZWN0IHRoYXQgU0RNQSBpc24ndCB1c2luZyB0aGUgY29ycmVjdA0K
PiBSQU0gc2NyaXB0IGFuZCBmYWxsIGJhY2sgdG8gUElPIG1vZGUgaW4gdGhlIFNQSSBkcml2ZXIg
aW4gdGhhdCBjYXNlPw0KPiANCj4gQ3VycmVudGx5IHVzaW5nIHRoZSBSQU0gc2NyaXB0IGlzIG5v
dCBhbiBvcHRpb24gaW4gYSBsb3Qgb2YgdXNlLWNhc2VzLCBhcyBpdCBzdGlsbA0KPiBicmVha3Mg
c2VyaWFsIERNQSBzdXBwb3J0LiBUaGUgZml4IGZvciB0aGUgc2VyaWFsIGlzc3VlIHJlYWxseSBu
ZWVkcyB0byBiZQ0KPiByZW1vdmUgdGhlIGJyb2tlbiBzZXJpYWwgc2NyaXB0IGZyb20gdGhlIFJB
TSBmaXJtd2FyZSwgbm90IGNoYW5nZSB0aGUgc2VyaWFsDQo+IGRyaXZlciB0byBkZWFsIHdpdGgg
dGhlIGJyb2tlbiBiZWhhdmlvciBpbnRyb2R1Y2VkIGJ5IHRoZSBSQU0gc2NyaXB0Lg0KT2theSwg
SSdsbCB0cnkgdG8gbWVyZ2UgYW5vdGhlciBwYXRjaCB3aGljaCBmaXggVUFSVCBkcml2ZXIgZnVu
Y3Rpb24gYnJva2VuIGlzc3VlIHdpdGggcmFtIHNjcmlwdCBzbyB0aGF0IG5vIGFueSBicm9rZW4g
Zm9yIHRoaXMgcGF0Y2ggc2V0Lg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCg==
