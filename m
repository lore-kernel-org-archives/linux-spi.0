From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 06/14] spi: imx: fix ERR009165
Date: Wed, 22 May 2019 10:00:14 +0000
Message-ID: <1558548188-1155-7-git-send-email-yibin.gong@nxp.com>
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

Q2hhbmdlIHRvIFhDSCAgbW9kZSBldmVuIGluIGRtYSBtb2RlLCBwbGVhc2UgcmVmZXIgdG8gdGhl
IGJlbG93DQplcnJhdGE6DQpodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZE
UUNFLnBkZg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+
DQpBY2tlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KLS0tDQogZHJpdmVy
cy9zcGkvc3BpLWlteC5jIHwgMTcgKysrKysrKysrKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c3BpL3NwaS1pbXguYyBiL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0KaW5kZXggMDljOWExZS4uNjc5
NTkxMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYw0KKysrIGIvZHJpdmVycy9z
cGkvc3BpLWlteC5jDQpAQCAtNTg1LDggKzU4NSw5IEBAIHN0YXRpYyBpbnQgbXg1MV9lY3NwaV9w
cmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgsDQogCWN0cmwgfD0g
bXg1MV9lY3NwaV9jbGtkaXYoc3BpX2lteCwgdC0+c3BlZWRfaHosICZjbGspOw0KIAlzcGlfaW14
LT5zcGlfYnVzX2NsayA9IGNsazsNCiANCisJLyogRVJSMDA5MTY1OiB3b3JrIGluIFhIQyBtb2Rl
IGFzIFBJTyAqLw0KIAlpZiAoc3BpX2lteC0+dXNlZG1hKQ0KLQkJY3RybCB8PSBNWDUxX0VDU1BJ
X0NUUkxfU01DOw0KKwkJY3RybCAmPSB+TVg1MV9FQ1NQSV9DVFJMX1NNQzsNCiANCiAJd3JpdGVs
KGN0cmwsIHNwaV9pbXgtPmJhc2UgKyBNWDUxX0VDU1BJX0NUUkwpOw0KIA0KQEAgLTYxMiwxMiAr
NjEzLDE0IEBAIHN0YXRpYyBpbnQgbXg1MV9lY3NwaV9wcmVwYXJlX3RyYW5zZmVyKHN0cnVjdCBz
cGlfaW14X2RhdGEgKnNwaV9pbXgsDQogDQogc3RhdGljIHZvaWQgbXg1MV9zZXR1cF93bWwoc3Ry
dWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCkNCiB7DQorCXUzMiB0eF93bWwgPSAwOw0KKw0KIAkv
Kg0KIAkgKiBDb25maWd1cmUgdGhlIERNQSByZWdpc3Rlcjogc2V0dXAgdGhlIHdhdGVybWFyaw0K
IAkgKiBhbmQgZW5hYmxlIERNQSByZXF1ZXN0Lg0KIAkgKi8NCiAJd3JpdGVsKE1YNTFfRUNTUElf
RE1BX1JYX1dNTChzcGlfaW14LT53bWwgLSAxKSB8DQotCQlNWDUxX0VDU1BJX0RNQV9UWF9XTUwo
c3BpX2lteC0+d21sKSB8DQorCQlNWDUxX0VDU1BJX0RNQV9UWF9XTUwodHhfd21sKSB8DQogCQlN
WDUxX0VDU1BJX0RNQV9SWFRfV01MKHNwaV9pbXgtPndtbCkgfA0KIAkJTVg1MV9FQ1NQSV9ETUFf
VEVERU4gfCBNWDUxX0VDU1BJX0RNQV9SWERFTiB8DQogCQlNWDUxX0VDU1BJX0RNQV9SWFRERU4s
IHNwaV9pbXgtPmJhc2UgKyBNWDUxX0VDU1BJX0RNQSk7DQpAQCAtMTE3MSw3ICsxMTc0LDExIEBA
IHN0YXRpYyBpbnQgc3BpX2lteF9kbWFfY29uZmlndXJlKHN0cnVjdCBzcGlfbWFzdGVyICptYXN0
ZXIpDQogCXR4LmRpcmVjdGlvbiA9IERNQV9NRU1fVE9fREVWOw0KIAl0eC5kc3RfYWRkciA9IHNw
aV9pbXgtPmJhc2VfcGh5cyArIE1YQ19DU1BJVFhEQVRBOw0KIAl0eC5kc3RfYWRkcl93aWR0aCA9
IGJ1c3dpZHRoOw0KLQl0eC5kc3RfbWF4YnVyc3QgPSBzcGlfaW14LT53bWw7DQorCS8qDQorCSAq
IEZvciBFUlIwMDkxNjUgd2l0aCB0eF93bWwgPSAwIGNvdWxkIGVubGFyZ2UgYnVyc3Qgc2l6ZSB0
byBmaWZvIHNpemUNCisJICogdG8gc3BlZWQgdXAgZmlmbyBmaWxsaW5nIGFzIHBvc3NpYmxlLg0K
KwkgKi8NCisJdHguZHN0X21heGJ1cnN0ID0gc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT5maWZvX3Np
emU7DQogCXJldCA9IGRtYWVuZ2luZV9zbGF2ZV9jb25maWcobWFzdGVyLT5kbWFfdHgsICZ0eCk7
DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoc3BpX2lteC0+ZGV2LCAiVFggZG1hIGNvbmZpZ3Vy
YXRpb24gZmFpbGVkIHdpdGggJWRcbiIsIHJldCk7DQpAQCAtMTI2NSwxMCArMTI3Miw2IEBAIHN0
YXRpYyBpbnQgc3BpX2lteF9zZG1hX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc3Bp
X2lteF9kYXRhICpzcGlfaW14LA0KIHsNCiAJaW50IHJldDsNCiANCi0JLyogdXNlIHBpbyBtb2Rl
IGZvciBpLm14NmRsIGNoaXAgVEtUMjM4Mjg1ICovDQotCWlmIChvZl9tYWNoaW5lX2lzX2NvbXBh
dGlibGUoImZzbCxpbXg2ZGwiKSkNCi0JCXJldHVybiAwOw0KLQ0KIAlzcGlfaW14LT53bWwgPSBz
cGlfaW14LT5kZXZ0eXBlX2RhdGEtPmZpZm9fc2l6ZSAvIDI7DQogDQogCS8qIFByZXBhcmUgZm9y
IFRYIERNQTogKi8NCi0tIA0KMi43LjQNCg0K
