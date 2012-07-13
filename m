From: y@pengutronix.de
Subject: [PATCH 08/11] spi/spi-omap2-mcspi: add a const qualifier
Date: Fri, 13 Jul 2012 14:32:11 +0200
Message-ID: <34420.6483023756$1342183215@news.gmane.org>
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
dGhpcyBjaGFuZ2UKdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdvdWxkIG9jY3VyOgoKCWRyaXZlcnMv
c3BpL3NwaS1vbWFwMi1tY3NwaS5jOiBJbiBmdW5jdGlvbiAnb21hcDJfbWNzcGlfcHJvYmUnOgoJ
ZHJpdmVycy9zcGkvc3BpLW9tYXAyLW1jc3BpLmM6MTExODogd2FybmluZzogYXNzaWdubWVudCBk
aXNjYXJkcyBxdWFsaWZpZXJzIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZQoKU2lnbmVkLW9mZi1i
eTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KQ2M6
IHNwaS1kZXZlbC1nZW5lcmFsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAotLS0KIGRyaXZlcnMvc3Bp
L3NwaS1vbWFwMi1tY3NwaS5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLW9tYXAyLW1j
c3BpLmMgYi9kcml2ZXJzL3NwaS9zcGktb21hcDItbWNzcGkuYwppbmRleCAwYzczZGQ0Li4zNDU1
NzY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9zcGktb21hcDItbWNzcGkuYworKysgYi9kcml2
ZXJzL3NwaS9zcGktb21hcDItbWNzcGkuYwpAQCAtMTA4Nyw3ICsxMDg3LDcgQEAgTU9EVUxFX0RF
VklDRV9UQUJMRShvZiwgb21hcF9tY3NwaV9vZl9tYXRjaCk7CiBzdGF0aWMgaW50IF9fZGV2aW5p
dCBvbWFwMl9tY3NwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewogCXN0
cnVjdCBzcGlfbWFzdGVyCSptYXN0ZXI7Ci0Jc3RydWN0IG9tYXAyX21jc3BpX3BsYXRmb3JtX2Nv
bmZpZyAqcGRhdGE7CisJY29uc3Qgc3RydWN0IG9tYXAyX21jc3BpX3BsYXRmb3JtX2NvbmZpZyAq
cGRhdGE7CiAJc3RydWN0IG9tYXAyX21jc3BpCSptY3NwaTsKIAlzdHJ1Y3QgcmVzb3VyY2UJCSpy
OwogCWludAkJCXN0YXR1cyA9IDAsIGk7Ci0tIAoxLjcuMTAuNAoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
