From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 08/14] spi: imx: add new i.mx6ul compatible name in binding
 doc
Date: Wed, 22 May 2019 10:00:26 +0000
Message-ID: <1558548188-1155-9-git-send-email-yibin.gong@nxp.com>
References: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
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
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558548188-1155-1-git-send-email-yibin.gong@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

RVJSMDA5MTY1IGZpeGVkIGZyb20gaS5teDZ1bCwgYWRkIGl0cyBjb21wYXRpYmxlIG5hbWUgaW4g
YmluZGluZw0KZG9jLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54
cC5jb20+DQpBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KLS0tDQog
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9mc2wtaW14LWNzcGkudHh0IHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCmluZGV4
IDJkMzI2NDEuLmIzZDAyYTMgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL2ZzbC1pbXgtY3NwaS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zcGkvZnNsLWlteC1jc3BpLnR4dA0KQEAgLTEwLDYgKzEwLDcgQEAgUmVx
dWlyZWQgcHJvcGVydGllczoNCiAgIC0gImZzbCxpbXgzNS1jc3BpIiBmb3IgU1BJIGNvbXBhdGli
bGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDM1DQogICAtICJmc2wsaW14NTEtZWNz
cGkiIGZvciBTUEkgY29tcGF0aWJsZSB3aXRoIHRoZSBvbmUgaW50ZWdyYXRlZCBvbiBpLk1YNTEN
CiAgIC0gImZzbCxpbXg1My1lY3NwaSIgZm9yIFNQSSBjb21wYXRpYmxlIHdpdGggdGhlIG9uZSBp
bnRlZ3JhdGVkIG9uIGkuTVg1MyBhbmQgbGF0ZXIgU29jDQorICAtICJmc2wsaW14NnVsLWVjc3Bp
IiBmb3IgU1BJIGNvbXBhdGlibGUgd2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDZVTCBh
bmQgbGF0ZXIgU29jDQogICAtICJmc2wsaW14OG1xLWVjc3BpIiBmb3IgU1BJIGNvbXBhdGlibGUg
d2l0aCB0aGUgb25lIGludGVncmF0ZWQgb24gaS5NWDhNDQogLSByZWcgOiBPZmZzZXQgYW5kIGxl
bmd0aCBvZiB0aGUgcmVnaXN0ZXIgc2V0IGZvciB0aGUgZGV2aWNlDQogLSBpbnRlcnJ1cHRzIDog
U2hvdWxkIGNvbnRhaW4gQ1NQSS9lQ1NQSSBpbnRlcnJ1cHQNCi0tIA0KMi43LjQNCg0K
