From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: Re: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma
 not work on i.mx8mm
Date: Tue, 21 May 2019 05:41:46 +0000
Message-ID: <VI1PR04MB4543DEEC702531ED69616B8C89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.
To: Vinod Koul <vkoul@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDE55bm0NeaciDIx5pelIDEzOjEzDQo+IA0KPiBPbiAyMS0w
NS0xOSwgMDQ6NTgsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj4gPiA+
IFNlbnQ6IDIwMTnlubQ15pyIMjHml6UgMTI6MTgNCj4gPiA+DQo+ID4gPiBPbiAwNy0wNS0xOSwg
MDk6MTYsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gPiA+IEJlY2F1c2UgdGhlIG51bWJlciBvZiBl
Y3NwaTEgcnggZXZlbnQgb24gaS5teDhtbSBpcyAwLCB0aGUNCj4gPiA+ID4gY29uZGl0aW9uIGNo
ZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBjaGFubmVsDQo+ID4gPiA+
IGVuYWJsZWQsIHdoaWNoIGNhdXNlZA0KPiA+ID4gPiBlY3NwaTEgcnggd29ya3MgZmFpbGVkLiBB
Y3R1YWxseSwgbm8gbmVlZCB0byBjaGVjayBldmVudF9pZDAsDQo+ID4gPiA+IGNoZWNraW5nDQo+
ID4gPiA+IGV2ZW50X2lkMSBpcyBlbm91Z2ggZm9yIERFVl8yX0RFViBjYXNlIGJlY2F1c2UgaXQn
cyBzbyBsdWNreSB0aGF0DQo+ID4gPiA+IGV2ZW50X2lkMSBuZXZlciBiZSAwLg0KPiA+ID4NCj4g
PiA+IFdlbGwgaXMgdGhhdCBieSBjaGFuY2Ugb3IgZGVzaWduIHRoYXQgZXZlbnRfaWQxIHdpbGwg
YmUgbmV2ZXIgMD8NCj4gPiA+DQo+ID4gVGhhdCdzIGJ5IGNoYW5jZS4gREVWXzJfREVWIGlzIGp1
c3QgZm9yIEF1ZGlvIGNhc2UgYW5kIG5vbi16ZXJvIGZvcg0KPiBldmVudF9pZDEgb24gY3VycmVu
dCBpLk1YIGZhbWlseS4NCj4gDQo+IFRoZW4gaXQgd29udCBiZSBmZ29vZCB0byByZWx5IG9uIGNo
YW5jZSA6KQ0KWWVzLCBJIGtuZXcgdGhhdC4gTWF5IEkgY3JlYXRlIGFub3RoZXIgaW5kZXBlbmRl
bnQgcGF0Y2ggZm9yIGV2ZW50X2lkMSBzaW5jZSB0aGF0J3MgcG90ZW50aWFsIGlzc3VlIGlzIG5v
dCByZWxhdGVkIHdpdGggdGhpcyBlY3NwaSBwYXRjaCBzZXQ/DQo+IA0KPiAtLQ0KPiB+Vmlub2QN
Cg==
