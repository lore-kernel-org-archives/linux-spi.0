From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v2 14/15] ARM: dts: imx6sll: correct ecspi/sdma compatible
Date: Fri, 26 Apr 2019 08:06:26 +0000
Message-ID: <1556265512-9130-15-git-send-email-yibin.gong@nxp.com>
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

Q29ycmVjdCBlY3NwaS9zZG1hIGNvbXBhdGlibGUgc2luY2UgZWNzcGkgZXJyYXRhIEVSUjAwOTE2
NSB3aGljaA0KaXMgbm90IGZpeGVkIG9uIGkubXg2c2xsIGNoaXAuDQoNClNpZ25lZC1vZmYtYnk6
IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRz
L2lteDZzbGwuZHRzaSB8IDEwICsrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnNsbC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQppbmRleCAxYjQ4
OTlmLi5hYzA2NDcxIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNp
DQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kNCkBAIC0xODMsNyArMTgzLDcg
QEANCiAJCQkJfTsNCiANCiAJCQkJZWNzcGkxOiBzcGlAMjAwODAwMCB7DQotCQkJCQljb21wYXRp
YmxlID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCiAJCQkJCXJl
ZyA9IDwweDAyMDA4MDAwIDB4NDAwMD47DQogCQkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzEg
SVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwgPCZzZG1h
IDQgNyAyPjsNCkBAIC0xOTUsNyArMTk1LDcgQEANCiAJCQkJfTsNCiANCiAJCQkJZWNzcGkyOiBz
cGlAMjAwYzAwMCB7DQotCQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNs
LGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAi
ZnNsLGlteDUxLWVjc3BpIjsNCiAJCQkJCXJlZyA9IDwweDAyMDBjMDAwIDB4NDAwMD47DQogCQkJ
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlk
bWFzID0gPCZzZG1hIDUgNyAxPiwgPCZzZG1hIDYgNyAyPjsNCkBAIC0yMDcsNyArMjA3LDcgQEAN
CiAJCQkJfTsNCiANCiAJCQkJZWNzcGkzOiBzcGlAMjAxMDAwMCB7DQotCQkJCQljb21wYXRpYmxl
ID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGli
bGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCiAJCQkJCXJlZyA9
IDwweDAyMDEwMDAwIDB4NDAwMD47DQogCQkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzMgSVJR
X1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlkbWFzID0gPCZzZG1hIDcgNyAxPiwgPCZzZG1hIDgg
NyAyPjsNCkBAIC0yMTksNyArMjE5LDcgQEANCiAJCQkJfTsNCiANCiAJCQkJZWNzcGk0OiBzcGlA
MjAxNDAwMCB7DQotCQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlt
eDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDZzbGwtZWNzcGkiLCAiZnNs
LGlteDUxLWVjc3BpIjsNCiAJCQkJCXJlZyA9IDwweDAyMDE0MDAwIDB4NDAwMD47DQogCQkJCQlp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgMzQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCQlkbWFz
ID0gPCZzZG1hIDkgNyAxPiwgPCZzZG1hIDEwIDcgMj47DQpAQCAtNjE5LDcgKzYxOSw3IEBADQog
CQkJfTsNCiANCiAJCQlzZG1hOiBkbWEtY29udHJvbGxlckAyMGVjMDAwIHsNCi0JCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14NnNsbC1zZG1hIiwgImZzbCxpbXgzNS1zZG1hIjsNCisJCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14NnNsbC1zZG1hIiwgImZzbCxpbXg2cS1zZG1hIjsNCiAJCQkJcmVnID0g
PDB4MDIwZWMwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2U0xMX0NMS19JUEc+LA0K
LS0gDQoyLjcuNA0KDQo=
