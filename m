From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v2 13/15] ARM: dts: imx6ul: add dma support on ecspi
Date: Fri, 26 Apr 2019 08:06:21 +0000
Message-ID: <1556265512-9130-14-git-send-email-yibin.gong@nxp.com>
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

QWRkIGRtYSBzdXBwb3J0IG9uIGVjc3BpLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5
aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSB8
IDggKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZ1bC5kdHNpDQppbmRleCBiYmYwMTBjLi44ODBiOWVlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsLmR0c2kNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5kdHNp
DQpAQCAtMjI2LDYgKzIyNiw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlVMX0NMS19F
Q1NQSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTE+Ow0KIAkJCQkJY2xvY2st
bmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwgPCZzZG1h
IDQgNyAyPjsNCisJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KIAkJCQl9Ow0KIA0KQEAgLTIzOCw2ICsyNDAsOCBAQA0KIAkJCQkJY2xvY2tz
ID0gPCZjbGtzIElNWDZVTF9DTEtfRUNTUEkyPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZVTF9DTEtf
RUNTUEkyPjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KKwkJCQkJZG1hcyA9
IDwmc2RtYSA1IDcgMT4sIDwmc2RtYSA2IDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAi
dHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCkBAIC0yNTAsNiAr
MjU0LDggQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz4sDQogCQkJ
CQkJIDwmY2xrcyBJTVg2VUxfQ0xLX0VDU1BJMz47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGci
LCAicGVyIjsNCisJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8JnNkbWEgOCA3IDI+Ow0KKwkJ
CQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQog
CQkJCX07DQogDQpAQCAtMjYyLDYgKzI2OCw4IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1Y
NlVMX0NMS19FQ1NQSTQ+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlVMX0NMS19FQ1NQSTQ+Ow0KIAkJ
CQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQorCQkJCQlkbWFzID0gPCZzZG1hIDkgNyAx
PiwgPCZzZG1hIDEwIDcgMj47DQorCQkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KIAkJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCiANCi0tIA0KMi43LjQNCg0K
