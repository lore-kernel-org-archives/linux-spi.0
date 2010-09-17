From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 01/16] spi/imx: default to m on platforms that have such
	devices
Date: Fri, 17 Sep 2010 11:54:19 +0200
Message-ID: <1284717274-12850-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	Sascha Hauer <s.hauer@pengutronix.de>, amit.kucheria@canonical.com,
	linux-arm-kernel@lists.infradead.org
To: Jason Wang <jason77.wang@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
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

U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4KLS0tCiBkcml2ZXJzL3NwaS9LY29uZmlnIHwgICAgMSArCiAxIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3NwaS9LY29uZmlnIGIvZHJpdmVycy9zcGkvS2NvbmZpZwppbmRleCA5MWMyZjRmLi4zMGFlYTZk
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3NwaS9LY29uZmlnCisrKyBiL2RyaXZlcnMvc3BpL0tjb25m
aWcKQEAgLTE0Nyw2ICsxNDcsNyBAQCBjb25maWcgU1BJX0lNWAogCXRyaXN0YXRlICJGcmVlc2Nh
bGUgaS5NWCBTUEkgY29udHJvbGxlcnMiCiAJZGVwZW5kcyBvbiBBUkNIX01YQwogCXNlbGVjdCBT
UElfQklUQkFORworCWRlZmF1bHQgbSBpZiBJTVhfSEFWRV9QTEFURk9STV9TUElfSU1YCiAJaGVs
cAogCSAgVGhpcyBlbmFibGVzIHVzaW5nIHRoZSBGcmVlc2NhbGUgaS5NWCBTUEkgY29udHJvbGxl
cnMgaW4gbWFzdGVyCiAJICBtb2RlLgotLSAKMS43LjIuMwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
