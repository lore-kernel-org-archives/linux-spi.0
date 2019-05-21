From: Robin Gong <yibin.gong@nxp.com>
Subject: RE:  Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not
 work on i.mx8mm
Date: Tue, 21 May 2019 04:58:38 +0000
Message-ID: <VI1PR04MB45436C98D70C16635CF3CFDE89070@VI1PR04MB4543.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
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
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDE5xOo11MIyMcjVIDEyOjE4DQo+IA0KPiBPbiAwNy0wNS0x
OSwgMDk6MTYsIFJvYmluIEdvbmcgd3JvdGU6DQo+ID4gQmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVj
c3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRoZSBjb25kaXRpb24NCj4gPiBjaGVjayBp
Z25vcmUgc3VjaCBzcGVjaWFsIGNhc2Ugd2l0aG91dCBkbWEgY2hhbm5lbCBlbmFibGVkLCB3aGlj
aA0KPiA+IGNhdXNlZA0KPiA+IGVjc3BpMSByeCB3b3JrcyBmYWlsZWQuIEFjdHVhbGx5LCBubyBu
ZWVkIHRvIGNoZWNrIGV2ZW50X2lkMCwgY2hlY2tpbmcNCj4gPiBldmVudF9pZDEgaXMgZW5vdWdo
IGZvciBERVZfMl9ERVYgY2FzZSBiZWNhdXNlIGl0J3Mgc28gbHVja3kgdGhhdA0KPiA+IGV2ZW50
X2lkMSBuZXZlciBiZSAwLg0KPiANCj4gV2VsbCBpcyB0aGF0IGJ5IGNoYW5jZSBvciBkZXNpZ24g
dGhhdCBldmVudF9pZDEgd2lsbCBiZSBuZXZlciAwPw0KPiANClRoYXQncyBieSBjaGFuY2UuIERF
Vl8yX0RFViBpcyBqdXN0IGZvciBBdWRpbyBjYXNlIGFuZCBub24temVybyBmb3IgZXZlbnRfaWQx
IG9uIGN1cnJlbnQgaS5NWCBmYW1pbHkuDQo=
