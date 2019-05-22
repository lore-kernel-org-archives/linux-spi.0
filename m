From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 05/14] dmaengine: imx-sdma: add mcu_2_ecspi script
Date: Wed, 22 May 2019 10:00:08 +0000
Message-ID: <1558548188-1155-6-git-send-email-yibin.gong@nxp.com>
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

QWRkIG1jdV8yX2Vjc3BpIHNjcmlwdCB0byBmaXggZWNzcGkgZXJyYXRhIEVSUjAwOTE2NS4NCg0K
U2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KQWNrZWQtYnk6
IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jICAgICAgICAgICAgICAgICAgICAgfCAzICsrKw0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1f
ZGF0YS9kbWEtaW14LXNkbWEuaCB8IDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9kbWEv
aW14LXNkbWEuYw0KaW5kZXggODZhMzFiNC4uMzUyYjBkNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
ZG1hL2lteC1zZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCkBAIC05MjQsNiAr
OTI0LDkgQEAgc3RhdGljIHZvaWQgc2RtYV9nZXRfcGMoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2Rt
YWMsDQogCQllbWlfMl9wZXIgPSBzZG1hLT5zY3JpcHRfYWRkcnMtPm1jdV8yX2F0YV9hZGRyOw0K
IAkJYnJlYWs7DQogCWNhc2UgSU1YX0RNQVRZUEVfQ1NQSToNCisJCXBlcl8yX2VtaSA9IHNkbWEt
PnNjcmlwdF9hZGRycy0+YXBwXzJfbWN1X2FkZHI7DQorCQllbWlfMl9wZXIgPSBzZG1hLT5zY3Jp
cHRfYWRkcnMtPm1jdV8yX2Vjc3BpX2FkZHI7DQorCQlicmVhazsNCiAJY2FzZSBJTVhfRE1BVFlQ
RV9FWFQ6DQogCWNhc2UgSU1YX0RNQVRZUEVfU1NJOg0KIAljYXNlIElNWF9ETUFUWVBFX1NBSToN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmgg
Yi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1hLWlteC1zZG1hLmgNCmluZGV4IDZlYWE1
M2MuLmY3OTRmZWUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvZG1h
LWlteC1zZG1hLmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14LXNk
bWEuaA0KQEAgLTUxLDYgKzUxLDcgQEAgc3RydWN0IHNkbWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHsN
CiAJLyogRW5kIG9mIHYyIGFycmF5ICovDQogCXMzMiB6Y2FuZmRfMl9tY3VfYWRkcjsNCiAJczMy
IHpxc3BpXzJfbWN1X2FkZHI7DQorCXMzMiBtY3VfMl9lY3NwaV9hZGRyOw0KIAkvKiBFbmQgb2Yg
djMgYXJyYXkgKi8NCiB9Ow0KIA0KLS0gDQoyLjcuNA0KDQo=
