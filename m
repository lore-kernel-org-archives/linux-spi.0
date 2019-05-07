From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v3 06/14] spi: imx: fix ERR009165
Date: Tue, 7 May 2019 09:16:13 +0000
Message-ID: <1557249513-4903-7-git-send-email-yibin.gong@nxp.com>
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

Q2hhbmdlIHRvIFhDSCAgbW9kZSBldmVuIGluIGRtYSBtb2RlLCBwbGVhc2UgcmVmZXIgdG8gdGhl
IGJlbG93DQplcnJhdGE6DQpodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZE
UUNFLnBkZg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+
DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktaW14LmMgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zcGkvc3BpLWlteC5jIGIvZHJpdmVycy9zcGkvc3BpLWlteC5jDQppbmRl
eCAwOWM5YTFlLi42Nzk1OTEwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zcGkvc3BpLWlteC5jDQor
KysgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCkBAIC01ODUsOCArNTg1LDkgQEAgc3RhdGljIGlu
dCBteDUxX2Vjc3BpX3ByZXBhcmVfdHJhbnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lt
eCwNCiAJY3RybCB8PSBteDUxX2Vjc3BpX2Nsa2RpdihzcGlfaW14LCB0LT5zcGVlZF9oeiwgJmNs
ayk7DQogCXNwaV9pbXgtPnNwaV9idXNfY2xrID0gY2xrOw0KIA0KKwkvKiBFUlIwMDkxNjU6IHdv
cmsgaW4gWEhDIG1vZGUgYXMgUElPICovDQogCWlmIChzcGlfaW14LT51c2VkbWEpDQotCQljdHJs
IHw9IE1YNTFfRUNTUElfQ1RSTF9TTUM7DQorCQljdHJsICY9IH5NWDUxX0VDU1BJX0NUUkxfU01D
Ow0KIA0KIAl3cml0ZWwoY3RybCwgc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfQ1RSTCk7DQog
DQpAQCAtNjEyLDEyICs2MTMsMTQgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBhcmVfdHJh
bnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwNCiANCiBzdGF0aWMgdm9pZCBteDUx
X3NldHVwX3dtbChzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14KQ0KIHsNCisJdTMyIHR4X3dt
bCA9IDA7DQorDQogCS8qDQogCSAqIENvbmZpZ3VyZSB0aGUgRE1BIHJlZ2lzdGVyOiBzZXR1cCB0
aGUgd2F0ZXJtYXJrDQogCSAqIGFuZCBlbmFibGUgRE1BIHJlcXVlc3QuDQogCSAqLw0KIAl3cml0
ZWwoTVg1MV9FQ1NQSV9ETUFfUlhfV01MKHNwaV9pbXgtPndtbCAtIDEpIHwNCi0JCU1YNTFfRUNT
UElfRE1BX1RYX1dNTChzcGlfaW14LT53bWwpIHwNCisJCU1YNTFfRUNTUElfRE1BX1RYX1dNTCh0
eF93bWwpIHwNCiAJCU1YNTFfRUNTUElfRE1BX1JYVF9XTUwoc3BpX2lteC0+d21sKSB8DQogCQlN
WDUxX0VDU1BJX0RNQV9URURFTiB8IE1YNTFfRUNTUElfRE1BX1JYREVOIHwNCiAJCU1YNTFfRUNT
UElfRE1BX1JYVERFTiwgc3BpX2lteC0+YmFzZSArIE1YNTFfRUNTUElfRE1BKTsNCkBAIC0xMTcx
LDcgKzExNzQsMTEgQEAgc3RhdGljIGludCBzcGlfaW14X2RtYV9jb25maWd1cmUoc3RydWN0IHNw
aV9tYXN0ZXIgKm1hc3RlcikNCiAJdHguZGlyZWN0aW9uID0gRE1BX01FTV9UT19ERVY7DQogCXR4
LmRzdF9hZGRyID0gc3BpX2lteC0+YmFzZV9waHlzICsgTVhDX0NTUElUWERBVEE7DQogCXR4LmRz
dF9hZGRyX3dpZHRoID0gYnVzd2lkdGg7DQotCXR4LmRzdF9tYXhidXJzdCA9IHNwaV9pbXgtPndt
bDsNCisJLyoNCisJICogRm9yIEVSUjAwOTE2NSB3aXRoIHR4X3dtbCA9IDAgY291bGQgZW5sYXJn
ZSBidXJzdCBzaXplIHRvIGZpZm8gc2l6ZQ0KKwkgKiB0byBzcGVlZCB1cCBmaWZvIGZpbGxpbmcg
YXMgcG9zc2libGUuDQorCSAqLw0KKwl0eC5kc3RfbWF4YnVyc3QgPSBzcGlfaW14LT5kZXZ0eXBl
X2RhdGEtPmZpZm9fc2l6ZTsNCiAJcmV0ID0gZG1hZW5naW5lX3NsYXZlX2NvbmZpZyhtYXN0ZXIt
PmRtYV90eCwgJnR4KTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2VycihzcGlfaW14LT5kZXYsICJU
WCBkbWEgY29uZmlndXJhdGlvbiBmYWlsZWQgd2l0aCAlZFxuIiwgcmV0KTsNCkBAIC0xMjY1LDEw
ICsxMjcyLDYgQEAgc3RhdGljIGludCBzcGlfaW14X3NkbWFfaW5pdChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgsDQogew0KIAlpbnQgcmV0Ow0KIA0KLQkv
KiB1c2UgcGlvIG1vZGUgZm9yIGkubXg2ZGwgY2hpcCBUS1QyMzgyODUgKi8NCi0JaWYgKG9mX21h
Y2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLGlteDZkbCIpKQ0KLQkJcmV0dXJuIDA7DQotDQogCXNw
aV9pbXgtPndtbCA9IHNwaV9pbXgtPmRldnR5cGVfZGF0YS0+Zmlmb19zaXplIC8gMjsNCiANCiAJ
LyogUHJlcGFyZSBmb3IgVFggRE1BOiAqLw0KLS0gDQoyLjcuNA0KDQo=
