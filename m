From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to state errata
 fixed
Date: Fri, 26 Apr 2019 08:05:51 +0000
Message-ID: <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
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

RVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgYWRkIGl0IHRvIHNob3cgdGhlIGVycmF0YSBm
aXhlZC4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0K
LS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGku
dHh0IHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4
dA0KaW5kZXggMmQzMjY0MS4uMzJjNDI2M2QgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dA0KQEAgLTEwLDYgKzEw
LDggQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAgIC0gImZzbCxpbXgzNS1jc3BpIiBmb3IgU1BJ
IGNvbXBhdGlibGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDM1DQogICAtICJmc2ws
aW14NTEtZWNzcGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50ZWdyYXRlZCBv
biBpLk1YNTENCiAgIC0gImZzbCxpbXg1My1lY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxlIHdpdGgg
dGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVg1MyBhbmQgbGF0ZXIgU29jDQorICAtICJmc2wsaW14
NnVsLWVjc3BpIiBFUlIwMDkxNjUgZml4ZWQgb24gaS5NWDZVTCBhbmQgbGF0ZXIgU29jDQorICAg
IChodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZEUUNFLnBkZikNCiAgIC0g
ImZzbCxpbXg4bXEtZWNzcGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50ZWdy
YXRlZCBvbiBpLk1YOE0NCiAtIHJlZyA6IE9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3Rl
ciBzZXQgZm9yIHRoZSBkZXZpY2UNCiAtIGludGVycnVwdHMgOiBTaG91bGQgY29udGFpbiBDU1BJ
L2VDU1BJIGludGVycnVwdA0KLS0gDQoyLjcuNA0KDQo=
