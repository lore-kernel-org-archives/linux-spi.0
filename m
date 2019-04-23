From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 1/3] spi: lpspi: add NULL check when probe device
Date: Tue, 23 Apr 2019 10:46:20 +0000
Message-ID: <20190423104649.24483-2-xiaoning.wang@nxp.com>
References: <20190423104649.24483-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423104649.24483-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

QWRkIGEgTlVMTCBjaGVjayBmb3IgZGV2aWNlIG5vZGUgYW5kIGxwc3BpX3BsYXRmb3JtX2luZm8g
d2hlbiBscHNwaQ0KZGV2aWNlIHByb2JlLg0KDQpTaWduZWQtb2ZmLWJ5OiBDbGFyayBXYW5nIDx4
aWFvbmluZy53YW5nQG54cC5jb20+DQpBY2tlZC1ieTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFu
QG54cC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktZnNsLWxwc3BpLmMgfCA1ICsrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
cGkvc3BpLWZzbC1scHNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQppbmRleCBk
MDhlOTMyNDE0MGUuLjE5MDQwYjVlZjM0OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL3NwaS1m
c2wtbHBzcGkuYw0KKysrIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQpAQCAtODQ1LDYg
Kzg0NSwxMSBAQCBzdGF0aWMgaW50IGZzbF9scHNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KIAl1MzIgdGVtcDsNCiAJYm9vbCBpc19zbGF2ZTsNCiANCisJaWYgKCFucCAm
JiAhbHBzcGlfcGxhdGZvcm1faW5mbykgew0KKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiY2FuJ3Qg
Z2V0IHRoZSBwbGF0Zm9ybSBkYXRhXG4iKTsNCisJCXJldHVybiAtRUlOVkFMOw0KKwl9DQorDQog
CWlzX3NsYXZlID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKCgmcGRldi0+ZGV2KS0+b2Zfbm9kZSwg
InNwaS1zbGF2ZSIpOw0KIAlpZiAoaXNfc2xhdmUpDQogCQljb250cm9sbGVyID0gc3BpX2FsbG9j
X3NsYXZlKCZwZGV2LT5kZXYsDQotLSANCjIuMTcuMQ0KDQo=
