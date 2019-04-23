From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 05/15] dma: engine: imx-sdma: add mcu_2_ecspi script
Date: Tue, 23 Apr 2019 13:51:00 +0000
Message-ID: <1556027045-5269-6-git-send-email-yibin.gong@nxp.com>
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

QWRkIG1jdV8yX2Vjc3BpIHNjcmlwdCB0byBmaXggZWNzcGkgZXJyYXRhIEVSUjAwOTE2NS4NCg0K
U2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogZHJp
dmVycy9kbWEvaW14LXNkbWEuYyAgICAgICAgICAgICAgICAgICAgIHwgMyArKysNCiBpbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmggfCAxICsNCiAyIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEu
YyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDhhOGNlOThhLi4xZTIwNDcwIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KKysrIGIvZHJpdmVycy9kbWEvaW14LXNk
bWEuYw0KQEAgLTkyNCw2ICs5MjQsOSBAQCBzdGF0aWMgdm9pZCBzZG1hX2dldF9wYyhzdHJ1Y3Qg
c2RtYV9jaGFubmVsICpzZG1hYywNCiAJCWVtaV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+
bWN1XzJfYXRhX2FkZHI7DQogCQlicmVhazsNCiAJY2FzZSBJTVhfRE1BVFlQRV9DU1BJOg0KKwkJ
cGVyXzJfZW1pID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5hcHBfMl9tY3VfYWRkcjsNCisJCWVtaV8y
X3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+bWN1XzJfZWNzcGlfYWRkcjsNCisJCWJyZWFrOw0K
IAljYXNlIElNWF9ETUFUWVBFX0VYVDoNCiAJY2FzZSBJTVhfRE1BVFlQRV9TU0k6DQogCWNhc2Ug
SU1YX0RNQVRZUEVfU0FJOg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0
YS9kbWEtaW14LXNkbWEuaCBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNk
bWEuaA0KaW5kZXggNmVhYTUzYy4uZjc5NGZlZSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgv
cGxhdGZvcm1fZGF0YS9kbWEtaW14LXNkbWEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9y
bV9kYXRhL2RtYS1pbXgtc2RtYS5oDQpAQCAtNTEsNiArNTEsNyBAQCBzdHJ1Y3Qgc2RtYV9zY3Jp
cHRfc3RhcnRfYWRkcnMgew0KIAkvKiBFbmQgb2YgdjIgYXJyYXkgKi8NCiAJczMyIHpjYW5mZF8y
X21jdV9hZGRyOw0KIAlzMzIgenFzcGlfMl9tY3VfYWRkcjsNCisJczMyIG1jdV8yX2Vjc3BpX2Fk
ZHI7DQogCS8qIEVuZCBvZiB2MyBhcnJheSAqLw0KIH07DQogDQotLSANCjIuNy40DQoNCg==
