From: Robin Gong <yibin.gong@nxp.com>
Subject: Re: [EXT] Re: [PATCH v1 14/15] ARM: dts: imx6sll: correct ecspi/sdma
 compatible
Date: Wed, 24 Apr 2019 09:06:03 +0000
Message-ID: <1556096388.19638.3.camel@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
         <1556027045-5269-15-git-send-email-yibin.gong@nxp.com>
         <20190424063745.b67kcb3zzifuf22b@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.
To: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424063745.b67kcb3zzifuf22b@pengutronix.de>
Content-Language: en-US
Content-ID: <25D3ADAEEFCFE64E9C47CC15846B2303@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

T24gMjAxOS0wNC0yNCBhdCAwODozNyArMDIwMCwgcy5oYXVlckBwZW5ndXRyb25peC5kZSB3cm90
ZToNCj4gT24gVHVlLCBBcHIgMjMsIDIwMTkgYXQgMDE6NTE6NDVQTSArMDAwMCwgUm9iaW4gR29u
ZyB3cm90ZToNCj4gPiANCj4gPiBDb3JyZWN0IGVjc3BpL3NkbWEgY29tcGF0aWJsZSBzaW5jZSBl
Y3NwaSBlcnJhdGEgRVJSMDA5MTY1DQo+ID4gbm90IGZpeGVkIG9uIGkubXg2c2xsIGNoaXAuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0K
PiA+IC0tLQ0KPiA+IMKgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpIHwgMTAgKysrKyst
LS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNp
DQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kNCj4gPiBpbmRleCAxYjQ4OTlm
Li4wM2YyMTAzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwuZHRz
aQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwuZHRzaQ0KPiA+IEBAIC0xODMs
NyArMTgzLDcgQEANCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB9Ow0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVjc3BpMTogc3BpQDIwMDgwMDAg
ew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC0NCj4gPiBl
Y3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGli
bGUgPSJmc2wsaW14NTEtDQo+ID4gZWNzcGkiOw0KPiBXaGVyZSBpcyB0aGUgZnNsLGlteDZzbGwt
ZWNzcGkgY29tcGF0aWJsZSB0aGF0IHdvdWxkIGhhdmUgcHJldmVudGVkDQo+IHVzDQo+IGZyb20g
Y2hhbmdpbmcgdGhpcyBkZXZpY2V0cmVlIG5vdz8gWW91IHNob3VsZCBhdCBsZWFzdCBhZGQgaXQg
bm93Lg0KV2lsbCBhZGQgZnNsLGlteDZzbGwtZWNzcGkgaW4gVjIuDQo+IA0KPiBTYXNjaGENCj4g
DQo+IC0tDQo+IFBlbmd1dHJvbml4DQo+IGUuSy7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlv
bnPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy4NCj4gcHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cucGVu
Z3V0cm9uaXguZGUlMkYmYW1wO2RhDQo+IHRhPTAyJTdDMDElN0N5aWJpbi5nb25nJTQwbnhwLmNv
bSU3Q2ZhMWRhZTA3N2MxYzRiMTkxYjJmMDhkNmM4N2Y2MDE2JQ0KPiA3QzY4NmVhMWQzYmMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5MTY4NDY3Mjg2OTc5OTAmYW1wO3MNCj4g
ZGF0YT15VHI5ang3bElvZENFYVM2Q2IwbXdwa1NDMXN5R0dKdkZYb3g0ZDMlMkJuTUUlM0QmYW1w
O3Jlc2VydmVkPTDCoA0KPiDCoHwNCj4gUGVpbmVyIFN0ci4gNi04LCAzMTEzNyBIaWxkZXNoZWlt
LCBHZXJtYW55IHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0NCj4gMMKgwqDCoMKgfA0KPiBBbXRz
Z2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NsKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8IEZheDrC
oMKgwqArNDktNTEyMS0yMDY5MTctDQo+IDU1NTUgfA==
