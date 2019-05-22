From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 04/14] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Date: Wed, 22 May 2019 10:00:02 +0000
Message-ID: <1558548188-1155-5-git-send-email-yibin.gong@nxp.com>
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

U2luY2Ugc2RtYV90cmFuc2Zlcl9pbml0KCkgd2lsbCBkbyBzZG1hX2xvYWRfY29udGV4dCBiZWZv
cmUgYW55DQpzZG1hIHRyYW5zZmVyLCBubyBuZWVkIG9uY2UgbW9yZSBpbiBzZG1hX2NvbmZpZ19j
aGFubmVsKCkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCkFja2VkLWJ5OiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KLS0tDQogZHJpdmVy
cy9kbWEvaW14LXNkbWEuYyB8IDUgKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5j
IGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KaW5kZXggNDA3YTU2ZS4uODZhMzFiNCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1h
LmMNCkBAIC0xMTM0LDcgKzExMzQsNiBAQCBzdGF0aWMgdm9pZCBzZG1hX3NldF93YXRlcm1hcmts
ZXZlbF9mb3JfcDJwKHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KIHN0YXRpYyBpbnQgc2Rt
YV9jb25maWdfY2hhbm5lbChzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pDQogew0KIAlzdHJ1Y3Qgc2Rt
YV9jaGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFuKTsNCi0JaW50IHJldDsNCiANCiAJ
c2RtYV9kaXNhYmxlX2NoYW5uZWwoY2hhbik7DQogDQpAQCAtMTE3NCw5ICsxMTczLDcgQEAgc3Rh
dGljIGludCBzZG1hX2NvbmZpZ19jaGFubmVsKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikNCiAJCXNk
bWFjLT53YXRlcm1hcmtfbGV2ZWwgPSAwOyAvKiBGSVhNRTogTTNfQkFTRV9BRERSRVNTICovDQog
CX0NCiANCi0JcmV0ID0gc2RtYV9sb2FkX2NvbnRleHQoc2RtYWMpOw0KLQ0KLQlyZXR1cm4gcmV0
Ow0KKwlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGludCBzZG1hX3NldF9jaGFubmVsX3ByaW9y
aXR5KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjLA0KLS0gDQoyLjcuNA0KDQo=
