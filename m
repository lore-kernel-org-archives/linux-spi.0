From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 15/15] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Date: Tue, 23 Apr 2019 13:51:50 +0000
Message-ID: <1556027045-5269-16-git-send-email-yibin.gong@nxp.com>
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

RW5hYmxlIFNETUEgc3VwcG9ydCBvbiBpLm14OG1xLzhtbSBjaGlwcywgaW5jbHVkaW5nIGVuYWJs
aW5nDQpDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSL0NPTkZJR19GV19MT0FERVJfVVNFUl9I
RUxQRVJfRkFMTEJBQ0sNCmZvciBmaXJtd2FyZSBsb2FkZWQgYnkgdWRldi4NCg0KU2lnbmVkLW9m
Zi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZyB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvYXJt
NjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IDE3ZGFhOTcuLjcwODE4MTcgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnDQpAQCAtMjAzLDYgKzIwMyw4IEBAIENPTkZJR19ORVRfOVBfVklSVElPPXkNCiBD
T05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIg0KIENPTkZJR19ERVZUTVBG
Uz15DQogQ09ORklHX0RFVlRNUEZTX01PVU5UPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVM
UEVSPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSX0ZBTExCQUNLPXkNCiBDT05GSUdf
RE1BX0NNQT15DQogQ09ORklHX0NNQV9TSVpFX01CWVRFUz0zMg0KIENPTkZJR19ISVNJTElDT05f
TFBDPXkNCkBAIC02MzUsNiArNjM3LDcgQEAgQ09ORklHX1JUQ19EUlZfSU1YX1NDPW0NCiBDT05G
SUdfUlRDX0RSVl9YR0VORT15DQogQ09ORklHX0RNQURFVklDRVM9eQ0KIENPTkZJR19ETUFfQkNN
MjgzNT1tDQorQ09ORklHX0lNWF9TRE1BPXkNCiBDT05GSUdfSzNfRE1BPXkNCiBDT05GSUdfTVZf
WE9SX1YyPXkNCiBDT05GSUdfUEwzMzBfRE1BPXkNCi0tIA0KMi43LjQNCg0K
