From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v3 08/14] dt-bindings: spi: imx: add new i.mx6ul compatible
 name
Date: Tue, 7 May 2019 09:16:25 +0000
Message-ID: <1557249513-4903-9-git-send-email-yibin.gong@nxp.com>
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

RVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgYWRkIGl0cyBjb21wYXRpYmxlIG5hbWUuDQoN
ClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCi0tLQ0KIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dCB8IDEg
Kw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0DQppbmRleCAy
ZDMyNjQxLi5iM2QwMmEzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCkBAIC0xMCw2ICsxMCw3IEBAIFJlcXVp
cmVkIHByb3BlcnRpZXM6DQogICAtICJmc2wsaW14MzUtY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxl
IHdpdGggdGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVgzNQ0KICAgLSAiZnNsLGlteDUxLWVjc3Bp
IiBmb3IgU1BJIGNvbXBhdGlibGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDUxDQog
ICAtICJmc2wsaW14NTMtZWNzcGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50
ZWdyYXRlZCBvbiBpLk1YNTMgYW5kIGxhdGVyIFNvYw0KKyAgLSAiZnNsLGlteDZ1bC1lY3NwaSIg
Zm9yIFNQSSBjb21wYXRpYmxlIHdpdGggdGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVg2VUwgYW5k
IGxhdGVyIFNvYw0KICAgLSAiZnNsLGlteDhtcS1lY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxlIHdp
dGggdGhlIG9uZSBpbnRlZ3JhdGVkIG9uIGkuTVg4TQ0KIC0gcmVnIDogT2Zmc2V0IGFuZCBsZW5n
dGggb2YgdGhlIHJlZ2lzdGVyIHNldCBmb3IgdGhlIGRldmljZQ0KIC0gaW50ZXJydXB0cyA6IFNo
b3VsZCBjb250YWluIENTUEkvZUNTUEkgaW50ZXJydXB0DQotLSANCjIuNy40DQoNCg==
