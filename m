From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 03/15] Revert "dmaengine: imx-sdma: refine to load context
 only once"
Date: Tue, 23 Apr 2019 13:50:50 +0000
Message-ID: <1556027045-5269-4-git-send-email-yibin.gong@nxp.com>
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

VGhpcyByZXZlcnRzIGNvbW1pdCBhZDBkOTJkN2JhNmFlY2JlMjcwNTkwN2MzOGZmOGQ4YmU0ZGEx
ZTljLCBiZWNhdXNlDQppbiBzcGktaW14IGNhc2UsIGJ1cnN0IGxlbmd0aCBtYXkgYmUgY2hhbmdl
ZCBkeW5hbWljYWxseS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0Bu
eHAuY29tPg0KLS0tDQogZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDcgLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14
LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCmluZGV4IDk5ZDlmNDMuLjQwN2E1NmUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9p
bXgtc2RtYS5jDQpAQCAtMzc3LDcgKzM3Nyw2IEBAIHN0cnVjdCBzZG1hX2NoYW5uZWwgew0KIAl1
bnNpZ25lZCBsb25nCQkJd2F0ZXJtYXJrX2xldmVsOw0KIAl1MzIJCQkJc2hwX2FkZHIsIHBlcl9h
ZGRyOw0KIAllbnVtIGRtYV9zdGF0dXMJCQlzdGF0dXM7DQotCWJvb2wJCQkJY29udGV4dF9sb2Fk
ZWQ7DQogCXN0cnVjdCBpbXhfZG1hX2RhdGEJCWRhdGE7DQogCXN0cnVjdCB3b3JrX3N0cnVjdAkJ
dGVybWluYXRlX3dvcmtlcjsNCiB9Ow0KQEAgLTk4OCw5ICs5ODcsNiBAQCBzdGF0aWMgaW50IHNk
bWFfbG9hZF9jb250ZXh0KHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KIAlpbnQgcmV0Ow0K
IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIA0KLQlpZiAoc2RtYWMtPmNvbnRleHRfbG9hZGVkKQ0K
LQkJcmV0dXJuIDA7DQotDQogCWlmIChzZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fTUVN
KQ0KIAkJbG9hZF9hZGRyZXNzID0gc2RtYWMtPnBjX2Zyb21fZGV2aWNlOw0KIAllbHNlIGlmIChz
ZG1hYy0+ZGlyZWN0aW9uID09IERNQV9ERVZfVE9fREVWKQ0KQEAgLTEwMzMsOCArMTAyOSw2IEBA
IHN0YXRpYyBpbnQgc2RtYV9sb2FkX2NvbnRleHQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMp
DQogDQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNkbWEtPmNoYW5uZWxfMF9sb2NrLCBmbGFn
cyk7DQogDQotCXNkbWFjLT5jb250ZXh0X2xvYWRlZCA9IHRydWU7DQotDQogCXJldHVybiByZXQ7
DQogfQ0KIA0KQEAgLTEwNzQsNyArMTA2OCw2IEBAIHN0YXRpYyB2b2lkIHNkbWFfY2hhbm5lbF90
ZXJtaW5hdGVfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogCXNkbWFjLT5kZXNjID0g
TlVMTDsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2RtYWMtPnZjLmxvY2ssIGZsYWdzKTsN
CiAJdmNoYW5fZG1hX2Rlc2NfZnJlZV9saXN0KCZzZG1hYy0+dmMsICZoZWFkKTsNCi0Jc2RtYWMt
PmNvbnRleHRfbG9hZGVkID0gZmFsc2U7DQogfQ0KIA0KIHN0YXRpYyBpbnQgc2RtYV9kaXNhYmxl
X2NoYW5uZWxfYXN5bmMoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KLS0gDQoyLjcuNA0KDQo=
