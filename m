From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v2 01/15] Revert "ARM: dts: imx6q: Use correct SDMA script for
 SPI5 core"
Date: Fri, 26 Apr 2019 08:05:10 +0000
Message-ID: <1556265512-9130-2-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
To: "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

ICBUaGVyZSBhcmUgdHdvIHdheXMgZm9yIFNETUEgYWNjZXNzaW5nIFNQQkEgZGV2aWNlczogb25l
IGlzIFNETUEtPkFJUFMNCi0+U1BCQShtYXN0ZXJBIHBvcnQpLCBhbm90aGVyIGlzIFNETUEtPlNQ
QkEobWFzdGVyQyBwb3J0KS4gUGxlYXNlIHJlZmVyDQp0byB0aGUgJ0ZpZ3VyZSA1OC0xLiBpLk1Y
IDZEdWFsLzZRdWFkIFNQQkEgY29ubmVjdGl2aXR5JyBvZiBpLm14NkRRDQpSZWZlcmVuY2UgTWFu
dWFsLiBTRE1BIHByb3ZpZGUgdGhlIGNvcnJlc3BvbmRpbmcgYXBwXzJfbWN1L21jdV8yX2FwcCBh
bmQNCnNocF8yX21jdS9tY3VfMl9zaHAgc2NyaXB0IGZvciBzdWNoIHR3byBvcHRpb25zLiBTbyBi
b3RoIEFJUFMgYW5kIFNQQkENCnNjcmlwdHMgc2hvdWxkIGtlZXAgdGhlIHNhbWUgYmVoYXZpb3Vy
LCB0aGUgaXNzdWUgb25seSBjYXVnaHQgaW4gQUlQUw0Kc2NyaXB0IHNvdW5kcyBub3Qgc29saWRl
Lg0KICBUaGUgaXNzdWUgaXMgbW9yZSBsaWtlbHkgYXMgdGhlIGVjc3BpIGVycmF0YQ0KRVJSMDA5
MTY1KGh0dHA6Ly93d3cubnhwLmNvbS9kb2NzL2VuL2VycmF0YS9JTVg2RFFDRS5wZGYpOg0KZUNT
UEk6IFRYRklGTyBlbXB0eSBmbGFnIGdsaXRjaCBjYW4gY2F1c2UgdGhlIGN1cnJlbnQgRklGTyB0
cmFuc2ZlciB0bw0KICAgICAgIGJlIHNlbnQgdHdpY2UNClNvIHJldmVydCBjb21taXQgJ2RmMDcx
MDFlMWM0YScgZmlyc3RseS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29u
Z0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaSB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2
cS5kdHNpDQppbmRleCBkMDM4ZjQxLi43MTc1ODk4IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnEuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEuZHRzaQ0KQEAg
LTE3Miw3ICsxNzIsNyBAQA0KIAkJCQkJY2xvY2tzID0gPCZjbGtzIElNWDZRX0NMS19FQ1NQSTU+
LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFfQ0xLX0VDU1BJNT47DQogCQkJCQljbG9jay1uYW1lcyA9
ICJpcGciLCAicGVyIjsNCi0JCQkJCWRtYXMgPSA8JnNkbWEgMTEgOCAxPiwgPCZzZG1hIDEyIDgg
Mj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDExIDcgMT4sIDwmc2RtYSAxMiA3IDI+Ow0KIAkJCQkJ
ZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJ
CX07DQotLSANCjIuNy40DQoNCg==
