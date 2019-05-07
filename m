From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v3 05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
Date: Tue, 7 May 2019 09:16:07 +0000
Message-ID: <1557249513-4903-6-git-send-email-yibin.gong@nxp.com>
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

QWRkIG1jdV8yX2Vjc3BpIHNjcmlwdCB0byBmaXggZWNzcGkgZXJyYXRhIEVSUjAwOTE2NS4NCg0K
U2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogZHJp
dmVycy9kbWEvaW14LXNkbWEuYyAgICAgICAgICAgICAgICAgICAgIHwgMyArKysNCiBpbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmggfCAxICsNCiAyIGZpbGVzIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEu
YyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDg2YTMxYjQuLjM1MmIwZDUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jDQpAQCAtOTI0LDYgKzkyNCw5IEBAIHN0YXRpYyB2b2lkIHNkbWFfZ2V0X3BjKHN0cnVjdCBz
ZG1hX2NoYW5uZWwgKnNkbWFjLA0KIAkJZW1pXzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5t
Y3VfMl9hdGFfYWRkcjsNCiAJCWJyZWFrOw0KIAljYXNlIElNWF9ETUFUWVBFX0NTUEk6DQorCQlw
ZXJfMl9lbWkgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPmFwcF8yX21jdV9hZGRyOw0KKwkJZW1pXzJf
cGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5tY3VfMl9lY3NwaV9hZGRyOw0KKwkJYnJlYWs7DQog
CWNhc2UgSU1YX0RNQVRZUEVfRVhUOg0KIAljYXNlIElNWF9ETUFUWVBFX1NTSToNCiAJY2FzZSBJ
TVhfRE1BVFlQRV9TQUk6DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRh
L2RtYS1pbXgtc2RtYS5oIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2Rt
YS5oDQppbmRleCA2ZWFhNTNjLi5mNzk0ZmVlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9w
bGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2RtYS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3Jt
X2RhdGEvZG1hLWlteC1zZG1hLmgNCkBAIC01MSw2ICs1MSw3IEBAIHN0cnVjdCBzZG1hX3Njcmlw
dF9zdGFydF9hZGRycyB7DQogCS8qIEVuZCBvZiB2MiBhcnJheSAqLw0KIAlzMzIgemNhbmZkXzJf
bWN1X2FkZHI7DQogCXMzMiB6cXNwaV8yX21jdV9hZGRyOw0KKwlzMzIgbWN1XzJfZWNzcGlfYWRk
cjsNCiAJLyogRW5kIG9mIHYzIGFycmF5ICovDQogfTsNCiANCi0tIA0KMi43LjQNCg0K
