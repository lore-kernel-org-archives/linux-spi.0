From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 14/14] arm64: defconfig: Enable SDMA on i.mx8mq/8mm
Date: Wed, 22 May 2019 10:01:03 +0000
Message-ID: <1558548188-1155-15-git-send-email-yibin.gong@nxp.com>
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

RW5hYmxlIFNETUEgc3VwcG9ydCBvbiBpLm14OG1xLzhtbSBjaGlwcywgaW5jbHVkaW5nIGVuYWJs
aW5nDQpDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSL0NPTkZJR19GV19MT0FERVJfVVNFUl9I
RUxQRVJfRkFMTEJBQ0sNCmZvciBmaXJtd2FyZSBsb2FkZWQgYnkgdWRldi4NCg0KU2lnbmVkLW9m
Zi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZyB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvYXJt
NjQvY29uZmlncy9kZWZjb25maWcNCmluZGV4IGMxMmM1MDUuLjJmZmVhMzAgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQorKysgYi9hcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnDQpAQCAtMTk4LDYgKzE5OCw4IEBAIENPTkZJR19QQ0lFX0hJU0lfU1RCPXkNCiBD
T05GSUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIg0KIENPTkZJR19ERVZUTVBG
Uz15DQogQ09ORklHX0RFVlRNUEZTX01PVU5UPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVM
UEVSPXkNCitDT05GSUdfRldfTE9BREVSX1VTRVJfSEVMUEVSX0ZBTExCQUNLPXkNCiBDT05GSUdf
SElTSUxJQ09OX0xQQz15DQogQ09ORklHX1NJTVBMRV9QTV9CVVM9eQ0KIENPTkZJR19NVEQ9eQ0K
QEAgLTYzMCw2ICs2MzIsNyBAQCBDT05GSUdfUlRDX0RSVl9JTVhfU0M9bQ0KIENPTkZJR19SVENf
RFJWX1hHRU5FPXkNCiBDT05GSUdfRE1BREVWSUNFUz15DQogQ09ORklHX0RNQV9CQ00yODM1PW0N
CitDT05GSUdfSU1YX1NETUE9eQ0KIENPTkZJR19LM19ETUE9eQ0KIENPTkZJR19NVl9YT1I9eQ0K
IENPTkZJR19NVl9YT1JfVjI9eQ0KLS0gDQoyLjcuNA0KDQo=
