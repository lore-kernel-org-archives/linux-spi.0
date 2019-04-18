From: Robin Gong <yibin.gong@nxp.com>
Subject: Re: Issues with i.MX SPI DMA transfers
Date: Thu, 18 Apr 2019 08:05:11 +0000
Message-ID: <1555574342.24617.3.camel@nxp.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
         <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
         <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
         <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
         <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
         <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <VI1PR04MB454302BAF353124ED13747DC892D0@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <VI1PR04MB4543A5CA46FBB3ACC9F3B3E289260@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <c9f24997-0112-8684-dc38-a6f8ba64c158@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutro
To: "plyatov@gmail.com" <plyatov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c9f24997-0112-8684-dc38-a6f8ba64c158@gmail.com>
Content-Language: en-US
Content-ID: <32EC64B3B22C6541BFA87235B8532033@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gMjAxOS0wNC0xOCBhdCAwNjozMCArMDAwMCwgSWdvciBQbHlhdG92IHdyb3RlOg0KPiBXQVJO
SU5HOiBUaGlzIGVtYWlsIHdhcyBjcmVhdGVkIG91dHNpZGUgb2YgTlhQLiBETyBOT1QgQ0xJQ0sg
bGlua3Mgb3INCj4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBh
bmQga25vdyB0aGUgY29udGVudCBpcw0KPiBzYWZlLg0KPiANCj4gDQo+IA0KPiBEZWFyIFJvYmlu
LA0KPiANCj4gPiANCj4gPiBIaSBJZ29yLA0KPiA+IMKgwqDCoMKgwqDCoERpZCB5b3UgbWVldCBh
bnkgaXNzdWUgd2l0aCBteSBsYXRlc3QgcGF0Y2g/DQo+IHNvcnJ5LCBidXQgdW5mb3J0dW5hdGVs
eSBJIGhhdmUgbm8gdGltZSB0byB0ZXN0IGl0Lg0KPiANCj4gSSBoYXZlIHN3aXRjaGVkIHRvIFBJ
TyBtb2RlIGFuZCBjb250aW51ZSBvdGhlciBkZXZlbG9wbWVudC4NCj4gDQo+IE1heWJlIGxhdGVy
IEkgd2lsbCBmaW5kIHRpbWUgdG8gdGVzdCBETUEgbW9kZSwgYnV0IG5vdCBzdXJlIHdoZW4uDQo+
IA0KPiBUaGFuayB5b3UgZm9yIHN1cHBvcnQhDQpPa2F5LCBJJ2xsIHNlbmQgb3V0IHBhdGNoIHNl
dCB0byByZXZpZXcsIGhvcGUgeW91IGNvdWxkIGhhdmUgY2hhbmNlIHRvDQp0cnkuDQo+IA0KPiAt
LQ0KPiANCj4gSWdvciBQbHlhdG92DQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUm9iaW4gR29uZw0KPiA+ID4gU2VudDogQXBy
aWwgOSwgMjAxOSAxMToyNj4NCj4gPiA+IEhpIElnb3IsDQo+ID4gPiDCoMKgwqDCoMKgUGxlYXNl
IGhhdmUgYSB0cnkgd2l0aCB0aGUgYXR0YWNoZWQgcGF0Y2hlcywgYW5kIHJldmVydA0KPiA+ID4g
MjVhYWE3NWRmMWU2LA0KPiA+ID4gYWQwZDkyZDdiYTZhICwgZGQ0YjQ4N2IzMmEzLCBkZjA3MTAx
ZTFjNGEgYmVmb3JlIGFwcGx5LiBCZXNpZGVzDQo+ID4gPiBYQ0gsIHR4DQo+ID4gPiB0aHJlc2gg
c2hvdWxkIGJlIHNldCB0byAwICwgbm93IG5vIGZhaWx1cmUgY2F1Z2h0IG9uIGVjc3BpNS4NCj4g
PiA+IA==
