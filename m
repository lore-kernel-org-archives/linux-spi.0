From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: Issues with i.MX SPI DMA transfers
Date: Thu, 28 Mar 2019 07:21:27 +0000
Message-ID: <VI1PR04MB45433F57929ABE7B5F8803B989590@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
To: Igor Plyatov <plyatov@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
        <u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWdvciBQbHlhdG92IDxw
bHlhdG92QGdtYWlsLmNvbT4NCj4gU2VudDogMjAxOeW5tDPmnIgyOOaXpSAxNTowNA0KPiBUbzog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT47IEZhYmlvIEVzdGV2YW0NCj4gPGZlc3RldmFtQGdtYWlsLmNvbT47
IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBTYXNj
aGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+Ow0KPiBkbWFlbmdp
bmVAdmdlci5rZXJuZWwub3JnOyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgRGFuIFdp
bGxpYW1zDQo+IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBBbmR5IER1YW4gPGZ1Z2FuZy5k
dWFuQG54cC5jb20+OyBIYW4gWHUNCj4gPGhhbi54dUBueHAuY29tPjsgUm9iaW4gR29uZyA8eWli
aW4uZ29uZ0BueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogSXNzdWVzIHdpdGggaS5NWCBTUEkgRE1BIHRyYW5zZmVycw0KPiANCj4g
RGVhciBVd2UsDQo+IA0KPiANCj4gPiBIZWxsbyBJZ29yLA0KPiA+DQo+ID4gT24gV2VkLCBNYXIg
MjcsIDIwMTkgYXQgMDg6NDA6MDBQTSArMDMwMCwgSWdvciBQbHlhdG92IHdyb3RlOg0KPiA+PiBw
bGVhc2UsIGhlbHAgdG8gcmVzb2x2ZSB0d28gaXNzdWVzIHdpdGggU1BJIERNQSB0cmFuc2ZlcnMg
YXQgaS5NWDZRDQo+ID4+IHBsYXRmb3JtLg0KPiA+Pg0KPiA+PiBGaXJzdCBpc3N1ZSBpcw0KPiA+
PiAgwqBbIDQ0NjUuMDA4MDAzXSBzcGlfbWFzdGVyIHNwaTA6IEkvTyBFcnJvciBpbiBETUEgUlgN
Cj4gPj4NCj4gPj4gU2Vjb25kIGlzc3VlIGlzIGR1cGxpY2F0aW9uIGZvciBvbmUgb2YgcmVjZWl2
ZWQgYnl0ZXMuDQo+ID4+DQo+ID4+IFByb2JhYmx5LCB0aGVzZSBpc3N1ZXMgcmVsYXRlZCB0byBl
YWNoIG9uZS4NCj4gPiBUaGlzIGlzIHByb2JhYmx5IHRoZSBzYW1lIHByb2JsZW0gSSBoaXQgc29t
ZSB0aW1lIGFnby4gQ2hlY2sgRVJSMDA5MTY1DQo+ID4gaW4gdGhlIGVycmF0YS4gWW91IGVpdGhl
ciBuZWVkIHRvIGRpc2FibGUgRE1BIG9yIG5lZWQgYSBmaXhlZA0KPiA+IHNkbWEtU2NyaXB0Lg0K
PiANCj4gZGlzYWJsaW5nIG9mIERNQSBpcyBub3QgYW4gb3B0aW9uLCBiZWNhdXNlIGhpZ2ggdGhy
b3VnaHB1dCByZXF1aXJlZCBmb3IgU1BJIGJ1cw0KPiB0byBjb21tdW5pY2F0ZSB3aXRoIERTUHMu
DQo+IA0KPiBJJ20gYXdhcmUgb2YgRVJSMDA5MTY1LCBidXQgYXMgSSB3cml0ZSBzb21lIG1pbnV0
ZXMgZWFybGllciB0byBsaXN0LA0KPiBzcGkwIChhbGlhcyBmb3IgZWNzcGkxKSBhbmQgc3BpMSAo
YWxpYXMgZm9yIGVjc3BpMikgd29yayBmbGF3bGVzcywgd2hpbGUNCj4gc3BpNCAoYWxpYXMgZm9y
IGVjc3BpNSkgZmFpbHMgdmVyeSBmYXN0Lg0KPiANCj4gRG9lcyBzYW1lIFNETUEgc2NyaXB0IHVz
ZWQgZm9yIGFsbCBTUEkgaW50ZXJmYWNlcyBvciBzY3JpcHRzIGFyZSBkaWZmZXJlbnQ/DQpObyBk
aWZmZXJlbnQgaGFuZGxlIGluc2lkZSBzZG1hIHNjcmlwdCBmb3IgZGlmZmVyZW50IGVjc3BpIHBv
cnQuIEFncmVlIFV3ZSwgeW91cg0KZHVwbGljYXRlIGRhdGEgY2F1Z2h0IHNlZW1zIGxpa2UgRVJS
MDA5MTY1LiBBbnl3YXkgSSdsbCBjcmVhdGUgZWNzcGkgcGF0Y2ggZm9yIHlvdQ0KdG8gdHJ5IGlu
IHRoZXNlIGRheXMuDQo+IA0KPiBCZXN0IHdpc2hlcy4NCj4gDQo+IC0tDQo+IA0KPiBJZ29yIFBs
eWF0b3YNCg0K
