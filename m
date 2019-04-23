From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 01/15] Revert "ARM: dts: imx6q: Use correct SDMA script for
 SPI5 core"
Date: Tue, 23 Apr 2019 13:50:39 +0000
Message-ID: <1556027045-5269-2-git-send-email-yibin.gong@nxp.com>
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

VGhpcyByZXZlcnRzIGNvbW1pdCBkZjA3MTAxZTFjNGEyOWU4MjBkZjAyZjk5ODlhMDY2OTg4YjE2
MGU2Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQot
LS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnEuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLmR0c2kNCmluZGV4
IGQwMzhmNDEuLjcxNzU4OTggMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cS5k
dHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS5kdHNpDQpAQCAtMTcyLDcgKzE3Miw3
IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFfQ0xLX0VDU1BJNT4sDQogCQkJCQkJIDwm
Y2xrcyBJTVg2UV9DTEtfRUNTUEk1PjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIi
Ow0KLQkJCQkJZG1hcyA9IDwmc2RtYSAxMSA4IDE+LCA8JnNkbWEgMTIgOCAyPjsNCisJCQkJCWRt
YXMgPSA8JnNkbWEgMTEgNyAxPiwgPCZzZG1hIDEyIDcgMj47DQogCQkJCQlkbWEtbmFtZXMgPSAi
cngiLCAidHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCi0tIA0KMi43
LjQNCg0K
