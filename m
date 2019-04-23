From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 04/15] dmaengine: imx-sdma: remove dupilicated
 sdma_load_context
Date: Tue, 23 Apr 2019 13:50:55 +0000
Message-ID: <1556027045-5269-5-git-send-email-yibin.gong@nxp.com>
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

U2luY2Ugc2RtYV90cmFuc2Zlcl9pbml0KCkgd2lsbCBkbyBzZG1hX2xvYWRfY29udGV4dCBiZWZv
cmUgYW55DQpzZG1hIHRyYW5zZmVyLCBubyBuZWVkIG9uY2UgbW9yZSBpbiBzZG1hX2NvbmZpZ19j
aGFubmVsKCkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgfCAyIC0tDQogMSBmaWxlIGNoYW5nZWQs
IDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIv
ZHJpdmVycy9kbWEvaW14LXNkbWEuYw0KaW5kZXggNDA3YTU2ZS4uOGE4Y2U5OGEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5j
DQpAQCAtMTE3NCw4ICsxMTc0LDYgQEAgc3RhdGljIGludCBzZG1hX2NvbmZpZ19jaGFubmVsKHN0
cnVjdCBkbWFfY2hhbiAqY2hhbikNCiAJCXNkbWFjLT53YXRlcm1hcmtfbGV2ZWwgPSAwOyAvKiBG
SVhNRTogTTNfQkFTRV9BRERSRVNTICovDQogCX0NCiANCi0JcmV0ID0gc2RtYV9sb2FkX2NvbnRl
eHQoc2RtYWMpOw0KLQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCi0tIA0KMi43LjQNCg0K
