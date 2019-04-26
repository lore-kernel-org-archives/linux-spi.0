From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v2 11/15] dmaengine: imx-sdma: fix ecspi1 rx dma not work on
 i.mx8mm
Date: Fri, 26 Apr 2019 08:06:09 +0000
Message-ID: <1556265512-9130-12-git-send-email-yibin.gong@nxp.com>
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

QmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRo
ZSBjb25kaXRpb24NCmNoZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBj
aGFubmVsIGVuYWJsZWQsIHdoaWNoIGNhdXNlZA0KZWNzcGkxIHJ4IHdvcmtzIGZhaWxlZC4gQWN0
dWFsbHksIG5vIG5lZWQgdG8gY2hlY2sgZXZlbnRfaWQwLCBjaGVja2luZw0KZXZlbnRfaWQxIGlz
IGVub3VnaCBmb3IgREVWXzJfREVWIGNhc2UgYmVjYXVzZSBpdCdzIHNvIGx1Y2t5IHRoYXQgZXZl
bnRfaWQxDQpuZXZlciBiZSAwLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5n
b25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMTIgKysrKystLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jDQppbmRleCAzZTkxMmI2Li40YjJiN2NhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYw0KKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KQEAgLTEzNzEsOCArMTM3MSw4
IEBAIHN0YXRpYyB2b2lkIHNkbWFfZnJlZV9jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4g
KmNoYW4pDQogDQogCXNkbWFfY2hhbm5lbF9zeW5jaHJvbml6ZShjaGFuKTsNCiANCi0JaWYgKHNk
bWFjLT5ldmVudF9pZDApDQotCQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVu
dF9pZDApOw0KKwlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0K
Kw0KIAlpZiAoc2RtYWMtPmV2ZW50X2lkMSkNCiAJCXNkbWFfZXZlbnRfZGlzYWJsZShzZG1hYywg
c2RtYWMtPmV2ZW50X2lkMSk7DQogDQpAQCAtMTY3MSwxMSArMTY3MSw5IEBAIHN0YXRpYyBpbnQg
c2RtYV9jb25maWcoc3RydWN0IGRtYV9jaGFuICpjaGFuLA0KIAltZW1jcHkoJnNkbWFjLT5zbGF2
ZV9jb25maWcsIGRtYWVuZ2luZV9jZmcsIHNpemVvZigqZG1hZW5naW5lX2NmZykpOw0KIA0KIAkv
KiBTZXQgRU5CTG4gZWFybGllciB0byBtYWtlIHN1cmUgZG1hIHJlcXVlc3QgdHJpZ2dlcmVkIGFm
dGVyIHRoYXQgKi8NCi0JaWYgKHNkbWFjLT5ldmVudF9pZDApIHsNCi0JCWlmIChzZG1hYy0+ZXZl
bnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLQkJCXJldHVybiAt
RUlOVkFMOw0KLQkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0K
LQl9DQorCWlmIChzZG1hYy0+ZXZlbnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1f
ZXZlbnRzKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorCXNkbWFfZXZlbnRfZW5hYmxlKHNkbWFjLCBz
ZG1hYy0+ZXZlbnRfaWQwKTsNCiANCiAJaWYgKHNkbWFjLT5ldmVudF9pZDEpIHsNCiAJCWlmIChz
ZG1hYy0+ZXZlbnRfaWQxID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLS0g
DQoyLjcuNA0KDQo=
