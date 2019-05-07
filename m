From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v3 02/14] Revert "ARM: dts: imx6: Use correct SDMA script for
 SPI cores"
Date: Tue, 7 May 2019 09:15:47 +0000
Message-ID: <1557249513-4903-3-git-send-email-yibin.gong@nxp.com>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
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
To: "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
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
cmFuc2ZlciB0bw0KICAgICAgICAgICBiZSBzZW50IHR3aWNlDQpTbyByZXZlcnQgY29tbWl0ICdk
ZDRiNDg3YjMyYTMnIGZpcnN0bHkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaSB8IDgg
KysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQppbmRleCBiM2E3N2JjLi5hOTBmMjE3IDEwMDY0NA0K
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQorKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2cWRsLmR0c2kNCkBAIC0zMzksNyArMzM5LDcgQEANCiAJCQkJCWNsb2NrcyA9IDwm
Y2xrcyBJTVg2UURMX0NMS19FQ1NQSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFETF9DTEtfRUNT
UEkxPjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwm
c2RtYSAzIDggMT4sIDwmc2RtYSA0IDggMj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwg
PCZzZG1hIDQgNyAyPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KIAkJCQl9Ow0KQEAgLTM1Myw3ICszNTMsNyBAQA0KIAkJCQkJY2xv
Y2tzID0gPCZjbGtzIElNWDZRRExfQ0xLX0VDU1BJMj4sDQogCQkJCQkJIDwmY2xrcyBJTVg2UURM
X0NMS19FQ1NQSTI+Ow0KIAkJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQotCQkJCQlk
bWFzID0gPCZzZG1hIDUgOCAxPiwgPCZzZG1hIDYgOCAyPjsNCisJCQkJCWRtYXMgPSA8JnNkbWEg
NSA3IDE+LCA8JnNkbWEgNiA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJ
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQpAQCAtMzY3LDcgKzM2Nyw3IEBADQog
CQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEkzPiwNCiAJCQkJCQkgPCZjbGtz
IElNWDZRRExfQ0xLX0VDU1BJMz47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsN
Ci0JCQkJCWRtYXMgPSA8JnNkbWEgNyA4IDE+LCA8JnNkbWEgOCA4IDI+Ow0KKwkJCQkJZG1hcyA9
IDwmc2RtYSA3IDcgMT4sIDwmc2RtYSA4IDcgMj47DQogCQkJCQlkbWEtbmFtZXMgPSAicngiLCAi
dHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCkBAIC0zODEsNyArMzgx
LDcgQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19FQ1NQSTQ+LA0KIAkJCQkJ
CSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEk0PjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIs
ICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwmc2RtYSA5IDggMT4sIDwmc2RtYSAxMCA4IDI+Ow0KKwkJ
CQkJZG1hcyA9IDwmc2RtYSA5IDcgMT4sIDwmc2RtYSAxMCA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVz
ID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQotLSAN
CjIuNy40DQoNCg==
