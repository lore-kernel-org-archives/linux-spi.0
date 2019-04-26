From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v2 04/15] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Date: Fri, 26 Apr 2019 08:05:28 +0000
Message-ID: <1556265512-9130-5-git-send-email-yibin.gong@nxp.com>
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

U2luY2Ugc2RtYV90cmFuc2Zlcl9pbml0KCkgd2lsbCBkbyBzZG1hX2xvYWRfY29udGV4dCBiZWZv
cmUgYW55DQpzZG1hIHRyYW5zZmVyLCBubyBuZWVkIG9uY2UgbW9yZSBpbiBzZG1hX2NvbmZpZ19j
aGFubmVsKCkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgfCA1ICstLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDQwN2E1NmUu
Ljg2YTMxYjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2
ZXJzL2RtYS9pbXgtc2RtYS5jDQpAQCAtMTEzNCw3ICsxMTM0LDYgQEAgc3RhdGljIHZvaWQgc2Rt
YV9zZXRfd2F0ZXJtYXJrbGV2ZWxfZm9yX3AycChzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYykN
CiBzdGF0aWMgaW50IHNkbWFfY29uZmlnX2NoYW5uZWwoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0K
IHsNCiAJc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMgPSB0b19zZG1hX2NoYW4oY2hhbik7DQot
CWludCByZXQ7DQogDQogCXNkbWFfZGlzYWJsZV9jaGFubmVsKGNoYW4pOw0KIA0KQEAgLTExNzQs
OSArMTE3Myw3IEBAIHN0YXRpYyBpbnQgc2RtYV9jb25maWdfY2hhbm5lbChzdHJ1Y3QgZG1hX2No
YW4gKmNoYW4pDQogCQlzZG1hYy0+d2F0ZXJtYXJrX2xldmVsID0gMDsgLyogRklYTUU6IE0zX0JB
U0VfQUREUkVTUyAqLw0KIAl9DQogDQotCXJldCA9IHNkbWFfbG9hZF9jb250ZXh0KHNkbWFjKTsN
Ci0NCi0JcmV0dXJuIHJldDsNCisJcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBpbnQgc2RtYV9z
ZXRfY2hhbm5lbF9wcmlvcml0eShzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYywNCi0tIA0KMi43
LjQNCg0K
