From: Zhao Qiang <B45475@freescale.com>
Subject: [PATCH] spi: include "int ret" with macro
Date: Wed, 25 Jun 2014 09:54:36 +0800
Message-ID: <1403661276-16598-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <broonie@kernel.org>,
 <linux-spi@vger.kernel.org>, <B07421@freescale.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Id: linux-spi.vger.kernel.org

cmV0IGlzIHVudXNlZCB3aGVuIENPTkZJR19GU0xfU09DIGRlZmluZWQsCnNvIGluY2x1ZGUgaXQg
d2l0aCAiI2lmbmRlZiBDT05GSUdfRlNMX1NPQyIuCgpTaWduZWQtb2ZmLWJ5OiBaaGFvIFFpYW5n
IDxCNDU0NzVAZnJlZXNjYWxlLmNvbT4KLS0tCiBkcml2ZXJzL3NwaS9zcGktZnNsLWxpYi5jIHwg
MyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZnNsLWxpYi5jIGIvZHJpdmVycy9zcGkvc3BpLWZz
bC1saWIuYwppbmRleCBlNWQ0NWZjLi40NGFhY2UxIDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9z
cGktZnNsLWxpYi5jCisrKyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wtbGliLmMKQEAgLTE5OCw4ICsx
OTgsOSBAQCBpbnQgb2ZfbXBjOHh4eF9zcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
b2ZkZXYpCiAJc3RydWN0IG1wYzh4eHhfc3BpX3Byb2JlX2luZm8gKnBpbmZvOwogCXN0cnVjdCBm
c2xfc3BpX3BsYXRmb3JtX2RhdGEgKnBkYXRhOwogCWNvbnN0IHZvaWQgKnByb3A7CisjaWZuZGVm
IENPTkZJR19GU0xfU09DCiAJaW50IHJldCA9IC1FTk9NRU07Ci0KKyNlbmRpZgogCXBpbmZvID0g
ZGV2bV9remFsbG9jKCZvZmRldi0+ZGV2LCBzaXplb2YoKnBpbmZvKSwgR0ZQX0tFUk5FTCk7CiAJ
aWYgKCFwaW5mbykKIAkJcmV0dXJuIC1FTk9NRU07Ci0tIAoxLjguNQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlz
dApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcv
bGlzdGluZm8vbGludXhwcGMtZGV2
