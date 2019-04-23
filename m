From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 06/15] spi: imx: fix ERR009165
Date: Tue, 23 Apr 2019 13:51:05 +0000
Message-ID: <1556027045-5269-7-git-send-email-yibin.gong@nxp.com>
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

Q2hhbmdlIHRvIFhDSCAgbW9kZSBldmVuIGluIGRtYSBtb2RlLCBwbGVhc2UgcmVmZXIgdG8gdGhl
IGJlbG93DQplcnJhdGE6DQpodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZXJyYXRhL0lNWDZE
UUNFLnBkZg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+
DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktaW14LmMgfCAxMSArKysrKy0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3NwaS9zcGktaW14LmMgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMNCmluZGV4IDA5Yzlh
MWUuLmViNTZlYWMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NwaS9zcGktaW14LmMNCisrKyBiL2Ry
aXZlcnMvc3BpL3NwaS1pbXguYw0KQEAgLTU4NSw4ICs1ODUsOSBAQCBzdGF0aWMgaW50IG14NTFf
ZWNzcGlfcHJlcGFyZV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14LA0KIAlj
dHJsIHw9IG14NTFfZWNzcGlfY2xrZGl2KHNwaV9pbXgsIHQtPnNwZWVkX2h6LCAmY2xrKTsNCiAJ
c3BpX2lteC0+c3BpX2J1c19jbGsgPSBjbGs7DQogDQorCS8qIEVSUjAwOTE2NTogd29yayBpbiBY
SEMgbW9kZSBhcyBQSU8gKi8NCiAJaWYgKHNwaV9pbXgtPnVzZWRtYSkNCi0JCWN0cmwgfD0gTVg1
MV9FQ1NQSV9DVFJMX1NNQzsNCisJCWN0cmwgJj0gfk1YNTFfRUNTUElfQ1RSTF9TTUM7DQogDQog
CXdyaXRlbChjdHJsLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9DVFJMKTsNCiANCkBAIC02
MTIsMTIgKzYxMywxNCBAQCBzdGF0aWMgaW50IG14NTFfZWNzcGlfcHJlcGFyZV90cmFuc2Zlcihz
dHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14LA0KIA0KIHN0YXRpYyB2b2lkIG14NTFfc2V0dXBf
d21sKHN0cnVjdCBzcGlfaW14X2RhdGEgKnNwaV9pbXgpDQogew0KKwl1MzIgdHhfd21sID0gMDsN
CisNCiAJLyoNCiAJICogQ29uZmlndXJlIHRoZSBETUEgcmVnaXN0ZXI6IHNldHVwIHRoZSB3YXRl
cm1hcmsNCiAJICogYW5kIGVuYWJsZSBETUEgcmVxdWVzdC4NCiAJICovDQogCXdyaXRlbChNWDUx
X0VDU1BJX0RNQV9SWF9XTUwoc3BpX2lteC0+d21sIC0gMSkgfA0KLQkJTVg1MV9FQ1NQSV9ETUFf
VFhfV01MKHNwaV9pbXgtPndtbCkgfA0KKwkJTVg1MV9FQ1NQSV9ETUFfVFhfV01MKHR4X3dtbCkg
fA0KIAkJTVg1MV9FQ1NQSV9ETUFfUlhUX1dNTChzcGlfaW14LT53bWwpIHwNCiAJCU1YNTFfRUNT
UElfRE1BX1RFREVOIHwgTVg1MV9FQ1NQSV9ETUFfUlhERU4gfA0KIAkJTVg1MV9FQ1NQSV9ETUFf
UlhUREVOLCBzcGlfaW14LT5iYXNlICsgTVg1MV9FQ1NQSV9ETUEpOw0KQEAgLTEyNjUsMTAgKzEy
NjgsNiBAQCBzdGF0aWMgaW50IHNwaV9pbXhfc2RtYV9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwg
c3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwNCiB7DQogCWludCByZXQ7DQogDQotCS8qIHVz
ZSBwaW8gbW9kZSBmb3IgaS5teDZkbCBjaGlwIFRLVDIzODI4NSAqLw0KLQlpZiAob2ZfbWFjaGlu
ZV9pc19jb21wYXRpYmxlKCJmc2wsaW14NmRsIikpDQotCQlyZXR1cm4gMDsNCi0NCiAJc3BpX2lt
eC0+d21sID0gc3BpX2lteC0+ZGV2dHlwZV9kYXRhLT5maWZvX3NpemUgLyAyOw0KIA0KIAkvKiBQ
cmVwYXJlIGZvciBUWCBETUE6ICovDQotLSANCjIuNy40DQoNCg==
