From: Robin Gong <yibin.gong@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 06/15] spi: imx: fix ERR009165
Date: Fri, 26 Apr 2019 09:53:16 +0000
Message-ID: <1556272020.951.1.camel@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
         <1556269635.2584.23.camel@pengutronix.de>
         <1556270196.9298.16.camel@nxp.com>
         <1556271442.2584.29.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556271442.2584.29.camel@pengutronix.de>
Content-Language: en-US
Content-ID: <B1E243CA31B122469B45E9233F923901@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gMjAxOS0wNC0yNiBhdCAxMTozNyArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6DQo+IEFtIEZy
ZWl0YWcsIGRlbiAyNi4wNC4yMDE5LCAwOToyMiArMDAwMCBzY2hyaWViIFJvYmluIEdvbmc6DQo+
ID4gDQo+ID4gT24gMjAxOS0wNC0yNiBhdCAxMTowNyArMDIwMCwgTHVjYXMgU3RhY2ggd3JvdGU6
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gQW0gRnJlaXRhZywgZGVuIDI2LjA0LjIwMTksIDA4OjA1
ICswMDAwIHNjaHJpZWIgUm9iaW4gR29uZzoNCj4gPiA+ID4gDQo+ID4gPiA+IMKgc3RhdGljIHZv
aWQgbXg1MV9zZXR1cF93bWwoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCkNCj4gPiA+ID4g
wqB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgdTMyIHR4X3dtbCA9IDA7DQo+ID4gPiA+ICsNCj4gPiA+
IFdpdGggYSB3bWwgb2YgMCB5b3UgbWlnaHQgc2V0IHRoZSBtYXhidXJzdCBvZiB0aGUgVFggZG1h
IGNoYW5uZWwNCj4gPiA+IHRvDQo+ID4gPiBmaWZvc2l6ZSB0byBtaW5pbWl6ZSB0aGUgcGVyZm9y
bWFuY2UgaW1wYWN0IG9mIHRoaXMgd29ya2Fyb3VuZC4NCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywN
Cj4gPiA+IEx1Y2FzDQo+ID4gVW5mb3J0dW5hdGVseSwgdGhpcyBpcyBhIE1VU1QgcGFydCBvZiBl
cnJhdGEgd2hpY2ggY2F1c2UNCj4gPiBwZXJmb3JtYW5jZQ0KPiA+IGRyb3AuDQo+IEknbSBub3Qg
dGFsa2luZyBhYm91dCBjaGFuZ2luZyB0aGUgV01MLCBidXQgd2hlbiB0aGUgV01MIG11c3QgYmUg
MA0KPiB5b3UNCj4gY2FuIHNhZmVseSBpbmNyZWFzZSB0aGUgRE1BIGJ1cnN0IHNpemUgd2l0aG91
dCBvdmVyZmxvd2luZyB0aGUgRklGTywNCj4gd2hpY2ggbWlnaHQgcmVjb3ZlciBzb21lIG9mIG9m
IHRoZSBwZXJmb3JtYW5jZSBsb3NzLg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCkdvb2QgcG9p
bnQsIHdpbGwgYWRkIGl0IGluIFYzLCB0aGFua3Mu
