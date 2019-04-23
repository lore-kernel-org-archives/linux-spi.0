From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 02/15] Revert "ARM: dts: imx6: Use correct SDMA script for
 SPI cores"
Date: Tue, 23 Apr 2019 13:50:46 +0000
Message-ID: <1556027045-5269-3-git-send-email-yibin.gong@nxp.com>
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

VGhpcyByZXZlcnRzIGNvbW1pdCBkZDRiNDg3YjMyYTM1NzFmZGNjNjYwNjJlNjYxZTNhM2UzNjBl
MzViLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQot
LS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kgfCA4ICsrKystLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZx
ZGwuZHRzaQ0KaW5kZXggYjNhNzdiYy4uYTkwZjIxNyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxZGwuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNp
DQpAQCAtMzM5LDcgKzMzOSw3IEBADQogCQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtf
RUNTUEkxPiwNCiAJCQkJCQkgPCZjbGtzIElNWDZRRExfQ0xLX0VDU1BJMT47DQogCQkJCQljbG9j
ay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCi0JCQkJCWRtYXMgPSA8JnNkbWEgMyA4IDE+LCA8JnNk
bWEgNCA4IDI+Ow0KKwkJCQkJZG1hcyA9IDwmc2RtYSAzIDcgMT4sIDwmc2RtYSA0IDcgMj47DQog
CQkJCQlkbWEtbmFtZXMgPSAicngiLCAidHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
CiAJCQkJfTsNCkBAIC0zNTMsNyArMzUzLDcgQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2
UURMX0NMS19FQ1NQSTI+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEkyPjsNCiAJ
CQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwmc2RtYSA1IDgg
MT4sIDwmc2RtYSA2IDggMj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDUgNyAxPiwgPCZzZG1hIDYg
NyAyPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KIAkJCQl9Ow0KQEAgLTM2Nyw3ICszNjcsNyBAQA0KIAkJCQkJY2xvY2tzID0gPCZj
bGtzIElNWDZRRExfQ0xLX0VDU1BJMz4sDQogCQkJCQkJIDwmY2xrcyBJTVg2UURMX0NMS19FQ1NQ
STM+Ow0KIAkJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQotCQkJCQlkbWFzID0gPCZz
ZG1hIDcgOCAxPiwgPCZzZG1hIDggOCAyPjsNCisJCQkJCWRtYXMgPSA8JnNkbWEgNyA3IDE+LCA8
JnNkbWEgOCA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQpAQCAtMzgxLDcgKzM4MSw3IEBADQogCQkJCQljbG9j
a3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEk0PiwNCiAJCQkJCQkgPCZjbGtzIElNWDZRRExf
Q0xLX0VDU1BJND47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCi0JCQkJCWRt
YXMgPSA8JnNkbWEgOSA4IDE+LCA8JnNkbWEgMTAgOCAyPjsNCisJCQkJCWRtYXMgPSA8JnNkbWEg
OSA3IDE+LCA8JnNkbWEgMTAgNyAyPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQog
CQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAkJCQl9Ow0KLS0gDQoyLjcuNA0KDQo=
