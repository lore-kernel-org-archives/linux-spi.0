From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work on
 i.mx8mm
Date: Wed, 22 May 2019 10:00:44 +0000
Message-ID: <1558548188-1155-12-git-send-email-yibin.gong@nxp.com>
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

QmVjYXVzZSB0aGUgbnVtYmVyIG9mIGVjc3BpMSByeCBldmVudCBvbiBpLm14OG1tIGlzIDAsIHRo
ZSBjb25kaXRpb24NCmNoZWNrIGlnbm9yZSBzdWNoIHNwZWNpYWwgY2FzZSB3aXRob3V0IGRtYSBj
aGFubmVsIGVuYWJsZWQsIHdoaWNoIGNhdXNlZA0KZWNzcGkxIHJ4IHdvcmtzIGZhaWxlZC4gQWN0
dWFsbHksIG5vIG5lZWQgdG8gY2hlY2sgZXZlbnRfaWQwL2V2ZW50X2lkMQ0KYW5kIHJlcGxhY2Ug
Y2hlY2tpbmcgJ2V2ZW50X2lkMScgd2l0aCAnRE1BX0RFVl9UT19ERVYnLCBzbyB0aGF0IGNvbmZp
Z3VyZQ0KZXZlbnRfaWQxIG9ubHkgaW4gY2FzZSBERVZfVE9fREVWLg0KDQpTaWduZWQtb2ZmLWJ5
OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2RtYS9pbXgt
c2RtYS5jIHwgMTggKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgt
c2RtYS5jIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KaW5kZXggYTQ5NWM3Zi4uYjY5Mjc4MyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL2lt
eC1zZG1hLmMNCkBAIC0xMjAyLDcgKzEyMDIsNyBAQCBzdGF0aWMgaW50IHNkbWFfY29uZmlnX2No
YW5uZWwoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KIAlpZiAoKHNkbWFjLT5wZXJpcGhlcmFsX3R5
cGUgIT0gSU1YX0RNQVRZUEVfTUVNT1JZKSAmJg0KIAkJCShzZG1hYy0+cGVyaXBoZXJhbF90eXBl
ICE9IElNWF9ETUFUWVBFX0RTUCkpIHsNCiAJCS8qIEhhbmRsZSBtdWx0aXBsZSBldmVudCBjaGFu
bmVscyBkaWZmZXJlbnRseSAqLw0KLQkJaWYgKHNkbWFjLT5ldmVudF9pZDEpIHsNCisJCWlmIChz
ZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fREVWKSB7DQogCQkJaWYgKHNkbWFjLT5wZXJp
cGhlcmFsX3R5cGUgPT0gSU1YX0RNQVRZUEVfQVNSQ19TUCB8fA0KIAkJCSAgICBzZG1hYy0+cGVy
aXBoZXJhbF90eXBlID09IElNWF9ETUFUWVBFX0FTUkMpDQogCQkJCXNkbWFfc2V0X3dhdGVybWFy
a2xldmVsX2Zvcl9wMnAoc2RtYWMpOw0KQEAgLTEzNzAsOSArMTM3MCw5IEBAIHN0YXRpYyB2b2lk
IHNkbWFfZnJlZV9jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pDQogDQogCXNk
bWFfY2hhbm5lbF9zeW5jaHJvbml6ZShjaGFuKTsNCiANCi0JaWYgKHNkbWFjLT5ldmVudF9pZDAp
DQotCQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0KLQlpZiAo
c2RtYWMtPmV2ZW50X2lkMSkNCisJc2RtYV9ldmVudF9kaXNhYmxlKHNkbWFjLCBzZG1hYy0+ZXZl
bnRfaWQwKTsNCisNCisJaWYgKHNkbWFjLT5kaXJlY3Rpb24gPT0gRE1BX0RFVl9UT19ERVYpDQog
CQlzZG1hX2V2ZW50X2Rpc2FibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDEpOw0KIA0KIAlzZG1h
Yy0+ZXZlbnRfaWQwID0gMDsNCkBAIC0xNjcwLDEzICsxNjcwLDExIEBAIHN0YXRpYyBpbnQgc2Rt
YV9jb25maWcoc3RydWN0IGRtYV9jaGFuICpjaGFuLA0KIAltZW1jcHkoJnNkbWFjLT5zbGF2ZV9j
b25maWcsIGRtYWVuZ2luZV9jZmcsIHNpemVvZigqZG1hZW5naW5lX2NmZykpOw0KIA0KIAkvKiBT
ZXQgRU5CTG4gZWFybGllciB0byBtYWtlIHN1cmUgZG1hIHJlcXVlc3QgdHJpZ2dlcmVkIGFmdGVy
IHRoYXQgKi8NCi0JaWYgKHNkbWFjLT5ldmVudF9pZDApIHsNCi0JCWlmIChzZG1hYy0+ZXZlbnRf
aWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KLQkJCXJldHVybiAtRUlO
VkFMOw0KLQkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDApOw0KLQl9
DQorCWlmIChzZG1hYy0+ZXZlbnRfaWQwID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZl
bnRzKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorCXNkbWFfZXZlbnRfZW5hYmxlKHNkbWFjLCBzZG1h
Yy0+ZXZlbnRfaWQwKTsNCiANCi0JaWYgKHNkbWFjLT5ldmVudF9pZDEpIHsNCisJaWYgKHNkbWFj
LT5kaXJlY3Rpb24gPT0gRE1BX0RFVl9UT19ERVYpIHsNCiAJCWlmIChzZG1hYy0+ZXZlbnRfaWQx
ID49IHNkbWFjLT5zZG1hLT5kcnZkYXRhLT5udW1fZXZlbnRzKQ0KIAkJCXJldHVybiAtRUlOVkFM
Ow0KIAkJc2RtYV9ldmVudF9lbmFibGUoc2RtYWMsIHNkbWFjLT5ldmVudF9pZDEpOw0KLS0gDQoy
LjcuNA0KDQo=
