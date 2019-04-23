From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 14/15] ARM: dts: imx6sll: correct ecspi/sdma compatible
Date: Tue, 23 Apr 2019 13:51:45 +0000
Message-ID: <1556027045-5269-15-git-send-email-yibin.gong@nxp.com>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
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
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Q29ycmVjdCBlY3NwaS9zZG1hIGNvbXBhdGlibGUgc2luY2UgZWNzcGkgZXJyYXRhIEVSUjAwOTE2
NQ0Kbm90IGZpeGVkIG9uIGkubXg2c2xsIGNoaXAuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdv
bmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbGwu
ZHRzaSB8IDEwICsrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5k
dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQppbmRleCAxYjQ4OTlmLi4wM2Yy
MTAzIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnNsbC5kdHNpDQorKysgYi9h
cmNoL2FybS9ib290L2R0cy9pbXg2c2xsLmR0c2kNCkBAIC0xODMsNyArMTgzLDcgQEANCiAJCQkJ
fTsNCiANCiAJCQkJZWNzcGkxOiBzcGlAMjAwODAwMCB7DQotCQkJCQljb21wYXRpYmxlID0gImZz
bCxpbXg2dWwtZWNzcGkiLCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJCWNvbXBhdGlibGUgPSJm
c2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMDgwMDAgMHg0MDAwPjsNCiAJCQkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSAzMSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJCQkJCWRt
YXMgPSA8JnNkbWEgMyA3IDE+LCA8JnNkbWEgNCA3IDI+Ow0KQEAgLTE5NSw3ICsxOTUsNyBAQA0K
IAkJCQl9Ow0KIA0KIAkJCQllY3NwaTI6IHNwaUAyMDBjMDAwIHsNCi0JCQkJCWNvbXBhdGlibGUg
PSAiZnNsLGlteDZ1bC1lY3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KKwkJCQkJY29tcGF0aWJs
ZSA9ICJmc2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMGMwMDAgMHg0MDAwPjsN
CiAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJ
CQkJCWRtYXMgPSA8JnNkbWEgNSA3IDE+LCA8JnNkbWEgNiA3IDI+Ow0KQEAgLTIwNyw3ICsyMDcs
NyBAQA0KIAkJCQl9Ow0KIA0KIAkJCQllY3NwaTM6IHNwaUAyMDEwMDAwIHsNCi0JCQkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDZ1bC1lY3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KKwkJCQkJY29t
cGF0aWJsZSA9ICJmc2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMTAwMDAgMHg0
MDAwPjsNCiAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzMyBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCiAJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8JnNkbWEgOCA3IDI+Ow0KQEAgLTIxOSw3
ICsyMTksNyBAQA0KIAkJCQl9Ow0KIA0KIAkJCQllY3NwaTQ6IHNwaUAyMDE0MDAwIHsNCi0JCQkJ
CWNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC1lY3NwaSIsICJmc2wsaW14NTEtZWNzcGkiOw0KKwkJ
CQkJY29tcGF0aWJsZSA9ICJmc2wsaW14NTEtZWNzcGkiOw0KIAkJCQkJcmVnID0gPDB4MDIwMTQw
MDAgMHg0MDAwPjsNCiAJCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAzNCBJUlFfVFlQRV9MRVZF
TF9ISUdIPjsNCiAJCQkJCWRtYXMgPSA8JnNkbWEgOSA3IDE+LCA8JnNkbWEgMTAgNyAyPjsNCkBA
IC02MTksNyArNjE5LDcgQEANCiAJCQl9Ow0KIA0KIAkJCXNkbWE6IGRtYS1jb250cm9sbGVyQDIw
ZWMwMDAgew0KLQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2c2xsLXNkbWEiLCAiZnNsLGlteDM1
LXNkbWEiOw0KKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2cS1zZG1hIiwgImZzbCxpbXgzNS1z
ZG1hIjsNCiAJCQkJcmVnID0gPDB4MDIwZWMwMDAgMHg0MDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrcyBJ
TVg2U0xMX0NMS19JUEc+LA0KLS0gDQoyLjcuNA0KDQo=
