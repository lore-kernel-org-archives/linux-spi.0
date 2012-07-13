From: y@pengutronix.de
Subject: [PATCH 01/11] spi/imx: make spi_imx_data.devtype_data member point to
 const data
Date: Fri, 13 Jul 2012 14:32:04 +0200
Message-ID: <12235.1258447909$1342183564@news.gmane.org>
References: <1342182734-321-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 kernel@pengutronix.de,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>,
	Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1342182734-321-1-git-send-email-y>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
ClRoaXMgcHJlcGFyZXMgb2ZfZGV2aWNlX2lkLmRhdGEgYmVjb21pbmcgY29uc3QuIFdpdGhvdXQg
dGhpcyBjaGFuZ2UgdGhlCmZvbGxvd2luZyB3YXJuaW5nIHdvdWxkIG9jY3VyOgoKCWRyaXZlcnMv
c3BpL3NwaS1pbXguYzogSW4gZnVuY3Rpb24gc3BpX2lteF9wcm9iZToKCWRyaXZlcnMvc3BpL3Nw
aS1pbXguYzo4MTQ6MjQ6IHdhcm5pbmc6IGFzc2lnbm1lbnQgZGlzY2FyZHMgY29uc3QgcXVhbGlm
aWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbZW5hYmxlZCBieSBkZWZhdWx0XQoKU2lnbmVk
LW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5k
ZT4KQ2M6IHNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAotLS0KIGRyaXZl
cnMvc3BpL3NwaS1pbXguYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYyBiL2Ry
aXZlcnMvc3BpL3NwaS1pbXguYwppbmRleCA0Nzg3N2Q2Li5iMDlmYzc3IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3NwaS9zcGktaW14LmMKKysrIGIvZHJpdmVycy9zcGkvc3BpLWlteC5jCkBAIC05Nyw3
ICs5Nyw3IEBAIHN0cnVjdCBzcGlfaW14X2RhdGEgewogCWNvbnN0IHZvaWQgKnR4X2J1ZjsKIAl1
bnNpZ25lZCBpbnQgdHhmaWZvOyAvKiBudW1iZXIgb2Ygd29yZHMgcHVzaGVkIGluIHR4IEZJRk8g
Ki8KIAotCXN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YSAqZGV2dHlwZV9kYXRhOworCWNvbnN0
IHN0cnVjdCBzcGlfaW14X2RldnR5cGVfZGF0YSAqZGV2dHlwZV9kYXRhOwogCWludCBjaGlwc2Vs
ZWN0WzBdOwogfTsKIAotLSAKMS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
